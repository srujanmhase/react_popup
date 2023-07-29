import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:react_popup/bloc/reaction_parent_bloc.dart';

class ReactionsParent extends StatefulWidget {
  const ReactionsParent({super.key, required this.child});

  ///Wrap your reactions widgets with this
  final Widget child;

  @override
  State<ReactionsParent> createState() => _ReactionsParentState();
}

class _ReactionsParentState extends State<ReactionsParent> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReactionParentBloc(),
      child: Builder(
        builder: (context) => widget.child,
      ),
    );
  }
}
