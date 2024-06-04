# Hogwarts Compendium

![Harry Potter](https://media2.giphy.com/media/v1.Y2lkPTc5MGI3NjExMmNpOHdqa3R1Y2g2ZjM2bzN3YzRsbndxNmNqdnJoaG1maWMxNDdjZiZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/xT5LMxGzbgJkUZjdte/giphy.webp)

Welcome to the Hogwarts Compendium! This Flutter project is designed to provide a comprehensive guide to the magical world of Harry Potter, including details about houses, spells, elixirs, and more.

Developed by Robert Meiring.

## Table of Contents

- [Project Setup](#project-setup)
- [Architecture](#architecture)
- [Usage Instructions](#usage-instructions)
- [Testing](#testing)
- [Dependencies](#dependencies)
- [License](#license)

## Project Setup

1. **Clone the Repository**
   ```bash
   git clone https://github.com/Robert-Meiring/hogwarts_compendium.git
   cd hogwarts_compendium
   ```

2. **Install Dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the App**
   ```bash
   flutter run
   ```

## Architecture

### Bloc Pattern
The project uses the Bloc (Business Logic Component) pattern for state management. This ensures a clear separation of business logic from the UI, making the app scalable and easier to maintain.

### Folder Structure
```
lib/
├── detail_view/
│   ├── widgets/
│   │   └── dynamic_builder.dart
│   └── detail_view_screen.dart
├── home/
│   ├── logic/
│   │   ├── home_screen_bloc.dart
│   │   ├── home_screen_events.dart
│   │   └── home_screen_states.dart
│   └── home_screen.dart
├── shared/
│   ├── factory/
│   │   └── register_factory.dart
│   ├── models/
│   │   ├── elixirs/
│   │   │   └── elixir.dart
│   │   ├── houses/
│   │   │   ├── head.dart
│   │   │   ├── house.dart
│   │   │   └── trait.dart
│   │   ├── spells/
│   │   │   └── spell.dart
│   │   ├── ingredients/
│   │   │       └── ingredient.dart
│   ├── style/
│   │   └── hogwarts_style.dart
│   └── widgets/
│       ├── animators/
│       │   ├── hogwarts_scale_animation.dart
│       │   └── hogwarts_size_animation.dart
│       ├── error_handling/
│       │   └── hogwarts_snackbars.dart
│       ├── loaders/
│       │   └── hogwarts_loader.dart
│       └── text/
│           ├── hogwarts_text.dart
│           └── hogwarts_textfield.dart
├── tabs/
│   ├── elixirs/
│   │   ├── logic/
│   │   │   ├── elixirs_bloc.dart
│   │   │   ├── elixirs_events.dart
│   │   │   └── elixirs_states.dart
│   │   └── widgets/
│   │       └── elixirs_listview.dart
│   ├── houses/
│   │   ├── logic/
│   │   │   ├── houses_bloc.dart
│   │   │   ├── houses_events.dart
│   │   │   └── houses_states.dart
│   │   └── widgets/
│   │       └── houses_gridview.dart
│   └── spells/
│       ├── logic/
│       │   ├── spells_bloc.dart
│       │   ├── spells_events.dart
│       │   └── spells_states.dart
│       └── widgets/
│           └── spells_listview.dart
└── main.dart
```

## Usage Instructions

### Houses
- View details of all Hogwarts houses.
- Navigate to the house detail screen by tapping on a house.

### Spells
- Browse through a list of spells.
- Get detailed information about each spell, including its incantation and effects.

### Elixirs
- Explore various elixirs, their effects, and their ingredients.
- Learn about the inventors and characteristics of each elixir.

## Testing

### Running Tests
To run the tests for this project, use the following command:
```bash
flutter test
```

### Test Coverage
The project includes comprehensive tests for:
- Blocs
- Important widgets

## Dependencies

- `flutter_bloc`: ^8.1.5
- `equatable`: ^2.0.5
- `get_it`: ^7.7.0
- `http`: ^1.2.1
- `mockito`: ^5.4.4
- `flutter_svg`: ^2.0.10+1
- `rive`: ^0.13.5

For a full list of dependencies, refer to `pubspec.yaml`.


## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more information.

---

Developed by Robert Meiring ⚯͛. Enjoy exploring the magical world of Harry Potter through the Hogwarts Compendium!