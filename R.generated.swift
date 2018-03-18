//
// This is a generated file, do not edit!
// Generated by R.swift, see https://github.com/mac-cain13/R.swift
//

import Foundation
import Rswift
import UIKit

/// This `R` struct is generated and contains references to static resources.
struct R: Rswift.Validatable {
  fileprivate static let applicationLocale = hostingBundle.preferredLocalizations.first.flatMap(Locale.init) ?? Locale.current
  fileprivate static let hostingBundle = Bundle(for: R.Class.self)
  
  static func validate() throws {
    try intern.validate()
  }
  
  /// This `R.clr` struct is generated, and contains static references to 1 color palettes.
  /// NOTE: R.clr is deprecated and will be removed in a future R.swift version.
  struct clr {
    /// This `R.clr.podoColors` struct is generated, and contains static references to 6 colors.
    struct podoColors {
      /// <span style='background-color: #33CCFF; color: #CC3300; padding: 1px 3px;'>#33CCFF</span> blue
      static let blue = Rswift.ColorPaletteItemResource(name: "blue", red: 0.2, green: 0.8, blue: 1.0, alpha: 1.0)
      /// <span style='background-color: #43D551; color: #BC2AAE; padding: 1px 3px;'>#43D551</span> green-IB
      static let greenIB = Rswift.ColorPaletteItemResource(name: "green-IB", red: 0.262745098, green: 0.8352941176, blue: 0.3176470588, alpha: 1.0)
      /// <span style='background-color: #4CD964; color: #B3269B; padding: 1px 3px;'>#4CD964</span> green
      static let green = Rswift.ColorPaletteItemResource(name: "green", red: 0.2980392157, green: 0.8509803922, blue: 0.3921568627, alpha: 1.0)
      /// <span style='background-color: #F1F2ED; color: #0E0D12; padding: 1px 3px;'>#F1F2ED</span> background
      static let background = Rswift.ColorPaletteItemResource(name: "background", red: 0.9450980392, green: 0.9490196078, blue: 0.9294117647, alpha: 1.0)
      /// <span style='background-color: #FF9500; color: #006AFF; padding: 1px 3px;'>#FF9500</span> orange
      static let orange = Rswift.ColorPaletteItemResource(name: "orange", red: 1.0, green: 0.5843137255, blue: 0.0, alpha: 1.0)
      /// <span style='background-color: #FFFFFF; color: #000000; padding: 1px 3px;'>#FFFFFF</span> white
      static let white = Rswift.ColorPaletteItemResource(name: "white", red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
      
      /// <span style='background-color: #33CCFF; color: #CC3300; padding: 1px 3px;'>#33CCFF</span> blue
      /// 
      /// UIColor(red: 0.2, green: 0.8, blue: 1.0, alpha: 1.0)
      static func blue(_: Void = ()) -> UIKit.UIColor {
        return UIKit.UIColor(red: 0.2, green: 0.8, blue: 1.0, alpha: 1.0)
      }
      
      /// <span style='background-color: #43D551; color: #BC2AAE; padding: 1px 3px;'>#43D551</span> green-IB
      /// 
      /// UIColor(red: 0.262745098, green: 0.8352941176, blue: 0.3176470588, alpha: 1.0)
      static func greenIB(_: Void = ()) -> UIKit.UIColor {
        return UIKit.UIColor(red: 0.262745098, green: 0.8352941176, blue: 0.3176470588, alpha: 1.0)
      }
      
      /// <span style='background-color: #4CD964; color: #B3269B; padding: 1px 3px;'>#4CD964</span> green
      /// 
      /// UIColor(red: 0.2980392157, green: 0.8509803922, blue: 0.3921568627, alpha: 1.0)
      static func green(_: Void = ()) -> UIKit.UIColor {
        return UIKit.UIColor(red: 0.2980392157, green: 0.8509803922, blue: 0.3921568627, alpha: 1.0)
      }
      
      /// <span style='background-color: #F1F2ED; color: #0E0D12; padding: 1px 3px;'>#F1F2ED</span> background
      /// 
      /// UIColor(red: 0.9450980392, green: 0.9490196078, blue: 0.9294117647, alpha: 1.0)
      static func background(_: Void = ()) -> UIKit.UIColor {
        return UIKit.UIColor(red: 0.9450980392, green: 0.9490196078, blue: 0.9294117647, alpha: 1.0)
      }
      
      /// <span style='background-color: #FF9500; color: #006AFF; padding: 1px 3px;'>#FF9500</span> orange
      /// 
      /// UIColor(red: 1.0, green: 0.5843137255, blue: 0.0, alpha: 1.0)
      static func orange(_: Void = ()) -> UIKit.UIColor {
        return UIKit.UIColor(red: 1.0, green: 0.5843137255, blue: 0.0, alpha: 1.0)
      }
      
      /// <span style='background-color: #FFFFFF; color: #000000; padding: 1px 3px;'>#FFFFFF</span> white
      /// 
      /// UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
      static func white(_: Void = ()) -> UIKit.UIColor {
        return UIKit.UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
      }
      
      fileprivate init() {}
    }
    
