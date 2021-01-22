import React, { useCallback, useEffect, useState } from 'react';
import {
  View,
  TouchableOpacity,
} from 'react-native';

import { PanelsNative } from './native/panels.native';
import { Icon } from './native/ui/icon.native';
import { NSView } from './native/ui/view.native';
import { URLNative } from './native/url.native';

const urlNative = new URLNative();
const panelsNative = new PanelsNative();
const filterBrowsers = ['Browserval', 'Choosy'];

const App = () => {

  const [ url, setUrl ] = useState<string>('');
  const [ browserList, setBrowserList ] = useState<string[]>([]);
  const [ activeIndex, setActiveIndex ] = useState<number>(0);

  useEffect(() => {
    urlNative.onOpen(({ browsers, url }) => {


      setUrl(url);
      setBrowserList(browsers.filter((b: string) => !filterBrowsers.find(f => b.includes(f))));
      panelsNative.openBrowserval();
    });
  }, []);

  const openUrl = useCallback((url: string, browser: string) => {
    const pathArray = browser.split('/');
    const appName = pathArray[pathArray.length - 1];
    urlNative.openUrl(url, appName);
    panelsNative.closeBrowserval();
  }, []);

  const mouseEntered = useCallback((index: number) => {
    setActiveIndex(index);
  }, []);

  return (
    <View style={{
      display: 'flex',
      flexDirection: 'row',
      backgroundColor: '#212121',
      borderRadius: 15,
      overflow: 'hidden',
      width: 50 * browserList.length,
    }}
      onResponderMove={(e) => console.log(e)}
    >
      {browserList.map((browser, index) =>
        <NSView style={{}} key={browser} onMouseEnter={() => mouseEntered(index)}>
          <TouchableOpacity
            onPress={() => openUrl(url, browser)}
            style={ activeIndex === index ? { backgroundColor: '#1877dd' } : {}}
          >
            <Icon source={browser} style={{ width: 50, height: 50 }} />
          </TouchableOpacity>
        </NSView>
      )}
    </View>
  );
};

export default App;
