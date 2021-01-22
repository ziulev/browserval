import Foundation
import AVFoundation

@objc(RNNSView)
class RNNSView: RCTViewManager {
  
  override func view() -> NSView! {
    return NSViewView()
  }
  
  override static func requiresMainQueueSetup() -> Bool {
    return true
  }
}
