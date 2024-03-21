[![Pub Version](https://img.shields.io/pub/v/wx_icon)](https://pub.dev/packages/wx_icon) ![GitHub](https://img.shields.io/github/license/davigmacode/flutter_wx_icon) [![GitHub](https://badgen.net/badge/icon/buymeacoffee?icon=buymeacoffee&color=yellow&label)](https://www.buymeacoffee.com/davigmacode) [![GitHub](https://badgen.net/badge/icon/ko-fi?icon=kofi&color=red&label)](https://ko-fi.com/davigmacode)

Design captivating icons that effortlessly transform between states with fluid animations. Our intuitive API makes it easy to create beautiful and interactive elements for your Flutter app.

[![Preview](https://github.com/davigmacode/flutter_wx_icon/raw/main/media/preview.gif)](https://davigmacode.github.io/flutter_wx_icon)

[Demo](https://davigmacode.github.io/flutter_wx_icon)

## Usage

To read more about classes and other references used by `wx_icon`, see the [API Reference](https://pub.dev/documentation/wx_icon/latest/).

```dart
WxIcon(
  Icons.star,
  color: _color,
  opacity: _opacity,
  size: _size,
  scale: _scale,
  rotate: _rotate,
  flipX: _flipX,
  flipY: _flipY,
)

IconButton(
  onPressed: _toggleSelected,
  icon: WxToggleIcon(
    Icons.star,
    selected: _selected,
    style: WxDrivenToggleIconStyle.scaleDown(
      size: 24,
      rotate: 45,
      selectedStyle: const WxToggleIconStyle(rotate: 0),
    ),
  ),
)
```

## Sponsoring

<a href="https://www.buymeacoffee.com/davigmacode" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me A Coffee" height="45"></a>
<a href="https://ko-fi.com/davigmacode" target="_blank"><img src="https://storage.ko-fi.com/cdn/brandasset/kofi_s_tag_white.png" alt="Ko-Fi" height="45"></a>

If this package or any other package I created is helping you, please consider to sponsor me so that I can take time to read the issues, fix bugs, merge pull requests and add features to these packages.