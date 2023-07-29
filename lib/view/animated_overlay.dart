import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:react_popup/bloc/reaction_bloc.dart';
import 'package:react_popup/bloc/reaction_parent_bloc.dart';
import 'package:react_popup/view/reaction_element.dart';

class AnimatedReactionOverlay extends StatefulWidget {
  const AnimatedReactionOverlay({
    super.key,
    required this.width,
    required this.layerLink,
    required this.overlayBackgroundColor,
    required this.showCloseButton,
    this.customCloseButton,
    this.offset,
    this.alignment,
    required this.elementController,
    required this.overlayController,
    required this.reactions,
    required this.entry,
  }) : assert(
          customCloseButton != null ? showCloseButton == true : true,
        );

  ///The width of the reaction pop up
  final double width;

  ///The layerlink is used to attach to the parent widget
  final LayerLink layerLink;

  ///The overlay background color of the pop up type: [Color]
  final Color overlayBackgroundColor;

  ///A [bool] flag to set whether the close button should be rendered
  final bool showCloseButton;

  ///A [Widget] type parameter to display custom close button
  final Widget? customCloseButton;

  ///The offset with which the pop up is shown with respect to the child
  final Offset? offset;

  ///The alignment where the pop up is shown
  final Alignment? alignment;

  final AnimationController elementController;
  final AnimationController overlayController;

  ///The list of [Reaction] widgets which are shown in the pop up
  final List<Reaction> reactions;

  ///This controls the adding and removal of the pop up from the screen
  final OverlayEntry entry;

  @override
  State<AnimatedReactionOverlay> createState() =>
      _AnimatedReactionOverlayState();
}

class _AnimatedReactionOverlayState extends State<AnimatedReactionOverlay> {
  late CurvedAnimation _curve;

  late Animation<double> _dx;
  late Animation<double> _dy;

  @override
  void initState() {
    super.initState();

    _curve = CurvedAnimation(
        parent: widget.overlayController, curve: Curves.easeInOutCirc);
    _dx = Tween<double>(begin: 0, end: widget.width).animate(_curve);
    _dy = Tween<double>(begin: 0, end: 50).animate(_curve);
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      widget.overlayController.reset();
      widget.overlayController.forward();
    });
  }

  @override
  void dispose() {
    widget.overlayController.reverse();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.overlayController,
      builder: (context, child) => Positioned(
        height: _dy.value,
        width: _dx.value,
        child: CompositedTransformFollower(
          link: widget.layerLink,
          targetAnchor: widget.alignment ?? Alignment.topLeft,
          offset: widget.offset ?? Offset.zero,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: widget.overlayBackgroundColor,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: ReactionElement(
                    controller: widget.elementController,
                    reactions: widget.reactions,
                  ),
                ),
              ),
              if (widget.showCloseButton)
                GestureDetector(
                  onTap: () {
                    context.read<ReactionParentBloc>().add(ResetActiveKey());
                    context.read<ReactionBloc>().add(const Close(val: true));
                  },
                  child: widget.customCloseButton ??
                      Container(
                        margin: EdgeInsets.only(left: _dy.value / 10),
                        width: _dy.value,
                        decoration: BoxDecoration(
                          color: widget.overlayBackgroundColor,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Icon(
                            Icons.close,
                            size: _dy.value / 2.5,
                          ),
                        ),
                      ),
                )
            ],
          ),
        ),
      ),
    );
  }
}

class ReactionElement extends StatefulWidget {
  const ReactionElement({
    super.key,
    required this.reactions,
    required this.controller,
  });
  final List<Reaction> reactions;
  final AnimationController controller;

  @override
  State<ReactionElement> createState() => _ReactionElementState();
}

class _ReactionElementState extends State<ReactionElement>
    with TickerProviderStateMixin {
  late Animation<double> _initScale;

  @override
  void initState() {
    super.initState();

    _initScale = Tween<double>(begin: 0, end: 1).animate(widget.controller);

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      await Future.delayed(const Duration(milliseconds: 300));
      widget.controller.reset();
      widget.controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, child) => Align(
        alignment: Alignment.topLeft,
        child: Transform.scale(
          scale: _initScale.value,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: widget.reactions.toList(),
          ),
        ),
      ),
    );
  }
}
