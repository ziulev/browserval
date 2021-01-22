enum Events {
  static let onOpen: String = "onOpen"
}

import Foundation
import Carbon

@objc(URLModule)
class URLModule: RCTEventEmitter {
  
  override init() {
    super.init()
    let em = NSAppleEventManager.shared()
    em.setEventHandler(
        self,
        andSelector: #selector(getUrl(_:withReplyEvent:)),
        forEventClass: AEEventClass(kInternetEventClass),
        andEventID: AEEventID(kAEGetURL))
  }
  
  @available(OSX 10.15, *)
  @objc
  func openUrl(_ url: NSString, withAppName appName: NSString) {
    let link: URL = URL(string: url as String)!
    do {
      let safariURL = try FileManager.default.url(
        for: .applicationDirectory,
        in: .localDomainMask,
        appropriateFor: nil,
        create: false
      ).appendingPathComponent(appName as String)
    
      NSWorkspace.shared.open([link], withApplicationAt: safariURL, configuration: .init()) { (runningApp, error) in
        print("running app", runningApp ?? "nil")
      }
    } catch {
      print(error)
    }
  }
  
  
  @objc func getUrl(
    _ event: NSAppleEventDescriptor?,
    withReplyEvent replyEvent: NSAppleEventDescriptor?
  ) {
    let url = event?.paramDescriptor(forKeyword: keyDirectObject)?.stringValue
    self.onOpen(url: url ?? "")
  }

  override func supportedEvents() -> [String]! {
    return [Events.onOpen]
  }
  
  @objc override static func requiresMainQueueSetup() -> Bool {
    return false
  }
  
  @objc func onOpen(url: String) {
    let browserUrls = LSCopyApplicationURLsForURL(URL(string: "https:")! as CFURL, .all)?.takeRetainedValue() as? [URL]
    var browsers: [String] = Array()

    for app in browserUrls! {
      browsers.append(app.path)
    }
    
    
    let body: NSDictionary = [
      "url": url,
      "browsers": browsers,
    ];

    self.sendEvent(withName: Events.onOpen, body: body)
  }

}
