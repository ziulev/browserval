import Foundation

@objc(Panels)
class Panels: RCTEventEmitter {

  let appDelegate = NSApplication.shared.delegate as! AppDelegate

  override init() {
    super.init()
    
    /* Close panel on click outside event */
    NSEvent.addGlobalMonitorForEvents(matching: [
      NSEvent.EventTypeMask.leftMouseDown,
      NSEvent.EventTypeMask.rightMouseDown,
      NSEvent.EventTypeMask.otherMouseDown,
    ]) { (event: NSEvent) -> Void in
      
      if (self.appDelegate.browservalPanel.isVisible) {
        self.closeBrowserval()
      }
    }
  }

  @objc func openBrowserval() {
    DispatchQueue.main.async {
      self.appDelegate.openBrowserval()
    }
  }

  @objc func closeBrowserval() {
    DispatchQueue.main.async {
      self.appDelegate.closeBrowserval()
    }
  }

  override func supportedEvents() -> [String]! {
    return []
  }

  @objc override static func requiresMainQueueSetup() -> Bool {
    return false
  }

}
