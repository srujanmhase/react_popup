import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'reaction_parent_event.dart';
part 'reaction_parent_state.dart';

class ReactionParentBloc
    extends Bloc<ReactionParentEvent, ReactionParentState> {
  ReactionParentBloc() : super(const ReactionParentState(key: Key(''))) {
    on<LongPress>(
      (event, emit) {
        if (state.key == event.key) return;
        emit(ReactionParentState(key: event.key));
      },
    );

    on<ResetActiveKey>(
      (event, emit) => emit(const ReactionParentState(key: null)),
    );
  }
}
