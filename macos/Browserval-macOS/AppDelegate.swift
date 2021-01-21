import Foundation
import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
  var popover: NSPopover!
  var bridge: RCTBridge!
  var statusBarItem: NSStatusItem!

  func applicationDidFinishLaunching(_ aNotification: Notification) {
    print("111111111111111111111111111")
    let jsCodeLocation: URL

    #if DEBUG
      print("2222222222222222222222")
      jsCodeLocation = RCTBundleURLProvider.sharedSettings().jsBundleURL(forBundleRoot: "index", fallbackResource:nil)
    #else
      jsCodeLocation = Bundle.main.url(forResource: "main", withExtension: "jsbundle")!
    #endif
    let rootView = RCTRootView(bundleURL: jsCodeLocation, moduleName: "Browserval", initialProperties: nil, launchOptions: nil)
    let rootViewController = NSViewController()
    rootViewController.view = rootView

    popover = NSPopover()

    popover.contentSize = NSSize(width: 700, height: 800)
    popover.animates = true
    popover.behavior = .transient
    popover.contentViewController = rootViewController

    statusBarItem = NSStatusBar.system.statusItem(withLength: CGFloat(60))

    if let button = self.statusBarItem.button {
      button.action = #selector(togglePopover(_:))
      button.title = "TEST"
    }
    
    
    
    
    let em = NSAppleEventManager.shared()
    em.setEventHandler(
        self,
        andSelector: #selector(getUrl(_:withReplyEvent:)),
        forEventClass: AEEventClass(kInternetEventClass),
        andEventID: AEEventID(kAEGetURL))
    
    
    let bundleID = Bundle.main.bundleIdentifier as CFString?
    var httpResult: OSStatus? = nil
    if let bundleID = bundleID {
        httpResult = LSSetDefaultHandlerForURLScheme("http" as CFString, bundleID)
    }
    var httpsResult: OSStatus? = nil
    if let bundleID = bundleID {
        httpsResult = LSSetDefaultHandlerForURLScheme("https" as CFString, bundleID)
    }

  }
  
  @objc func getUrl(
      _ event: NSAppleEventDescriptor?,
      withReplyEvent replyEvent: NSAppleEventDescriptor?
  ) {
      // Get the URL
      let urlStr = event?.paramDescriptor(forKeyword: keyDirectObject)?.stringValue
    
    print(urlStr)

      //TODO: Your custom URL handling code here
  }

  @objc func togglePopover(_ sender: AnyObject?) {
      if let button = self.statusBarItem.button {
          if self.popover.isShown {
              self.popover.performClose(sender)
          } else {
              self.popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)

              self.popover.contentViewController?.view.window?.becomeKey()
          }
      }
  }
}
