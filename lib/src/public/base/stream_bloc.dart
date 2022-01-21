import 'package:stream_bloc/src/private/base/stream_bloc_base.dart';
import 'package:stream_bloc/src/private/mixins/stream_bloc_hooks_mixin.dart';
import 'package:stream_bloc/src/private/mixins/stream_bloc_states_mixin.dart';
import 'package:stream_bloc/src/private/mixins/stream_bloc_transformers_mixin.dart';
import 'package:stream_bloc/src/public/interfaces/stream_bloc.dart';

/// Transforms input `Events` using [mapEventToStates] into [Stream] of [States]
/// as an output.
///
/// Almost identical to pre-`7.2.0` Bloc from the `bloc` package.

abstract class StreamBloc<Event extends Object?,
        State extends Object?> = StreamBlocBase<Event, State>
    with
        StreamBlocHooksMixin<Event, State>,
        StreamBlocTransformersMixin<Event, State>,
        StreamBlocStatesMixin<Event, State>
    implements IStreamBloc<Event, State>;
