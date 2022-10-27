import 'dart:async';

class CompositeDisposableWidget {
  final List<StreamSubscription> _compositeDisposables = [];

  void disposeAll() {
    for (final element in _compositeDisposables) {
      element.cancel();
    }
  }

  void addDisposable(StreamSubscription subscription) {
    _compositeDisposables.add(subscription);
  }
}

extension CompositeDisposable on StreamSubscription {
  void disposedBy(CompositeDisposableWidget disposableWidget) {
    disposableWidget.addDisposable(this);
  }
}