    fileprivate init() {}
  }
  
  /// This `R.color` struct is generated, and contains static references to 0 colors.
  struct color {
    fileprivate init() {}
  }
  
  /// This `R.file` struct is generated, and contains static references to 2 files.
  struct file {
    /// Resource file `PodoColors.clr`.
    static let podoColorsClr = Rswift.FileResource(bundle: R.hostingBundle, name: "PodoColors", pathExtension: "clr")
    /// Resource file `sideMenuEntries.realm`.
    static let sideMenuEntriesRealm = Rswift.FileResource(bundle: R.hostingBundle, name: "sideMenuEntries", pathExtension: "realm")
    
    /// `bundle.url(forResource: "PodoColors", withExtension: "clr")`
    static func podoColorsClr(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.podoColorsClr
      return fileResource.bundle.url(forResource: fileResource)
    }
    
    /// `bundle.url(forResource: "sideMenuEntries", withExtension: "realm")`
    static func sideMenuEntriesRealm(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.sideMenuEntriesRealm
      return fileResource.bundle.url(forResource: fileResource)
    }
    
    fileprivate init() {}
  }
  
  /// This `R.font` struct is generated, and contains static references to 0 fonts.
  struct font {
    fileprivate init() {}
  }
  
  /// This `R.image` struct is generated, and contains static references to 4 images.
  struct image {
    /// Image `MetroTrainIcon`.
    static let metroTrainIcon = Rswift.ImageResource(bundle: R.hostingBundle, name: "MetroTrainIcon")
    /// Image `QuickActionSettings`.
    static let quickActionSettings = Rswift.ImageResource(bundle: R.hostingBundle, name: "QuickActionSettings")
    /// Image `SideMenuIcon`.
    static let sideMenuIcon = Rswift.ImageResource(bundle: R.hostingBundle, name: "SideMenuIcon")
    /// Image `TransportCardMask`.
    static let transportCardMask = Rswift.ImageResource(bundle: R.hostingBundle, name: "TransportCardMask")
    
