import Foundation
import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
  var browservalPanel: NSPanel!
  var bridge: RCTBridge!
  var statusBarItem: NSStatusItem!
  var urlModule: URLModule = URLModule()
  
  var browservalDimensionsWidth = 300
  var browservalDimensionsHeight = 100

  func applicationDidFinishLaunching(_ aNotification: Notification) {
    self.setupMenubar()
    self.setupBrowservalPanel()
  }
  
  private func setupMenubar() {
    let statusBar = NSStatusBar.system
    self.statusBarItem = statusBar.statusItem(withLength: NSStatusItem.variableLength)
    self.statusBarItem.button?.image = NSImage(named: NSImage.Name("TrayIcon"))
    
    let statusBarMenu = NSMenu(title: "Cap Status Bar Menu")
    statusBarItem.menu = statusBarMenu
    statusBarMenu.addItem(
      withTitle: "Quit",
      action: #selector(AppDelegate.Quitapp),
      keyEquivalent: "q")
  }
  
  
  private func setupBrowservalPanel() {
    browservalPanel = NSPanel(
      contentRect: NSRect(
        x: 0,
        y: 0,
        width: browservalDimensionsWidth,
        height: browservalDimensionsHeight
      ),
      styleMask: [
        .nonactivatingPanel,
        .titled,
        .fullSizeContentView,
      ],
      backing: .buffered,
      defer: true
    )
    browservalPanel.titleVisibility = .hidden
    browservalPanel.level = .mainMenu
    browservalPanel.titlebarAppearsTransparent = true
    
    let jsCodeLocation: URL

    #if DEBUG
      jsCodeLocation = RCTBundleURLProvider.sharedSettings().jsBundleURL(forBundleRoot: "index", fallbackResource:nil)
    #else
      jsCodeLocation = Bundle.main.url(forResource: "main", withExtension: "jsbundle")!
    #endif
    
    let rootView = RCTRootView(bundleURL: jsCodeLocation, moduleName: "Browserval", initialProperties: nil)
    let rootViewController = NSViewController()
    rootViewController.view = rootView
    
    browservalPanel.contentViewController = rootViewController
    
    let newSize = NSSize(width: browservalDimensionsWidth, height: browservalDimensionsHeight)
    guard var frame = browservalPanel.contentView?.window?.frame else { return }
    frame.size = newSize
    browservalPanel.contentView?.setFrameSize(newSize)
    browservalPanel.contentView?.window?.setFrame(frame, display: true)
    browservalPanel.contentView?.window?.backgroundColor = NSColor.clear
  }

  @objc func openBrowserval() {
    if (!browservalPanel.isVisible) {
      let mouseLoc: NSPoint = NSEvent.mouseLocation
//      let x = mouseLoc.x - (CGFloat(self.browservalDimensionsWidth) / 2)
//      let y = mouseLoc.y - CGFloat(self.browservalDimensionsHeight)
      let x = mouseLoc.x - 25
      let y = mouseLoc.y + 25
      let point: NSPoint = NSPoint(x: x, y: y)
      
      browservalPanel.makeKeyAndOrderFront(nil)
      browservalPanel.setFrameTopLeftPoint(point)
    }
  }
  
  @objc func closeBrowserval() {
    browservalPanel.close()
  }
  
  @objc func toggleBrowserval() {
    if browservalPanel.isVisible {
      self.closeBrowserval()
    } else {
      self.openBrowserval()
    }
  }
  
  @objc func Quitapp() {
    NSApp.terminate(self)
  }
}
