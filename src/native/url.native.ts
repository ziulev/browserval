import {
  NativeModules,
  NativeEventEmitter,
} from 'react-native';

export class URLNative {
  private url = NativeModules.URLModule;

  private eventEmitter = new NativeEventEmitter(this.url);

  onOpen(callback: (event: any) => void) {
    this.eventEmitter.addListener('onOpen', (event) => callback(event));
  }

}
