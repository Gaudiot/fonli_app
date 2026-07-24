import 'package:flutter/material.dart';

class EventEmitter<T> extends ChangeNotifier {
  T? _value;

  EventEmitter({required T value}) : _value = value;

  T? get value => _value;
  void emit(T value) {
    _value = value;
    notifyListeners();
  }
}

class EventListener<T> {
  late final EventEmitter<T> _emitter;
  void Function(T value)? _handler;

  EventListener({required EventEmitter<T> emitter}) {
    _emitter = emitter;
    _emitter.addListener(_callHandler);
  }

  void dispose() {
    _emitter.removeListener(_callHandler);
  }

  set handler(void Function(T value) newHandler) {
    _handler = newHandler;
  }

  void _callHandler() {
    final value = _emitter.value;

    if (value == null) return;
    _handler?.call(value);
  }
}
