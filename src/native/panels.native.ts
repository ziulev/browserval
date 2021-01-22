import { NativeModules } from 'react-native';

export class PanelsNative {

  private panels = NativeModules.Panels;

  openBrowserval() {
    this.panels.openBrowserval();
  }

  closeBrowserval() {
    this.panels.closeBrowserval();
  }

}
