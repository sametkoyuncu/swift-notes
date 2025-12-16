# SwiftUI Navigation (with version cues)

Choosing NavigationStack/NavigationPath vs NavigationLink, deep links, and state handling.

## Version Quick Reference
- iOS 13: `NavigationView` + `NavigationLink` (static destinations).
- iOS 16: `NavigationStack`, `NavigationPath`, `NavigationSplitView`, programmatic navigation, typed destinations.
- iOS 17: refinements to navigation APIs; observation macro (`@Observable`) can simplify state models if available.

## NavigationStack + NavigationPath (iOS 16+)
- Prefer `NavigationStack` for push-style flows; store a `NavigationPath` in `@State` to support deep links and programmatic pops.

```swift
struct ScreenA: Hashable { let id = UUID() }
struct ScreenB: Hashable { let id = UUID() }

struct RootView: View {
    @State private var path = NavigationPath()

    var body: some View {
        NavigationStack(path: $path) {
            List {
                Button("Go to B") { path.append(ScreenB()) }
            }
            .navigationDestination(for: ScreenB.self) { _ in
                ScreenBView(onClose: { path.removeLast() })
            }
        }
    }
}
```

- Use value types that conform to `Hashable` for path elements; keep them small (IDs, not full models).

## NavigationLink (static destinations)
- For simple lists of known destinations, `NavigationLink(destination:)` is fine. Avoid mixing old `NavigationView` with new stack APIs in the same flow.

## Deep Links
- Translate URLs/intents into path elements. Initialize `@State var path` from the parsed deep link so navigation reflects the initial route.
- Handle unknown routes gracefully by clearing or showing a fallback screen.

## Programmatic Pops
- `path.removeLast()` pops one; `path.removeLast(path.count)` pops to root. Guard against empty paths to avoid runtime errors.

## Split View (iPad / macOS) (iOS 16+)
- Use `NavigationSplitView` for master-detail; keep selection in `@State` or `@Binding` and use `navigationDestination` for detail stacks.

## State Management Tips
- Keep navigation state separate from data state. Use small enums/IDs to represent routes; store data elsewhere (view models, environment).
- Avoid storing full models in `NavigationPath`; use identifiers and fetch as needed to reduce serialization costs and data duplication.

## Testing and Previews
- For previews, seed `path` with sample routes to verify deep links.
- For UI tests, assert navigation by checking existence of destination views and path counts if exposed through accessibility.
