# 新建txt

一个可以拖到 Finder 工具栏的 macOS 小应用。点击后会在当前 Finder 窗口所在文件夹中新建空白 `.txt` 文件。

## 下载

从 GitHub Release 下载 `新建txt.app.zip`，解压后得到 `新建txt.app`。

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
