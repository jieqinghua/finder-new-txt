import AppKit
import Foundation

let outputDirectory = URL(fileURLWithPath: CommandLine.arguments.dropFirst().first ?? "新建txt.iconset")
try FileManager.default.createDirectory(at: outputDirectory, withIntermediateDirectories: true)

let icons: [(String, CGFloat)] = [
    ("icon_16x16.png", 16),
    ("icon_16x16@2x.png", 32),
    ("icon_32x32.png", 32),
    ("icon_32x32@2x.png", 64),
    ("icon_128x128.png", 128),
    ("icon_128x128@2x.png", 256),
    ("icon_256x256.png", 256),
    ("icon_256x256@2x.png", 512),
    ("icon_512x512.png", 512),
    ("icon_512x512@2x.png", 1024),
]

func point(_ x: CGFloat, _ y: CGFloat, _ scale: CGFloat) -> NSPoint {
    NSPoint(x: x * scale, y: y * scale)
}

func rect(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat, _ scale: CGFloat) -> NSRect {
    NSRect(x: x * scale, y: y * scale, width: width * scale, height: height * scale)
}

func drawIcon(size: CGFloat) -> NSImage {
    let image = NSImage(size: NSSize(width: size, height: size))
    let scale = size / 64

    image.lockFocus()
    NSGraphicsContext.current?.shouldAntialias = true

    let stroke = NSColor(calibratedRed: 0.37, green: 0.39, blue: 0.41, alpha: 1)
    stroke.setStroke()

    let document = NSBezierPath(roundedRect: rect(23, 10, 28, 34, scale), xRadius: 4 * scale, yRadius: 4 * scale)
    document.lineWidth = max(1, 3.4 * scale)
    document.lineCapStyle = .round
    document.lineJoinStyle = .round
    document.stroke()

    let plusCircle = NSBezierPath(ovalIn: rect(41, 35, 18, 18, scale))
    plusCircle.lineWidth = max(1, 3.4 * scale)
    plusCircle.stroke()

    let plus = NSBezierPath()
    plus.lineWidth = max(1, 3.4 * scale)
    plus.lineCapStyle = .round
    plus.move(to: point(50, 40, scale))
    plus.line(to: point(50, 48, scale))
    plus.move(to: point(46, 44, scale))
    plus.line(to: point(54, 44, scale))
    plus.stroke()

    image.unlockFocus()
    return image
}

func writePng(_ image: NSImage, to url: URL) throws {
    guard
        let tiff = image.tiffRepresentation,
        let bitmap = NSBitmapImageRep(data: tiff),
        let data = bitmap.representation(using: .png, properties: [:])
    else {
        throw NSError(domain: "render_icon", code: 1)
    }

    try data.write(to: url)
}

for icon in icons {
    let image = drawIcon(size: icon.1)
    try writePng(image, to: outputDirectory.appendingPathComponent(icon.0))
}
