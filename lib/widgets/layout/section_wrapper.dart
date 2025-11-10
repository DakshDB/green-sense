import 'package:flutter/material.dart';
import 'package:green_sense/widgets/layout/responsive_container.dart';

class SectionWrapper extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final double maxWidth;

  const SectionWrapper({
    Key? key,
    required this.child,
    this.backgroundColor,
    this.padding,
    this.maxWidth = 1200,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: backgroundColor,
      padding: padding ?? const EdgeInsets.symmetric(vertical: 60),
      child: ResponsiveContainer(
        maxWidth: maxWidth,
        child: child,
      ),
    );
  }
}
