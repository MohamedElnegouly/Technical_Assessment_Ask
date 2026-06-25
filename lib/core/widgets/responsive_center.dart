import 'package:flutter/material.dart';

/// Centers [child] and caps its width on large screens (tablets, desktop,
/// landscape) so layouts don't stretch edge-to-edge, while staying full-width
/// on phones.
class ResponsiveCenter extends StatelessWidget {
  final Widget child;
  final double maxWidth;
  const ResponsiveCenter({super.key, required this.child, this.maxWidth = 640});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: child,
      ),
    );
  }
}
