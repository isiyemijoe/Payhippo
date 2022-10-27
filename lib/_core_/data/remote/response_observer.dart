// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:payhippo/_core_/network/resource.dart';

enum ResponseState {
  LOADING,
  SUCCESS,
  ERROR,
  IDLE,
}

abstract class ResponseObserver<T extends Resource<dynamic>> {
  ResponseObserver({required this.context, this.setState});

  final BuildContext context;
  final Function()? setState;

  final List<Function(ResponseState? state)> listeners =
      List.empty(growable: true);

  ResponseState _responseState = ResponseState.IDLE;

  ResponseState get responseState => _responseState;

  void updateResponseState(ResponseState responseState) {
    _responseState = responseState;
    for (final element in listeners) {
      element.call(responseState);
    }
  }

  void observe(T event) {
    if (event is Success) {
      updateResponseState(ResponseState.SUCCESS);
    } else if (event is Loading) {
      updateResponseState(ResponseState.LOADING);
    } else if (event is Error) {
      updateResponseState(ResponseState.ERROR);
    }
  }

  void addStateListener(Function(ResponseState? state) listener) {
    if (!listeners.contains(listener)) {
      listeners.add(listener);
    }
  }

  void removeStateListener(Function(ResponseState? state) listener) {
    if (!listeners.contains(listener)) {
      listeners.remove(listener);
    }
  }
}
