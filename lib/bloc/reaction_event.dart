part of 'reaction_bloc.dart';

class ReactionEvent {
  const ReactionEvent();
}

class OpenReactionsTray extends ReactionEvent {
  const OpenReactionsTray({required this.val});
  final bool val;
}

class React extends ReactionEvent {
  const React({required this.val});
  final bool val;
}

class Close extends ReactionEvent {
  const Close({required this.val});
  final bool val;
}
