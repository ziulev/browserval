import React from 'react';
import { ImageStyle, requireNativeComponent } from 'react-native';

const IconNative = requireNativeComponent<any>('Icon');

type Props = {
  source: string,
  style: ImageStyle,
}

export class Icon extends React.PureComponent<Props> {

  render() {
    const nativeProps = {
      ...this.props,
    }

    return <IconNative
      { ...nativeProps }
      style = {{ width: 25, height: 25, ...this.props.style }}
    />
  }
}
