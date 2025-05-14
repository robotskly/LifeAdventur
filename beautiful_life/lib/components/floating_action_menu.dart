import 'package:flutter/material.dart';

class FloatingActionMenuItem {
  final Widget icon;
  final String label;
  final Color color;
  final VoidCallback onPressed;

  const FloatingActionMenuItem({
    required this.icon,
    required this.label,
    required this.color,
    required this.onPressed,
  });
}

class FloatingActionMenu extends StatefulWidget {
  final List<FloatingActionMenuItem> items;
  final Offset initialOffset;
  final Color bgColor;
  final double buttonSpacing;

  const FloatingActionMenu({
    Key? key,
    required this.items,
    this.initialOffset = const Offset(0, 0),
    this.bgColor = Colors.black54,
    this.buttonSpacing = 70.0,
  }) : super(key: key);

  @override
  _FloatingActionMenuState createState() => _FloatingActionMenuState();
}

class _FloatingActionMenuState extends State<FloatingActionMenu>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;
  bool _isOpen = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _scaleAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _rotationAnimation = Tween<double>(begin: 0, end: 0.5).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleMenu() {
    setState(() {
      _isOpen = !_isOpen;
      _isOpen
          ? _animationController.forward()
          : _animationController.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Overlay(
      initialEntries: [
        OverlayEntry(
          builder: (context) => Positioned(
            left: widget.initialOffset.dx,
            bottom: widget.initialOffset.dy,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.8,
                  maxHeight: MediaQuery.of(context).size.height * 0.6,
                ),
                child: IntrinsicWidth(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        color: _isOpen ? widget.bgColor : Colors.transparent,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ..._buildMenuItems(),
                          _buildMainButton(),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildMenuItems() {
    return widget.items.map((item) {
      return ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: 100,
          maxWidth: 200,
          maxHeight: 80,
        ),
        child: Padding(
          padding: EdgeInsets.only(bottom: widget.buttonSpacing),
          child: FloatingActionButton(
            heroTag: 'menu_item_${widget.items.indexOf(item)}',
            backgroundColor: item.color,
            onPressed: () {
              _toggleMenu();
              item.onPressed();
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  item.icon,
                  SizedBox(height: 4),
                  Flexible(
                    child: Text(item.label,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.white)),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }).toList();
  }

  Widget _buildMainButton() {
    return RotationTransition(
      turns: _rotationAnimation,
      child: FloatingActionButton(
        heroTag: 'main_menu',
        onPressed: _toggleMenu,
        child: AnimatedIcon(
          icon: AnimatedIcons.menu_close,
          progress: _animationController,
        ),
      ),
    );
  }
}