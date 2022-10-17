// ignore_for_file: prefer_const_constructors, prefer_function_declarations_over_variables
import 'dart:async';

import 'package:test/test.dart';
import 'package:value_retriever/value_retriever.dart';

void main() {
  group('ValueRetriever', () {
    test('can be instantiated', () {
      expect(ValueRetriever<String>(), isNotNull);
    });

    test('can have an initial value', () {
      final value = ValueRetriever<String>('Hey');
      expect(value.currentValue, equals('Hey'));
    });

    test('returns null if there are no handlers', () async {
      final value = ValueRetriever<String>('Hey');
      expect(await value.retrieve(), isNull);
    });

    test('returns the value from a handler', () async {
      final value = ValueRetriever<String>('Hey')
        ..onRetrivement((completer) {
          completer.complete('Hey Ho');
          return true;
        });
      expect(await value.retrieve(), equals('Hey Ho'));
    });

    test('current value is updated by the retriever', () async {
      final value = ValueRetriever<String>('Hey')
        ..onRetrivement((completer) {
          completer.complete('Hey Ho');
          return true;
        });
      expect(await value.retrieve(), equals('Hey Ho'));
      expect(value.currentValue, equals('Hey Ho'));
    });

    test('returns the value from a handler that returns true', () async {
      final value = ValueRetriever<String>('Hey')
        ..onRetrivement((completer) {
          return false;
        })
        ..onRetrivement((completer) {
          completer.complete('Hey Ho Lets go');
          return true;
        });

      expect(await value.retrieve(), equals('Hey Ho Lets go'));
    });

    test('can remove a handler', () async {
      final handler1 = (Completer<String?> completer) {
        completer.complete('Hey Ho');
        return true;
      };

      final handler2 = (Completer<String?> completer) {
        completer.complete('Hey Ho Lets go');
        return true;
      };
      final value = ValueRetriever<String>('Hey')
        ..onRetrivement(handler1)
        ..onRetrivement(handler2)
        ..removeHandler(handler1);


      expect(await value.retrieve(), equals('Hey Ho Lets go'));
    });
  });
}
