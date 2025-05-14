import 'package:flutter/material.dart';
import 'homelist.dart';

class HomeListView extends StatelessWidget {

  const HomeListView(
      {Key? key,
      this.listData,
      this.callBack,
      this.animationController,
      this.animation})
      : super(key: key);

  final HomeList? listData;
  final VoidCallback? callBack;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 50 * (1.0 - animation!.value), 0.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      spreadRadius: 2,
                      offset: Offset(2, 4),
                    )
                  ],
                ),
                child: AspectRatio(
                  aspectRatio: 1.5,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                    child: Stack(
                      alignment: AlignmentDirectional.center,
                      children: <Widget>[
                        Positioned.fill(
                          child: Image.asset(
                            listData!.imagePath,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            splashColor: Colors.grey.withOpacity(0.2),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(4.0)),
                            onTap: callBack,
                          ),
                        ),
                      ],
                    ),
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
