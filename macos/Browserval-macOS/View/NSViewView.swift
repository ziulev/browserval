import Foundation

class NSViewView: NSView {
  
  @objc var onMouseEnter: RCTDirectEventBlock?
  
  override func mouseEntered(with event: NSEvent) {
    self.onMouseEnter!(["timestamp": event.timestamp])
  }
  
  override func updateTrackingAreas() {
    super.updateTrackingAreas()

    for trackingArea in self.trackingAreas {
      self.removeTrackingArea(trackingArea)
    }
    
    let options: NSTrackingArea.Options = [.mouseEnteredAndExited, .activeAlways]
    let trackingArea = NSTrackingArea(rect: self.bounds, options: options, owner: self, userInfo: nil)
    self.addTrackingArea(trackingArea)
  }
  
}
