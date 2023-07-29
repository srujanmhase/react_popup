import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:react_popup/bloc/reaction_bloc.dart';
import 'package:react_popup/bloc/reaction_parent_bloc.dart';
import 'package:react_popup/view/animated_overlay.dart';
import 'package:react_popup/view/reaction_element.dart';

class ReactionsWrapper extends StatefulWidget {
  const ReactionsWrapper({
    required super.key,
    this.reactionWidth,
    this.overlayBackgroundColor = Colors.black12,
    this.showCloseButton = true,
    this.customCloseButton,
    this.offset,
    this.alignment,
    required this.reactions,
    required this.child,
  });

  final double? reactionWidth;
  final Color overlayBackgroundColor;
  final bool showCloseButton;
  final Widget? customCloseButton;
  final Offset? offset;
  final Alignment? alignment;
  final List<Reaction> reactions;
  final Widget child;

  @override
  State<ReactionsWrapper> createState() => _ReactionsWrapperState();
}

class _ReactionsWrapperState extends State<ReactionsWrapper>
    with TickerProviderStateMixin {
  OverlayEntry? entry;
  final layerLink = LayerLink();
  late AnimationController overlayController;
  late AnimationController elementController;

  @override
  void initState() {
    overlayController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    elementController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    super.initState();
  }

  @override
  void dispose() {
    removeOverlay();
    super.dispose();
  }

  void showOverlay(
      {required ReactionParentBloc reactionParentBloc,
      required ReactionBloc reactionBloc}) {
    final overlay = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    entry = OverlayEntry(
      builder: (context) => MultiBlocProvider(
        providers: [
          BlocProvider.value(value: reactionParentBloc),
          BlocProvider.value(value: reactionBloc),
        ],
        child: AnimatedReactionOverlay(
          width: widget.reactionWidth ?? renderBox.size.width,
          layerLink: layerLink,
          showCloseButton: widget.showCloseButton,
          overlayBackgroundColor: widget.overlayBackgroundColor,
          customCloseButton: widget.customCloseButton,
          alignment: widget.alignment,
          offset: widget.offset,
          elementController: elementController,
          overlayController: overlayController,
          reactions: widget.reactions,
          entry: entry!,
        ),
      ),
    );
    overlay.insert(entry!);
  }

  void removeOverlay() {
    if (entry == null) return;
    entry?.remove();
    entry = null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReactionBloc(),
      child: Builder(builder: (context) {
        return MultiBlocListener(
          listeners: [
            BlocListener<ReactionParentBloc, ReactionParentState>(
              listener: (context, state) {
                if (state.key == widget.key) {
                  showOverlay(
                    reactionParentBloc: context.read<ReactionParentBloc>(),
                    reactionBloc: context.read<ReactionBloc>(),
                  );
                }
                if (state.key != widget.key) {
                  context.read<ReactionBloc>().add(const Close(val: true));
                }
              },
            ),
            BlocListener<ReactionBloc, ReactionState>(
              listener: (context, state) {
                if (state.react) {
                  elementController
                      .reverse()
                      .then((value) => overlayController.reverse())
                      .then((value) => {removeOverlay()});
                  context.read<ReactionBloc>().add(const React(val: false));
                }

                if (state.close) {
                  elementController
                      .reverse()
                      .then((value) => overlayController.reverse())
                      .then((value) => {removeOverlay()});
                  context.read<ReactionBloc>().add(const Close(val: false));
                }
              },
            )
          ],
          child: CompositedTransformTarget(
            link: layerLink,
            child: GestureDetector(
              onLongPress: () {
                //Add an event to the reactionParent
                context
                    .read<ReactionParentBloc>()
                    .add(LongPress(key: widget.key!));
              },
              child: widget.child,
            ),
          ),
        );
      }),
    );
  }
}
