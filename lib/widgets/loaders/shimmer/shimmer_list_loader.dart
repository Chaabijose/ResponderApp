import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../base/base_controller.dart';
import '../../../theme/app_colors.dart';
import 'chat_shimmer_loader.dart';
import 'circular_shimmer_loader.dart';
import 'grid_shimmer_loader.dart';
import 'linear_shimmer_loader.dart';

class ShimmerListLoader extends StatelessWidget {
  //Data
  final BaseController controller;
  final Widget child;
  final ShimmerLoaderType? shimmerLoaderType;
  final Color baseColor;
  final num gridCount;

  const ShimmerListLoader(
      {super.key,
      required this.controller,
      required this.child,
      this.gridCount = 3,
      this.baseColor = kGreyCC,
      this.shimmerLoaderType});

  // Build **************************************
  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.loading.value
        ? shimmerLoaderType == ShimmerLoaderType.chat
            ? ChatShimmerLoader(baseColor: baseColor)
            : shimmerLoaderType == ShimmerLoaderType.linearCircular
                ? CircularShimmerLoader(baseColor: baseColor)
                : shimmerLoaderType == ShimmerLoaderType.grid
                    ? GridShimmerLoader(
                        gridCount: gridCount,
                        baseColor: baseColor,
                      )
                    : LinearShimmerLoader(baseColor: baseColor)
        : child);
  }
}

enum ShimmerLoaderType { linear, chat, linearCircular, grid }
