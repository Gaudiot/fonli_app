---
name: create-feature
description: Scaffolds Flutter feature screens with a dumb View, a ViewController for actions and calls to base-layer services, and an optional ViewModel (ChangeNotifier UI state). Omits domain models inside feature folders. Use when creating a new feature or screen, scaffold, ViewController, MVVM-style layout, or when the user mentions View/ViewController/ViewModel in this app.
---

# Feature scaffold (View + ViewController + optional ViewModel)

## Terminology (alternate names from classic MVVM)

| Role | Name in this project | Responsibility |
|------|----------------------|----------------|
| UI | **View** | Presentation only: layout, `build`, widgets. As “dumb” as possible: no business rules or HTTP. Delegates actions to the **ViewController**. |
| Logic / orchestration | **ViewController** | Methods the View invokes; calls services under `lib/base/` (HTTP, storage, etc.). |
| Render state | **ViewModel** | Data and flags the screen needs (title, list items, loading, errors). Extends `BaseViewState` (ChangeNotifier). **Optional** for trivial screens that do not need reactive state. |

**Do not** add a feature-level “Model” file or folder: types and network calls live in `lib/base/` (e.g. `fonli_server`, DTOs under `models/`).

## How the pieces relate

- The View creates (or receives) the **ViewController**.
- The ViewController exposes a **`viewModel`** field (or an agreed equivalent) holding the state **ViewModel** for the View to observe.
- The View uses `ListenableBuilder` / `AnimatedBuilder` on the controller’s `viewModel` (or on the controller if the project still exposes `state` under another name — stay consistent with the nearest existing feature).

## Where to put files

```
lib/src/<domain>/<feature_name>/
  <feature_name>.view.dart
  <feature_name>.viewcontroller.dart
  <feature_name>.viewmodel.dart   # only if needed
  <feature_name>.components.dart # optional: part file for private widgets
```

- `feature_name`: `snake_case` aligned with the screen name (e.g. `word_conjugation`, `user_settings`).

## Checklist when adding a feature

1. **View** (`*.view.dart`)
   - Use `StatefulWidget` when you need text controllers, `AnimationController`, etc.
   - Import only UI, design, navigation, and the **ViewController**.
   - In `build`, listen to state with `ListenableBuilder(listenable: viewController.viewModel, ...)` (or the project’s agreed name).
   - Private methods on the View only forward events, e.g. `onPressed: () => viewController.submit()`.

2. **ViewController** (`*.viewcontroller.dart`)
   - Class name ends with `ViewController`.
   - A final field typed as `*ViewModel` (e.g. `FeatureViewModel viewModel = FeatureViewModel()`), constructed or injected.
   - Async methods that call `FonliServer`, repos under `base/`, etc.
   - Update the ViewModel and trigger `notifyListeners` when state changes (on the ViewModel directly or via `BaseViewState` setters).

3. **ViewModel** (`*.viewmodel.dart`) — when it makes sense
   - `final class FeatureNameViewModel extends BaseViewState`.
   - Fields only for what the View must render; derived getters when useful.
   - **Name fields for readability**, not generic placeholders: prefer **boolean prefixes** `is…` / `has…`, **domain names** for user-facing strings, and **`*List`** (or a clear plural) for collections. See **ViewModel naming** below.
   - Avoid importing `package:flutter/material.dart` in state when possible (keep state UI-framework-agnostic).

## ViewModel naming

Use names that read well in the View (`if (vm.isButtonLoading)`, `vm.lifestyleText`):

| Kind | Convention | Examples |
|------|------------|----------|
| Booleans (loading / UI) | `is` + what is busy | `isInitialLoading`, `isButtonLoading`, `isRefreshing` |
| Booleans (errors / presence) | `has` + noun | `hasError` (from `BaseViewState`), `hasValidationError` |
| Text / display values | domain + role | `lifestyleText`, `title`, `subtitle`, `searchQuery` |
| Lists / options | domain + `List` or plural | `optionsList`, `items`, `selectedTags` |

**Rules**

- Prefer **specific** loading flags over a single `loading` when several actions can run in parallel (e.g. `isButtonLoading` vs full-screen `isInitialLoading` using `BaseViewState.isLoading` or a dedicated field).
- Reuse **`BaseViewState.isLoading` / `hasError`** when one global “screen loading” or “screen error” is enough; add extra fields only when the UI needs finer control.
- Avoid vague names like `data`, `value`, `flag`, `temp` unless scope is obvious.

4. **Components** (optional)
   - `part '...components.dart';` from the View for large widgets or sections to keep the View readable.

5. **Navigation** (if the screen is routed)
   - Add a route in `NavigationRoutes` and `routesMap()` in `lib/core/navigation/navigation.dart`.

6. **Validation**
   - Run `dart analyze` on the new files.

## When to omit the ViewModel

- Static screen or minimal state already handled by a single local `ValueNotifier` in the View (rare — prefer a ViewModel for consistency).
- Very short throwaway prototype (the user should say if it is temporary).

## Legacy modules in this repo

Some modules still use `*ViewModel` for the logic class and `*ViewState` plus a `state` field. For **new code**, prefer **ViewController** + state **ViewModel** + a **`viewModel`** field as described in this skill.

## Quick data-flow reference

```
View (UI)
  → calls ViewController methods
ViewController
  → updates ViewModel (BaseViewState)
View
  → ListenableBuilder on ViewModel exposed by ViewController
```

## Additional resources

- Minimal file skeletons: [reference.md](reference.md)
