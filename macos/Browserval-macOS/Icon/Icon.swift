import Foundation
import AVFoundation

@objc(Icon)
class Icon: RCTViewManager {
  
  override func view() -> NSView! {
    return IconView()
  }
  
  override static func requiresMainQueueSetup() -> Bool {
    return true
  }
}
