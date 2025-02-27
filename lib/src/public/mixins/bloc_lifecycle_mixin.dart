import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

mixin BlocLifecycleMixin<Event> on BlocEventSink<Event> {
  final List<StreamSubscription<dynamic>> _subscriptions = [];

  @protected
  StreamSubscription<T> listenToStream<T>(
    Stream<T> stream,
    void Function(T event) subscriber,
  ) {
    final subscription = stream.listen(subscriber);
    _subscriptions.add(subscription);
    return subscription;
  }

  @protected
  StreamSubscription<T> listenToStreamable<T>(
    Streamable<T> streamable,
    void Function(T event) subscriber,
  ) =>
      listenToStream(streamable.stream, subscriber);

  @protected
  StreamSubscription<T> reactToStream<T>(
    Stream<T> stream,
    Event Function(T event) reaction,
  ) =>
      listenToStream(stream, (event) => add(reaction(event)));

  @protected
  StreamSubscription<T> reactToStreamable<T>(
    Streamable<T> streamable,
    Event Function(T event) reaction,
  ) =>
      reactToStream(streamable.stream, reaction);

  @override
  Future<void> close() async {
    for (final subscription in _subscriptions) {
      await subscription.cancel();
    }
    return super.close();
  }
}
