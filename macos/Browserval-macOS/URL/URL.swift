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
    let body: NSDictionary = [
      "url": url
    ];

    self.sendEvent(withName: Events.onOpen, body: body)
  }

}
