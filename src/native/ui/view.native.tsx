import React from 'react';
import { requireNativeComponent, ViewStyle } from 'react-native';

const NSViewNative = requireNativeComponent<any>('RNNSView');

type Props = {
  onMouseEnter: () => void,
  style: ViewStyle,
}

export class NSView extends React.PureComponent<Props> {

  render() {
    const nativeProps = {
      ...this.props,
      onMouseEnter: () => {
        if (!this.props.onMouseEnter) {
          return;
        }

        this.props.onMouseEnter();
      }
    }

    return <NSViewNative
      { ...nativeProps }
      style = {{ ...this.props.style }}
    />
  }
}
