import AppKit

guard #available(macOS 12.0, *) else {
    print("0")
    exit(1)
}

for (_, screen) in NSScreen.screens.enumerated() {
    let insets = screen.safeAreaInsets
    // safeAreaInsets.top > 0 のスクリーンは「ノッチデザイン」
    guard insets.top > 0 else { continue }
    print("\(Int(insets.top))")
}