    /// `UIImage(named: "MetroTrainIcon", bundle: ..., traitCollection: ...)`
    static func metroTrainIcon(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.metroTrainIcon, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "QuickActionSettings", bundle: ..., traitCollection: ...)`
    static func quickActionSettings(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.quickActionSettings, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "SideMenuIcon", bundle: ..., traitCollection: ...)`
    static func sideMenuIcon(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.sideMenuIcon, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "TransportCardMask", bundle: ..., traitCollection: ...)`
    static func transportCardMask(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.transportCardMask, compatibleWith: traitCollection)
    }
    
    fileprivate init() {}
  }
  
  /// This `R.nib` struct is generated, and contains static references to 3 nibs.
  struct nib {
    /// Nib `CardsCollectionViewCell`.
    static let cardsCollectionViewCell = _R.nib._CardsCollectionViewCell()
    /// Nib `MainMenuTableViewCell`.
    static let mainMenuTableViewCell = _R.nib._MainMenuTableViewCell()
    /// Nib `SideMenuTableViewCell`.
    static let sideMenuTableViewCell = _R.nib._SideMenuTableViewCell()
    
    /// `UINib(name: "CardsCollectionViewCell", in: bundle)`
    static func cardsCollectionViewCell(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.cardsCollectionViewCell)
    }
    
    /// `UINib(name: "MainMenuTableViewCell", in: bundle)`
    static func mainMenuTableViewCell(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.mainMenuTableViewCell)
    }
    
    /// `UINib(name: "SideMenuTableViewCell", in: bundle)`
    static func sideMenuTableViewCell(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.sideMenuTableViewCell)
    }
    
    fileprivate init() {}
  }
  
  /// This `R.reuseIdentifier` struct is generated, and contains static references to 3 reuse identifiers.
  struct reuseIdentifier {
    /// Reuse identifier `CardsCollectionViewCell`.
    static let cardsCollectionViewCell: Rswift.ReuseIdentifier<CardsCollectionViewCell> = Rswift.ReuseIdentifier(identifier: "CardsCollectionViewCell")
    /// Reuse identifier `MainMenuTableViewCell`.
    static let mainMenuTableViewCell: Rswift.ReuseIdentifier<MainMenuTableViewCell> = Rswift.ReuseIdentifier(identifier: "MainMenuTableViewCell")
    /// Reuse identifier `SideMenuTableViewCell`.
    static let sideMenuTableViewCell: Rswift.ReuseIdentifier<SideMenuTableViewCell> = Rswift.ReuseIdentifier(identifier: "SideMenuTableViewCell")
    
    fileprivate init() {}
  }
  
  /// This `R.segue` struct is generated, and contains static references to 0 view controllers.
  struct segue {
    fileprivate init() {}
  }
  
  /// This `R.storyboard` struct is generated, and contains static references to 6 storyboards.
  struct storyboard {
    /// Storyboard `CardsViewController`.
    static let cardsViewController = _R.storyboard.cardsViewController()
    /// Storyboard `LaunchScreen`.
    static let launchScreen = _R.storyboard.launchScreen()
    /// Storyboard `MainMenuViewController`.
    static let mainMenuViewController = _R.storyboard.mainMenuViewController()
    /// Storyboard `RootViewController`.
    static let rootViewController = _R.storyboard.rootViewController()
    /// Storyboard `SettingsViewController`.
    static let settingsViewController = _R.storyboard.settingsViewController()
    /// Storyboard `TutorialViewController`.
    static let tutorialViewController = _R.storyboard.tutorialViewController()
    
    /// `UIStoryboard(name: "CardsViewController", bundle: ...)`
    static func cardsViewController(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.cardsViewController)
    }
    
    /// `UIStoryboard(name: "LaunchScreen", bundle: ...)`
    static func launchScreen(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.launchScreen)
    }
    
    /// `UIStoryboard(name: "MainMenuViewController", bundle: ...)`
    static func mainMenuViewController(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.mainMenuViewController)
    }
    
    /// `UIStoryboard(name: "RootViewController", bundle: ...)`
    static func rootViewController(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.rootViewController)
    }
    
    /// `UIStoryboard(name: "SettingsViewController", bundle: ...)`
    static func settingsViewController(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.settingsViewController)
    }
    
    /// `UIStoryboard(name: "TutorialViewController", bundle: ...)`
    static func tutorialViewController(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.tutorialViewController)
    }
    
    fileprivate init() {}
  }
  
  /// This `R.string` struct is generated, and contains static references to 0 localization tables.
  struct string {
    fileprivate init() {}
  }
  
  fileprivate struct intern: Rswift.Validatable {
    fileprivate static func validate() throws {
      try _R.validate()
    }
    
    fileprivate init() {}
  }
  
  fileprivate class Class {}
  
  fileprivate init() {}
}

struct _R: Rswift.Validatable {
  static func validate() throws {
    try storyboard.validate()
    try nib.validate()
  }
  
  struct nib: Rswift.Validatable {
    static func validate() throws {
      try _CardsCollectionViewCell.validate()
    }
    
    struct _CardsCollectionViewCell: Rswift.NibResourceType, Rswift.ReuseIdentifierType, Rswift.Validatable {
      typealias ReusableType = CardsCollectionViewCell
      
      let bundle = R.hostingBundle
      let identifier = "CardsCollectionViewCell"
      let name = "CardsCollectionViewCell"
      
      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [NSObject : AnyObject]? = nil) -> CardsCollectionViewCell? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? CardsCollectionViewCell
      }
      
      static func validate() throws {
        if UIKit.UIImage(named: "TransportCardMask", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'TransportCardMask' is used in nib 'CardsCollectionViewCell', but couldn't be loaded.") }
      }
      
      fileprivate init() {}
    }
    
    struct _MainMenuTableViewCell: Rswift.NibResourceType, Rswift.ReuseIdentifierType {
      typealias ReusableType = MainMenuTableViewCell
      
      let bundle = R.hostingBundle
      let identifier = "MainMenuTableViewCell"
      let name = "MainMenuTableViewCell"
      
      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [NSObject : AnyObject]? = nil) -> MainMenuTableViewCell? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? MainMenuTableViewCell
      }
      
      fileprivate init() {}
    }
    
    struct _SideMenuTableViewCell: Rswift.NibResourceType, Rswift.ReuseIdentifierType {
      typealias ReusableType = SideMenuTableViewCell
      
      let bundle = R.hostingBundle
      let identifier = "SideMenuTableViewCell"
      let name = "SideMenuTableViewCell"
      
      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [NSObject : AnyObject]? = nil) -> SideMenuTableViewCell? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? SideMenuTableViewCell
      }
      
      fileprivate init() {}
    }
    
    fileprivate init() {}
  }
  
  struct storyboard: Rswift.Validatable {
    static func validate() throws {
      try mainMenuViewController.validate()
    }
    
    struct cardsViewController: Rswift.StoryboardResourceWithInitialControllerType {
      typealias InitialController = CardsViewController
      
      let bundle = R.hostingBundle
      let name = "CardsViewController"
      
      fileprivate init() {}
    }
    
    struct launchScreen: Rswift.StoryboardResourceWithInitialControllerType {
      typealias InitialController = UIKit.UIViewController
      
      let bundle = R.hostingBundle
      let name = "LaunchScreen"
      
      fileprivate init() {}
    }
    
    struct mainMenuViewController: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = MainMenuViewController
      
      let bundle = R.hostingBundle
      let name = "MainMenuViewController"
      
      static func validate() throws {
        if UIKit.UIImage(named: "SideMenuIcon") == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'SideMenuIcon' is used in storyboard 'MainMenuViewController', but couldn't be loaded.") }
      }
      
      fileprivate init() {}
    }
    
    struct rootViewController: Rswift.StoryboardResourceWithInitialControllerType {
      typealias InitialController = UIKit.UINavigationController
      
      let bundle = R.hostingBundle
      let name = "RootViewController"
      
      fileprivate init() {}
    }
    
    struct settingsViewController: Rswift.StoryboardResourceWithInitialControllerType {
      typealias InitialController = SettingsViewController
      
      let bundle = R.hostingBundle
      let name = "SettingsViewController"
      
      fileprivate init() {}
    }
    
    struct tutorialViewController: Rswift.StoryboardResourceWithInitialControllerType {
      typealias InitialController = TutorialViewController
      
      let bundle = R.hostingBundle
      let name = "TutorialViewController"
      
      fileprivate init() {}
    }
    
    fileprivate init() {}
  }
  
  fileprivate init() {}
}
