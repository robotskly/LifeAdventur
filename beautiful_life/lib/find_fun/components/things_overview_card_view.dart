import 'package:beautiful_life/find_fun/models/funny_things_data.dart';
import 'package:flutter/material.dart';
import 'package:beautiful_life/app_theme.dart';

class ThingsOverviewCardView extends StatelessWidget {
  final double aspectRatio;

  const ThingsOverviewCardView({
    Key? key,
    required this.listData,
    required this.aspectRatio,
    this.animation,
    this.animationController,
  }) : super(key: key);

  final FunnyThingsData listData;
  final Animation<double>? animation;
  final AnimationController? animationController;

  @override
  Widget build(BuildContext context) {
    final brightness = MediaQuery.of(context).platformBrightness;
    final isLightMode = brightness == Brightness.light;

    return AnimatedBuilder(
      animation: animationController!,
      builder: (context, child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(
              0.0,
              50 * (1.0 - animation!.value),
              0.0,
            ),
            child: AspectRatio(
                aspectRatio: aspectRatio,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
              child: Container(
                decoration: BoxDecoration(
                  color: isLightMode ? AppTheme.white : AppTheme.nearlyBlack,
                ),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Image.asset(
                        listData.imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 12,
                      left: 12,
                      right: 12,
                      child: Text(
                        listData.title!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: isLightMode ? AppTheme.darkText : AppTheme.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 12,
                      left: 12,
                      right: 12,
                      child: Text(
                        listData.description!,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: isLightMode ? AppTheme.grey : AppTheme.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          ),
        );
      },
    );
  }
}