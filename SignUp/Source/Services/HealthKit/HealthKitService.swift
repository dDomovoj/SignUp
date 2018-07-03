//
//  HealthKitService.swift
//  SignUp
//
//  Created by Dmitry Duleba on 7/2/18.
//  Copyright © 2018 Home. All rights reserved.
//

import Foundation
import HealthKit
import struct UIKit.CGFloat

private typealias AuthToken = String

// MARK: Result

extension HealthKitService {
  enum Result {
    case succeeded
    case failed(Swift.Error)
  }
}

// MARK: Error

extension HealthKitService {
  enum Error: Swift.Error {
    case notAvailableOnDevice
    case notAuthorized
    case dataTypeNotAvailable(String)
    case updateNotAvailable(String)
    case unknown
  }
}

// MARK: SyncPolicy

extension HealthKitService {
  enum SyncPolicy {
    case readonly
    case readwrite
  }
}

// MARK: - LoggingPolicy

extension HealthKitService {
  enum LoggingPolicy {
    case disabled
    case errors
    case all
  }
}

// MARK: - HealthKitService

final class HealthKitService {

  static let instance = HealthKitService()

  // MARK: - Properties

  private let healthStore = HKHealthStore()

  var syncPolicy: SyncPolicy { return .readonly }

  var loggingPolicy: LoggingPolicy { return .all }

  var fetchedCharacteristicTypes: [HKCharacteristicTypeIdentifier] {
    return [.biologicalSex, .dateOfBirth]
  }

  var fetchedQuantityTypes: [HKQuantityTypeIdentifier] {
    return [.height, .bodyMass]
  }

  private var authChecksum: Int = 0

  // MARK: - Init

  private init() { }

  // MARK: - Lifecycle

  func authorize(completion: @escaping (_ result: Result) -> Void) {
    guard HKHealthStore.isHealthDataAvailable() else {
      completion(.failed(Error.notAvailableOnDevice))
      return
    }

    let characteristicTypes = fetchedCharacteristicTypes.compactMap { id -> HKCharacteristicType? in
      let result = HKObjectType.characteristicType(forIdentifier: id)
      if result == nil {
        completion(.failed(Error.dataTypeNotAvailable(id.rawValue)))
      }
      return result
    }
    let quantityTypes = fetchedQuantityTypes.compactMap { id -> HKQuantityType? in
      let result = HKObjectType.quantityType(forIdentifier: id)
      if result == nil {
        completion(.failed(Error.dataTypeNotAvailable(id.rawValue)))
      }
      return result
    }

    let expectedCount = fetchedQuantityTypes.count + fetchedCharacteristicTypes.count
    let actualCount = quantityTypes.count + characteristicTypes.count
    guard expectedCount == actualCount else {
      return
    }

    let objectTypes: [HKObjectType] = characteristicTypes as [HKObjectType] + quantityTypes as [HKObjectType]
    let checksum = objectTypes.map { $0.hashValue } .reduce(0) { $0 ^ $1 }
    if checksum == authChecksum {
      completion(.succeeded)
      return
    }

    let authCompletion: (Bool, Swift.Error?) -> Void = { [weak self] success, error in
      guard success else {
        completion(.failed(error ?? Error.unknown))
        return
      }
      self?.authChecksum = checksum
      completion(.succeeded)
    }

    let values = Set(objectTypes)
    switch syncPolicy {
    case .readonly:
      healthStore.requestAuthorization(toShare: nil, read: values, completion: authCompletion)
    case .readwrite:
      let sampleTypes = objectTypes.compactMap { $0 as? HKSampleType }
      let samples = Set(sampleTypes)
      healthStore.requestAuthorization(toShare: samples, read: values, completion: authCompletion)
    }
  }

  // MARK: - Accessors

  // MARK: Gender
  var gender: UserProfile.Gender? {
    get {
      do {
        return try healthStore.biologicalSex().biologicalSex.genderValue
      } catch {
        logIfNeeded(.failed(error))
        return nil
      }
    }
    set {
      guard shouldSave else { return }

      logIfNeeded(.failed(Error.updateNotAvailable("\(#function)")))
    }
  }

