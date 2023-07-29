part of 'reaction_parent_bloc.dart';

class ReactionParentEvent {
  const ReactionParentEvent();
}

class LongPress extends ReactionParentEvent {
  const LongPress({required this.key});
  final Key key;
}

class ResetActiveKey extends ReactionParentEvent {}
