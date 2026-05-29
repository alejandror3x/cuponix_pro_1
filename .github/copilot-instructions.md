# Copilot Instructions for Cuponix

**Cuponix** — a Flutter mobile app for discovering and redeeming coupons and discounts. Spanish-language social commerce platform.

---

## Build, Test & Lint Commands

### Development
```bash
# Get dependencies
flutter pub get

# Run the app (requires connected device or emulator)
flutter run

# Watch mode (hot reload enabled)
flutter run --hot
```

### Testing
```bash
# Run all tests
flutter test

# Run tests for a specific file
flutter test test/widget_test.dart

# Run with verbose output
flutter test -v
```

### Code Quality
```bash
# Static analysis
flutter analyze

# Format code
dart format lib/

# Check formatting without modifying
dart format lib/ --set-exit-if-changed
```

---

## High-Level Architecture

### Project Structure
```
lib/
├── main.dart              # App entry point, GoRouter config, lifecycle management
├── core/
│   ├── theme/            # AppTheme, AppColors (Material3 dark theme)
│   └── widgets/          # Shared UI components (PillButton, CuponScaffold, etc.)
└── screens/              # Feature-based screen organization
    ├── home/
    ├── cupones/          # Coupon management screens
    ├── cupon/            # Coupon card / display screens
    ├── social/           # Business profiles, messaging, chat
    ├── settings/         # User settings, account management
    ├── perfil/           # User profile screens
    ├── explorar/         # Discovery / search
    ├── onboarding/       # First-time setup flows
    ├── states/           # Loading, error, empty states, permissions
    └── ...               # Other feature modules
```

### Navigation
**Router**: GoRouter (go_router v14.6.1)
- All routes defined in `main.dart` as a single `_router` object
- Query parameters passed via URI: `state.uri.queryParameters['tab']`
- Tab state passed to screens: e.g., `PerfilScreen(initialTab: _tabIndex(...))`
- Deep linking configured with path-based routing
- Helper function `_tabIndex()` converts query param strings to tab indices

### Theme & Styling
- **Base**: Material3 dark theme
- **Primary color**: Neon red (`#FF073A`)
- **Secondary**: Purple (`#2D1078`)
- **Background**: Pure black (`#1C1C1C`)
- **Typography**: Google Fonts "Inter" for all text
- **Buttons**: Pill-shaped with box shadows (custom PillButton component)
- **Assets**: Spanish naming convention (e.g., `icon-mensajes.png`, `fondo-cupon.png`)

---

## Key Conventions

### Screen Organization
- Each screen lives in `lib/screens/{feature}/{screen_name}_screen.dart`
- Screens are StatefulWidget or StatelessWidget
- Spanish naming for features and screens (e.g., `perfil_screen.dart`, `cupones_screen.dart`)
- For multi-tab screens, pass `initialTab` parameter to select active tab

### Reusable Components (lib/core/widgets/)
- **PillButton** — Primary/secondary button variant with customizable styling
- **CuponScaffold** — Layout with cupon card background image + bottom nav
- **CuponAvatar**, **CuponProfile**, **CuponStatBlock**, **CuponCta** — Coupon card sub-components
- **CuponTitleRow**, **CuponLead**, **CuponStatCentered**, **CuponHelpText** — Coupon text components
- **BottomNavBar** — Tab navigation with NavTab enum
- **PointsIcon** — Points currency icon
- **TicketCard** — Coupon/ticket display card

Use these components when building coupon-related UI; avoid reinventing the wheel.

### Naming & Language
- **Spanish throughout**: variable names, function names, screen names use Spanish terms
  - e.g., `cupón`, `negocio` (business), `perfil`, `mensajes`
  - Avoid mixing Spanish/English in identifiers
- **Image assets**: Spanish file names (e.g., `icon-configuracion.png`, `cuponix-logotipo.png`)
- **Text labels**: Spanish user-facing text; translations managed at screen level

### Styling Patterns
- Use `AppColors` constants for all colors (no hardcoded hex values)
- Box shadows on buttons: `boxShadow: [BoxShadow(color: shadow, blurRadius: ..., offset: ...)]`
- Padding: Consistent use of EdgeInsets (symmetric, fromLTRB, etc.)
- Borders: `BorderRadius.circular(999)` for pill shapes
- SafeArea: Used strategically to avoid notches/system UI overlap
- AnnotatedRegion: For controlling system UI overlay style (light/dark icons)

### State Management
- No explicit state management library (Provider, Riverpod, Bloc) detected
- Screens manage local state via StatefulWidget
- Navigation via GoRouter context methods (`context.go()`, `context.push()`)
- Tab state passed as constructor parameters to screens

### System UI Integration
- `_applySystemUI()` manages system UI visibility (top overlay visible, bottom hidden)
- Lifecycle listener (WidgetsBindingObserver) ensures UI reapplied on app resume
- AnnotatedRegion used per-screen for light/dark status bar styling

---

## Common Workflows

### Adding a New Screen
1. Create file: `lib/screens/{feature}/{screen_name}_screen.dart`
2. Extend StatelessWidget or StatefulWidget
3. Use AnnotatedRegion for system UI styling
4. Add route in `main.dart` GoRouter config
5. Import screen in main.dart if not already imported
6. Test routing with `context.go('/route-path')`

### Adding a New Widget
1. Create file: `lib/core/widgets/{widget_name}.dart`
2. Export from a central widgets file or import directly in screens
3. Follow existing widget patterns (enums for variants, private helper methods)
4. Use AppColors for all styling

### Modifying Navigation
- All routes are in `main.dart` in the `_router` object
- Add/edit GoRoute entries as needed
- Update `_tabIndex()` helper if adding new tab parameter mappings

### Working with Assets
- Images stored in `assets/images/` (specified in pubspec.yaml)
- Use `Image.asset('assets/images/icon-name.png')` to load
- All image names use Spanish conventions

---

## Debugging Tips

### Hot Reload Issues
If hot reload fails, use `flutter run --hot` or restart the app with `R` in the terminal.

### Navigation Not Working
- Verify route path in `main.dart` GoRouter
- Check that context.go() is using the correct path
- If tabs aren't showing, ensure initialTab parameter is passed correctly

### Theme Not Applied
- Ensure widget extends StatelessWidget/StatefulWidget with proper context
- Check AppTheme.theme in main.dart is applied to MaterialApp.router
- Verify AppColors constants are imported and used consistently

### Test Failures
Run `flutter test -v` to see detailed output. Most tests will be widget tests using flutter_test.

