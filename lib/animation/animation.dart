import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingAnimation extends StatelessWidget {
  final Color loadingColor;
  const LoadingAnimation({this.loadingColor = Colors.transparent, super.key});

  @override
  Widget build(BuildContext context) {
    return LoadingAnimationWidget.waveDots(color: loadingColor, size: 50);
  }
}

class OpenAnimation extends StatelessWidget {
  final Widget openWidget;
  final Widget closedWidget;
  const OpenAnimation({
    super.key,
    required this.openWidget,
    required this.closedWidget,
  });

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      transitionType: ContainerTransitionType.fadeThrough,
      transitionDuration: const Duration(milliseconds: 300),
      closedElevation: 4,
      closedColor: Colors.white,
      closedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      openBuilder: (context, _) => openWidget,

      closedBuilder: (context, openContainer) {
        return GestureDetector(onTap: openContainer, child: closedWidget);
      },
    );
  }
}
