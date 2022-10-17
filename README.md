# Value Retriever

[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
[![Powered by Mason](https://img.shields.io/endpoint?url=https%3A%2F%2Ftinyurl.com%2Fmason-badge)](https://github.com/felangel/mason)
[![License: MIT][license_badge]][license_link]

A package that creates a value controller that allows a value to be retrieved

## Installation 💻

**❗ In order to start using Value Retriever you must have the [Dart SDK][dart_install_link] installed on your machine.**

Add `value_retriever` to your `pubspec.yaml`:

```yaml
dependencies:
  value_retriever:
```

Install it:

```sh
dart pub get
```

## Usage and motivation ❔

Value Retreiver works on a similar way that [Value Notifier](https://api.flutter.dev/flutter/foundation/ValueNotifier-class.html)
in the way that it creates a controlled value, but unlike Valur Notifier, that allows users to
listen for changes, Value Retreiver allows a value to be requested, which will be provided by
any handlers that may be managing it.

An use case example. Imagine we are creating a Flutter app that edits text files, a simplified example would be:

```dart
class EditorScaffold extends StatefulWidget {
  State createState() => _EditorScaffoldState();
}

class _EditorScaffoldState extends State<EditorScaffold> {
  late final _textValue = ValueRetriever<String>();

  Future<void> _save() async {
    context.read<Repoisoty>().save(
      await _textValue.retrieve(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Toolbar(
            icons: [
              SaveIcon(
                onPressed: _save,
              ),
            ],
          ),
          Expanded(child: EditorView(value: _textValue)),
        ],
      ),
    );
  }
}

class EditorView extends StatefulWidget {

  EditorView({ super.key, required this.value });

  final ValueRetriever<String> value;

  State createState() => _EditorViewState();
}

class _EditorViewState extends State<EditorView> {

  String value = '';

  @override
  void initState() {
    super.initState();

    widget.value.onRetrivement(_retrieveValue);
  }

  @override
  void dispose() {
    widget.value.removeHandler(_retrieveValue);

    super.dispose();
  }

  bool _retrieveValue(Completer<String> completer) {
    completer.complete(_value);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    // omitted
  }
}
```

[dart_install_link]: https://dart.dev/get-dart
[github_actions_link]: https://docs.github.com/en/actions/learn-github-actions
[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[logo_black]: https://raw.githubusercontent.com/VGVentures/very_good_brand/main/styles/README/vgv_logo_black.png#gh-light-mode-only
[logo_white]: https://raw.githubusercontent.com/VGVentures/very_good_brand/main/styles/README/vgv_logo_white.png#gh-dark-mode-only
[mason_link]: https://github.com/felangel/mason
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis
[very_good_coverage_link]: https://github.com/marketplace/actions/very-good-coverage
[very_good_ventures_link]: https://verygood.ventures
[very_good_ventures_link_light]: https://verygood.ventures#gh-light-mode-only
[very_good_ventures_link_dark]: https://verygood.ventures#gh-dark-mode-only
[very_good_workflows_link]: https://github.com/VeryGoodOpenSource/very_good_workflows
