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

  final FutureOr<void> Function() onSelected;
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
