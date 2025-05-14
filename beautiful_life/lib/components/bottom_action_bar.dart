import 'package:flutter/material.dart';
import 'floating_action_menu.dart';

class BottomActionBar extends StatelessWidget {
  final List<FloatingActionMenuItem> items;
  final double buttonSpacing;
  final Color bgColor;

  const BottomActionBar({
    Key? key,
    required this.items,
    this.buttonSpacing = 20.0,
    this.bgColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 60,
        margin: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: _buildActionButtons(),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.max,
      children: items.map((item) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: buttonSpacing / 2),
              child: FloatingActionButton(
                heroTag: 'bottom_action_${items.indexOf(item)}',
                backgroundColor: item.color,
                onPressed: item.onPressed,
                elevation: 2,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  constraints: const BoxConstraints(
                    minHeight: 56,
                    maxHeight: 56,
                  ),
                  child: SizedBox(
                    width: 60,
                    height: 40,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(top: 2),
                            child: FittedBox(
                              child: item.icon,
                            ),
                          ),
                        ),
                        Flexible(
                          fit: FlexFit.loose,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 2),
                            child: Text(
                              item.label,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 8,
                                height: 1.0,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
    );
  }
}
