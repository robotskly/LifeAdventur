
import 'package:beautiful_life/find_fun/models/funnythings_model.dart';
import 'package:flutter/material.dart';

class HomeThingsCardView extends StatefulWidget {

  const HomeThingsCardView({
    Key? key,
    this.data,
    this.callBack,
    this.animationController,
    this.animation
  }) : super(key: key);

  final FunnyThingsModel? data;
  final VoidCallback? callBack;
  final AnimationController? animationController;
  final Animation<double>? animation;
  @override
  _HomeThingsCardViewState createState() => _HomeThingsCardViewState();

}

class _HomeThingsCardViewState extends State<HomeThingsCardView> {

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: widget.animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 50 * (1.0 - widget.animation!.value), 0.0),
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
                  aspectRatio: 1.0,
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: Image.network(
                          widget.data!.imageUrl,
                          fit: BoxFit.cover,
                        )
                      ),
                      Positioned(
                        bottom: 16,
                        left: 16,
                        right: 16,
                        child: Column(
                          children: <Widget>[
                            Text(
                              widget.data!.name,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white
                              )
                            ),
                            Text(
                              widget.data!.description,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white
                              )
                            )
                          ]
                        )
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          splashColor: Colors.grey.withOpacity(0.2),
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                          onTap: widget.callBack,
                        )
                      )
                    ]
                  )
                )
              )
            )
          )
        );
      }
    );
  }
}