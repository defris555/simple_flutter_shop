import 'package:flutter/material.dart';

//ignore:must_be_immutable
class ColorIndicator extends StatelessWidget {
  Color? indicatorColor;
  final String filter;
  ColorIndicator({
    required this.filter,
  });

  @override
  Widget build(BuildContext context) {
    switch (filter) {
      case 'black':
        indicatorColor = Color(0xFF505C72);
        break;
      case 'yellow':
        indicatorColor = Color(0xFFE4B34C);
        break;
      case 'grey':
        indicatorColor = Color(0xFF9A9E9F);
        break;
      case 'brown':
        indicatorColor = Color(0xFFB2A39D);
        break;
      case 'none':
        indicatorColor = Colors.white;
        break;
      default:
        indicatorColor = Colors.white;
    }
    return Container(
      width: 8.0,
      height: 8.0,
      decoration: BoxDecoration(
        color: indicatorColor,
        borderRadius: BorderRadius.circular(50.0),
      ),
    );
  }
}