  // MARK: DoB
  var dateOfBirth: Date? {
    get {
      do {
        if #available(iOS 10.0, *) {
          let components = try healthStore.dateOfBirthComponents()
          let date = Calendar.current.date(from: components)
          return date
        } else {
          return try healthStore.dateOfBirth()
        }
      } catch {
        logIfNeeded(.failed(error))
        return nil
      }
    }
    set {
      guard shouldSave else { return }

      logIfNeeded(.failed(Error.updateNotAvailable("\(#function)")))
    }
  }

  // MARK: Height
  func height(_ completion: @escaping (CGFloat?) -> Void) {
    mostRecentSample(for: .height) { [weak self] sample, error in
      sample.with {
        let doubleValue = $0.quantity.doubleValue(for: .meter())
        completion(CGFloat(doubleValue))
      }
      error.with { self?.logIfNeeded(.failed($0)) }
    }
  }

  func setHeight(_ height: CGFloat) {
    guard shouldSave else { return }

    let quantity = HKQuantity(unit: HKUnit.gramUnit(with: .kilo), doubleValue: Double(height))
    updateMostRecentSample(for: .height, with: quantity) { [weak self] in
      self?.logIfNeeded($0, successMessage: "Height sample updated with: \(height.formatted(".3"))")
    }
  }

  // MARK: Body mass
  func bodyMass(_ completion: @escaping (CGFloat?) -> Void) {
    mostRecentSample(for: .bodyMass) { [weak self] sample, error in
      sample.with {
        let doubleValue = $0.quantity.doubleValue(for: HKUnit.gramUnit(with: .kilo))
        completion(CGFloat(doubleValue))
      }
      error.with { self?.logIfNeeded(.failed($0)) }
    }
  }

  func setBodyMass(_ bodyMass: CGFloat) {
    guard shouldSave else { return }

    let quantity = HKQuantity(unit: HKUnit.gramUnit(with: .kilo), doubleValue: Double(bodyMass))
    updateMostRecentSample(for: .height, with: quantity) { [weak self] in
      self?.logIfNeeded($0, successMessage: "Body mass sample updated with: \(bodyMass.formatted(".3"))")
    }
  }
}

// MARK: - Private

private extension HealthKitService {

  var shouldSave: Bool { return syncPolicy == .readwrite }

  func mostRecentSample(for quantityType: HKQuantityTypeIdentifier,
                        completion: @escaping (HKQuantitySample?, Swift.Error?) -> Swift.Void) {
    guard let sampleType = HKObjectType.quantityType(forIdentifier: quantityType) else {
      DispatchQueue.main.async {
        completion(nil, Error.dataTypeNotAvailable(quantityType.rawValue))
      }
      return
    }

    let predicate = HKQuery.predicateForSamples(withStart: Date.distantPast, end: Date(), options: .strictEndDate)
    let sort = [NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)]
    let query =
      HKSampleQuery(sampleType: sampleType, predicate: predicate, limit: 1, sortDescriptors: sort,
                    resultsHandler: { _, samples, error in
                      DispatchQueue.main.async {
                        guard let samples = samples, let mostRecent = samples.first as? HKQuantitySample else {
                          completion(nil, error)
                          return
                        }

                        completion(mostRecent, nil)
                      }
      })
    healthStore.execute(query)
  }

  func updateMostRecentSample(for quantityType: HKQuantityTypeIdentifier, with quantity: HKQuantity,
                              date: Date = Date(), completion: ((Result) -> Void)? = nil) {
    guard let sampleType = HKQuantityType.quantityType(forIdentifier: quantityType) else {
      DispatchQueue.main.async {
        completion?(.failed(Error.dataTypeNotAvailable(quantityType.rawValue)))
      }
      return
    }

    let sample = HKQuantitySample(type: sampleType, quantity: quantity, start: date, end: date)
    healthStore.save(sample) { succeeded, error in
      guard let completion = completion else { return }

      DispatchQueue.main.async {
        if succeeded {
          completion(.succeeded)
        } else {
          completion(.failed(error ?? Error.unknown))
        }
      }
    }
  }

  // MARK: Logging

  func logIfNeeded(_ result: Result, successMessage: String = "") {
    switch (loggingPolicy, result) {
    case (.disabled, _): return
    case (_, .failed(let error)):
      print(error.localizedDescription)
    case (.all, _):
      let suffix = successMessage.length > 0 ? ": \(successMessage)" : ""
      print("Succeeded" + suffix)
    default: return
    }
  }
}

// MARK: - HKBiologicalSex

fileprivate extension HKBiologicalSex {

  var genderValue: UserProfile.Gender? {
    switch self {
    case .female: return .female
    case .male: return .male
    default: return nil
    }
  }
}
