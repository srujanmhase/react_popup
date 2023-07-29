import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:react_popup/bloc/reaction_bloc.dart';
import 'package:react_popup/bloc/reaction_parent_bloc.dart';

class Reaction extends StatefulWidget {
  const Reaction({
    super.key,
    required this.onSelected,
    required this.child,
  });

  ///A custom callback  that can be executed when the reaction is tapped
  final FutureOr<void> Function() onSelected;

  ///A [Widget] parameter that is the actual icon displayed in the pop up list
  final Widget child;

  @override
  State<Reaction> createState() => _ReactionState();
}

class _ReactionState extends State<Reaction> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onSelected();
        context.read<ReactionParentBloc>().add(ResetActiveKey());
        context.read<ReactionBloc>().add(const React(val: true));
      },
      child: widget.child,
    );
  }
}
