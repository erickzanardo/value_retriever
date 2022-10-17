
import 'dart:async';

/// Defines a function used to handle a value retrievement.
///
/// This function bool's result means that the function will take
/// care of retrieving the value.
typedef ValueRetrieverHandler<T> = bool Function(Completer<T?>);

/// {@template value_retriever}
/// A package that creates a value controller that allows a value
/// to be retrieved.
/// {@endtemplate}
class ValueRetriever<T> {
  /// {@macro value_retriever}
  ValueRetriever([T? initialValue])
      : _currentValue = initialValue;

  T? _currentValue;

  /// Returns the current (or the last) retreived value.
  T? get currentValue => _currentValue;

  final List<ValueRetrieverHandler<T>> _handlers = [];

  /// Register a retrievement handler on this value.
  void onRetrivement(ValueRetrieverHandler<T> handler) {
    _handlers.add(handler);
  }

  /// Removes the handler from this value.
  void removeHandler(ValueRetrieverHandler<T> handler) {
    _handlers.remove(handler);
  }

  /// Tries to retrieve a new value.
  Future<T?> retrieve() async {
    var handled = false;
    final completer = Completer<T?>();

    for (final handler in _handlers) {
      if (handler(completer)) {
        handled = true;
        break;
      }
    }

    if (handled) {
      final value = await completer.future;
      _currentValue = value;
      return value;
    } else {
      return null;
    }
  }
}
