// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// swiftlint:disable explicit_type_interface identifier_name line_length nesting type_body_length type_name
internal enum L10n {

  internal enum Alerts {

    internal enum Buttons {
      /// Cancel
      internal static let cancel = L10n.tr("Localizable", "alerts.buttons.cancel")
      /// OK
      internal static let ok = L10n.tr("Localizable", "alerts.buttons.ok")
    }
  }

  internal enum Common {

    internal enum Buttons {
      /// Finish
      internal static let finish = L10n.tr("Localizable", "common.buttons.finish")
      /// Hide
      internal static let hide = L10n.tr("Localizable", "common.buttons.hide")
      /// Next
      internal static let next = L10n.tr("Localizable", "common.buttons.next")
    }

    internal enum Metrics {

      internal enum Length {
        /// cm
        internal static let centimeters = L10n.tr("Localizable", "common.metrics.length.centimeters")
        /// ft
        internal static let feet = L10n.tr("Localizable", "common.metrics.length.feet")
        /// inches
        internal static let inches = L10n.tr("Localizable", "common.metrics.length.inches")
        /// m
        internal static let meters = L10n.tr("Localizable", "common.metrics.length.meters")
      }

      internal enum Time {
        /// week
        internal static let week = L10n.tr("Localizable", "common.metrics.time.week")
      }

      internal enum Weight {
        /// kg
        internal static let kilos = L10n.tr("Localizable", "common.metrics.weight.kilos")
        /// kilograms
        internal static let kilosFull = L10n.tr("Localizable", "common.metrics.weight.kilos_full")
        /// lb
        internal static let pounds = L10n.tr("Localizable", "common.metrics.weight.pounds")
        /// pounds
        internal static let poundsFull = L10n.tr("Localizable", "common.metrics.weight.pounds_full")
      }
    }
  }

  internal enum CurrentWeight {
    /// Enter your current weight in %@ as of today, e.g %@
    internal static func text(_ p1: String, _ p2: String) -> String {
      return L10n.tr("Localizable", "current_weight.text", p1, p2)
    }
    /// Current Weight
    internal static let title = L10n.tr("Localizable", "current_weight.title")
    /// Use metrics units
    internal static let useMetricsUnits = L10n.tr("Localizable", "current_weight.use_metrics_units")
  }

  internal enum DateOfBirth {
    /// Enter your date of birth. It will be used to calculate your age.
    internal static let text = L10n.tr("Localizable", "date_of_birth.text")
    /// Date of Birth
    internal static let title = L10n.tr("Localizable", "date_of_birth.title")
  }

  internal enum GetStarted {
    /// Import your current weight, height, and date of birth from the Health App, to get you started faster
    internal static let adviceText = L10n.tr("Localizable", "get_started.advice_text")
    /// Use Health App data
    internal static let healthAppDataUsage = L10n.tr("Localizable", "get_started.health_app_data_usage")
    /// Enter your gender, it’s important for\ncalories calculation - female bodies\nneed fewer calories
    internal static let text = L10n.tr("Localizable", "get_started.text")
    /// Get Started
    internal static let title = L10n.tr("Localizable", "get_started.title")

    internal enum Buttons {
      /// Female
      internal static let female = L10n.tr("Localizable", "get_started.buttons.female")
      /// Male
      internal static let male = L10n.tr("Localizable", "get_started.buttons.male")
    }
  }

  internal enum SignIn {
    /// Sign In
    internal static let title = L10n.tr("Localizable", "sign_in.title")
  }

  internal enum TargetDailyCalories {
    /// by
    internal static let by = L10n.tr("Localizable", "target_daily_calories.by")
    /// A steady rate, such as losing %@, makes you more successful in the long run.
    internal static func losingWeightText(_ p1: String) -> String {
      return L10n.tr("Localizable", "target_daily_calories.losing_weight_text", p1)
    }
    /// Now
    internal static let now = L10n.tr("Localizable", "target_daily_calories.now")
    /// Target Date
    internal static let targetDate = L10n.tr("Localizable", "target_daily_calories.target_date")
    /// Target Daily Calories
    internal static let title = L10n.tr("Localizable", "target_daily_calories.title")
    /// Weekly Rate
    internal static let weeklyRate = L10n.tr("Localizable", "target_daily_calories.weekly_rate")
    /// Select target date or weekly rate to calculate target daily calories. %@\n\nYou can override and customize MyNetDiary’s calculations on the detailed Plan screen in the app.
    internal static func weightText(_ p1: String) -> String {
      return L10n.tr("Localizable", "target_daily_calories.weight_text", p1)
    }
  }

  internal enum TargetWeight {
    /// Enter your target weight in %@, e.g %@
    internal static func text(_ p1: String, _ p2: String) -> String {
      return L10n.tr("Localizable", "target_weight.text", p1, p2)
    }
    /// Target Weight
    internal static let title = L10n.tr("Localizable", "target_weight.title")
  }

  internal enum Welcome {

    internal enum Buttons {
      /// I’m new
      internal static let imNew = L10n.tr("Localizable", "welcome.buttons.i_m_new")

      internal enum SignIn {
        /// Already used MyNetDiary
        internal static let subtitle = L10n.tr("Localizable", "welcome.buttons.sign_in.subtitle")
        /// Sign In
        internal static let title = L10n.tr("Localizable", "welcome.buttons.sign_in.title")
      }
    }

    internal enum Paging {

      internal enum Fifth {
        /// More than just losing weight -\nMyNetDiary helps you make healthy food choices and get more active.
        internal static let text = L10n.tr("Localizable", "welcome.paging.fifth.text")
        /// Be healthy
        internal static let title = L10n.tr("Localizable", "welcome.paging.fifth.title")
      }

      internal enum First {
        /// MyNetDiary
        internal static let highlight = L10n.tr("Localizable", "welcome.paging.first.highlight")
        /// Achieve your weight and health\ngoals by tracking food and\neating better. Get active and\nstay motivated!
        internal static let text = L10n.tr("Localizable", "welcome.paging.first.text")
        /// Welcome\nto MyNetDiary
        internal static let title = L10n.tr("Localizable", "welcome.paging.first.title")
      }

      internal enum Fourth {
        /// Use our expert tips and connect with friends, family, and our community.
        internal static let text = L10n.tr("Localizable", "welcome.paging.fourth.text")
        /// Get motivated
        internal static let title = L10n.tr("Localizable", "welcome.paging.fourth.title")
      }

      internal enum Second {
        /// MyNetDiary helps to create a\npersonalized plan that will help you get where you want to be.
        internal static let text = L10n.tr("Localizable", "welcome.paging.second.text")
        /// Plan your goals
        internal static let title = L10n.tr("Localizable", "welcome.paging.second.title")
      }

      internal enum Third {
        /// Huge food database and barcode scanning make food entry a breeze.
        internal static let text = L10n.tr("Localizable", "welcome.paging.third.text")
        /// Track food and exercise
        internal static let title = L10n.tr("Localizable", "welcome.paging.third.title")
      }
    }
  }

  internal enum YourHeight {
    /// Enter your height - the taller you are, the more calories your body needs
    internal static let text = L10n.tr("Localizable", "your_height.text")
    /// Your Height
    internal static let title = L10n.tr("Localizable", "your_height.title")
  }
}
// swiftlint:enable explicit_type_interface identifier_name line_length nesting type_body_length type_name

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
