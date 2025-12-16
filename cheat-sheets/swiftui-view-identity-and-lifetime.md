SwiftUI View Identity & Lifetime

1. What is it?

SwiftUI’s model where View values are cheap, ephemeral structs, while identity determines which underlying persistent backing store (state, subscriptions, render resources) is reused across updates. “Lifetime” is mostly about the lifetime of that backing store, not the View value.

2. What problem does it solve?

Enables a pure(ish) declarative UI where the framework can diff successive body results and update only what changed, while preserving state for “the same” conceptual view across recomputations.

3. Types / Categories
 • Structural identity: implied by position in the view tree (type + hierarchy + order).
 • Explicit identity: provided via .id(_:), ForEach(id:), Identifiable.
 • Stable vs unstable children: e.g. ForEach with stable IDs vs index-based iteration.
 • State storage kinds:
 • @State: per-view-identity local storage.
 • @StateObject: per-identity reference root, created once for that identity.
 • @ObservedObject: external reference, no ownership/creation semantics.
 • @EnvironmentObject / @Environment: keyed injection, independent of local identity.
 • @Binding: projection into some other storage, identity doesn’t own it.

4. How does it work in Swift?
 • body is recomputed frequently; treat it as a function of current inputs + state.
 • SwiftUI performs diffing between the old and new view trees; reuse hinges on matching identity.
 • Structural identity rules of thumb:
 • Same parent type + same child position + same child type ⇒ likely same identity.
 • Changing control flow (if/else, switch) can swap subtrees; identity may reset if the “slot” now holds a different type/branch.
 • .id(x):
 • Changes identity to be keyed by x. If x changes, SwiftUI treats it as a different view ⇒ state resets, onAppear/tasks may restart, animations can change.
 • ForEach:
 • With stable element IDs, SwiftUI can move/update rows without destroying state.
 • With unstable IDs (e.g. \.self on non-stable values, or using indices), inserts/removes can shift identity and scramble per-row state.
 • Property wrappers tie state lifetime to identity:
 • @State is stored out-of-line; it persists only while the view identity persists.
 • @StateObject is initialized once per identity; if identity changes, it is recreated.
 • Closure capture vs view lifetime:
 • Closures in modifiers can capture old values; SwiftUI may keep them alive as long as the backing nodes live. Prefer deriving from state/inputs rather than caching.
 • Concurrency modifiers:
 • .task and .onAppear are coupled to backing node lifetime; identity changes can cancel/restart tasks.

5. Dangerous corners / Footguns
 • Accidental identity resets
 • Adding/removing wrappers (Group, AnyView, conditional modifiers) can change structural shape and reset @State.
 • Switching between different view types in an if often resets subtree state even if it “looks” the same.
 • Misusing .id
 • Using .id(UUID()) or other changing values forces rebuilds every update: state loss, task restarts, performance hits.
 • Tying .id to a frequently-changing input (e.g. text) can make the UI thrash.
 • Unstable ForEach IDs
 • Iterating over indices, or using \.self for values that can collide/change, leads to state migration bugs (toggles flipping the wrong row, wrong animations).
 • @StateObject in the wrong place
 • Putting @StateObject in a view whose identity changes frequently causes repeated allocations and lost model state.
 • Initializing observable objects in init without stable identity expectations often surprises you.
 • Hidden lifetime extensions
 • Long-running .task work capturing self or models can keep graphs alive; cancellation only happens when node is removed / identity changes.
 • EquatableView / .equatable() misunderstandings
 • Preventing updates doesn’t guarantee lifetime changes won’t occur; it only short-circuits some diffing when equality holds.

6. When should I use which?
 • Rely on structural identity when the tree shape is stable and you want SwiftUI’s default behavior (most cases).
 • Use explicit IDs when:
 • You need stable state per logical item across moves/inserts/removes (ForEach with stable IDs).
 • You intentionally want to reset a subtree (e.g. “new document/session”).
 • Prefer ForEach(data, id:) with a real stable ID (database ID, UUID stored in model), not indices.
 • Use @State for small, view-local, value-type state tied to that view’s identity.
 • Use @StateObject for a reference model the view owns and that must be created once per identity (root of a feature, row view model with stable row identity).
 • Use @ObservedObject / @Binding when ownership is external and identity should not control creation/destruction.
 • Use .id sparingly; treat it like “invalidate and recreate this subtree.”

7. 30-second summary

SwiftUI View structs are transient; the persistent stuff lives behind the scenes and is keyed by view identity. Identity is usually structural (type + position), but you can override it with stable IDs (ForEach, .id). If identity changes, @State/@StateObject reset and appearance/tasks can restart. Most bugs come from unstable IDs, index-based lists, and unintended tree-shape/type changes.
