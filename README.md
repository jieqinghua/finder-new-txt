# 新建txt

一个可以拖到 Finder 工具栏的 macOS 小应用。点击后会在当前 Finder 窗口所在文件夹中新建空白 `.txt` 文件。

## 使用方式

1. 下载或复制 `新建txt.app` 到 `~/Applications`。
2. 打开 Finder。
3. 按住 `Command`，把 `新建txt.app` 拖到 Finder 窗口顶部工具栏。
4. 点击工具栏里的图标，即可在当前文件夹中新建文本文件。

第一次运行时，macOS 可能会请求允许该应用控制 Finder。请选择允许。

## 文件命名

应用会创建：

```text
新建文本文件.txt
```

如果同名文件已存在，会自动创建：

```text
新建文本文件 2.txt
新建文本文件 3.txt
...
```

## 项目文件

- `新建txt.app`：可直接使用的 macOS 应用。
- `新建txt.jxa.js`：应用脚本源码。
- `icon.png`：当前使用的图标原图。
- `新建txt.icns`：由 `icon.png` 生成的 macOS 图标。
- `新建txt.app/Contents/Resources/applet.icns`：应用内置图标，已同步为 `icon.png` 生成的版本。
- `scripts/make_icns.py`：把 iconset PNG 打包为 `.icns` 的脚本。

## 更新图标

替换 `icon.png` 后，可用下面的命令重新生成图标并写入 app：

```bash
rm -rf user-icon.iconset
mkdir -p user-icon.iconset
sips -z 16 16 icon.png --out user-icon.iconset/icon_16x16.png
sips -z 32 32 icon.png --out user-icon.iconset/icon_16x16@2x.png
sips -z 32 32 icon.png --out user-icon.iconset/icon_32x32.png
sips -z 64 64 icon.png --out user-icon.iconset/icon_32x32@2x.png
sips -z 128 128 icon.png --out user-icon.iconset/icon_128x128.png
sips -z 256 256 icon.png --out user-icon.iconset/icon_128x128@2x.png
sips -z 256 256 icon.png --out user-icon.iconset/icon_256x256.png
sips -z 512 512 icon.png --out user-icon.iconset/icon_256x256@2x.png
sips -z 512 512 icon.png --out user-icon.iconset/icon_512x512.png
sips -z 1024 1024 icon.png --out user-icon.iconset/icon_512x512@2x.png
python3 scripts/make_icns.py user-icon.iconset 新建txt.icns
cp 新建txt.icns 新建txt.app/Contents/Resources/applet.icns
codesign --force --sign - 新建txt.app
```

## 打包 Release

发布 GitHub Release 时，建议把 app 打成 zip：

```bash
ditto -c -k --sequesterRsrc --keepParent 新建txt.app 新建txt.app.zip
```
