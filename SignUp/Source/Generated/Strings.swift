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

  internal enum SignIn {
    /// Sign In
    internal static let title = L10n.tr("Localizable", "sign_in.title")
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
}
// swiftlint:enable explicit_type_interface identifier_name line_length nesting type_body_length type_name

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
