import 'package:bloc/bloc.dart';

part 'reaction_event.dart';
part 'reaction_state.dart';

class ReactionBloc extends Bloc<ReactionEvent, ReactionState> {
  ReactionBloc()
      : super(const ReactionState(
          isReactionsTrayOpen: false,
          react: false,
          close: false,
        )) {
    on<OpenReactionsTray>(
      (event, emit) => emit(
        ReactionState(
          isReactionsTrayOpen: event.val,
          react: false,
          close: false,
        ),
      ),
    );

    on<React>(
      (event, emit) => emit(ReactionState(
        isReactionsTrayOpen: state.isReactionsTrayOpen,
        react: event.val,
        close: false,
      )),
    );

    on<Close>(
      (event, emit) => emit(ReactionState(
        isReactionsTrayOpen: false,
        react: false,
        close: event.val,
      )),
    );
  }
}
