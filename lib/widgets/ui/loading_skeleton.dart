import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:green_sense/constants/app_colors.dart';

class LoadingSkeleton extends StatelessWidget {
  final double? width;
  final double height;
  final BorderRadius? borderRadius;

  const LoadingSkeleton({
    Key? key,
    this.width,
    required this.height,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: borderRadius ?? BorderRadius.circular(8),
        ),
      ),
    );
  }
}

class ArticleCardSkeleton extends StatelessWidget {
  const ArticleCardSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LoadingSkeleton(
            height: 200,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(12),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const LoadingSkeleton(width: 80, height: 20),
                const SizedBox(height: 12),
                const LoadingSkeleton(width: double.infinity, height: 24),
                const SizedBox(height: 8),
                const LoadingSkeleton(width: double.infinity, height: 16),
                const SizedBox(height: 8),
                const LoadingSkeleton(width: double.infinity, height: 16),
                const SizedBox(height: 12),
                const LoadingSkeleton(width: 100, height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
