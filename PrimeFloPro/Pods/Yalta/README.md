# ⛵️ Yalta

Yalta is an intuitive and powerful Auto Layout library. Designed to be simple and safe, Yalta is perfect for both new and seasoned developers.

> This project is in use in production, but if you're working in a team I would personally recommend looking at more established tools first - there is a better chance that new developers are going to be familiar with them and there is no reason to learn yet another syntax.

The entire library fits in just two files (core + extensions) with less than 250 lines of code which you can just drag-n-drop into your app.

- [Quick Overview](#quick-overview)
- [Full Guide](https://github.com/kean/Yalta/blob/master/Docs/YaltaGuide.md)
- [Installation Guide](https://github.com/kean/Yalta/blob/master/Docs/InstallationGuide.md)

> Yalta strives for clarity and simplicity by following [Swift API Design Guidelines](https://swift.org/documentation/api-design-guidelines/). Although most of the APIs are compact, it is a *non-goal* to enable the most concise syntax possible. Instead, Yalta has a fluent API that makes use sites form grammatical English phrases - that's what makes Swift code really stand out.

## Anchors

In Yalta, you start by selecting an **anchor** or a **collection of anchors** of a view (or a layout guide). Then use anchor's methods to create constraints.

> Anchors represent layout attributes of a view including **edges**, **dimensions**, **axis** and **baselines**.

The best way to access anchors is by using a special `addSubview(_:constraints:)` method (supports up to 4 views). Here are some examples of what you can do using anchors:

```swift
view.addSubview(subview) {
    $0.edges.pinToSuperview() // Pins the edges to fill the superview
    $0.edges.pinToSuperview(insets: Insets(10)) // With insets
    $0.edges.pinToSuperviewMargins() // Or margins

    $0.edges(.left, .right).pinToSuperview() // Fill along horizontal axis
    $0.centerY.alignWithSuperview() // Center along vertical axis
}
```

> With `addSubview(_:constraints:)` method you define a view hierarchy and layout views at the same time. It encourages splitting layout code into logical blocks and prevents some programmer errors (e.g. trying to add constraints to views not in view hierarchy).


Each anchor and collection of anchors have methods which make sense for that particular kind of anchor:

```swift
view.addSubview(title, subtitle) { title, subtitle in
    subtitle.top.align(with: title.bottom + 10)

    title.centerX.alignWithSuperview()

    title.width.set(100)
    subtitle.width.match(title.width + 20)
    subtitle.height.match(title.height * 2)

    // You can change a priority of constraints inside a group:
    subtitle.bottom.pinToSuperview().priority = UILayoutPriority(999)
}
```

All anchors are also accessible via `.al` proxy:

```swift
title.al.top.pinToSuperview()
```

> Yalta has full test coverage. If you'd like to learn about which constraints (`NSLayoutConstraint`) Yalta creates each time you call one of its methods, test cases are a great place to start.


## Why Yalta

Yalta is for someone who:

- Prefers fluent APIs that follow [Swift API Design Guidelines](https://swift.org/documentation/api-design-guidelines/)
- [Doesn't want](http://chris.eidhof.nl/post/micro-autolayout-dsl/) to depend on big, complex libraries
- Doesn't overuse operator overloads, [fast compile times](https://github.com/robb/Cartography/issues/215)
- Likes [NSLayoutAnchor](https://developer.apple.com/library/ios/documentation/AppKit/Reference/NSLayoutAnchor_ClassReference/index.html) but wished it had simpler, more fluent API which didn't require manually activating constraints

> [Yalta](https://en.wikipedia.org/wiki/Yalta) is a beautiful port city on the Black Sea, and a great name for *yet another layout tool* with *anchors*.
