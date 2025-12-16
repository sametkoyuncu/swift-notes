# some vs any (Opaque vs Existential)

## 1. What is it?
`some` defines an **opaque type**: the concrete type is fixed but hidden from the caller.  
`any` defines an **existential type**: the concrete type is erased and can vary at runtime.

## 2. What problem does it solve?
They let APIs abstract over types:
- `some`: abstraction **without losing static type information**
- `any`: abstraction **when heterogeneity or runtime flexibility is required**

## 3. Types / Categories
- **Opaque types (`some P`)**
  - Compile-time concrete type
  - Single underlying type per declaration
- **Existential types (`any P`)**
  - Runtime type-erased container
  - Can hold multiple concrete types over time

## 4. How does it work in Swift?
- `some P`
  - Compiler generates a hidden concrete generic
  - Uses **static dispatch**, specialization, and inlining
  - Backed by vtables/witness tables known at compile time
- `any P`
  - Stored as an **existential container**
  - Uses **dynamic dispatch** via witness tables
  - May allocate (inline buffer vs heap) depending on size

## 5. Dangerous corners / Footguns
- `some` cannot return different concrete types across branches
- `any` loses associated type and `Self` information
- Existentials inhibit specialization and inlining
- Existential boxing can cause unexpected heap allocations
- Mixing `any P` with generics often causes silent performance cliffs

## 6. When should I use which?
- Use `some` when:
  - You control the implementation
  - You want abstraction **and** performance
  - The concrete type is stable per API
- Use `any` when:
  - You need heterogenous collections
  - The concrete type varies at runtime
  - API boundaries require type erasure
- Prefer generics over `any` when the caller can benefit from specialization

## 7. 30-second summary
- `some` = hidden concrete type, fast, statically dispatched
- `any` = type-erased container, flexible, dynamically dispatched
- `some` preserves optimization; `any` trades performance for flexibility
- Default to `some` (or generics); reach for `any` only when necessary
