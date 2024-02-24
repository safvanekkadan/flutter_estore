import 'package:flutter/material.dart';

class AppBarIcons extends StatelessWidget {
  const AppBarIcons({super.key, required this.function, required this.icon});
  final Function function;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: GestureDetector(
        onTap: () {
          function();
        },
        child: Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle, color: Theme.of(context).canvasColor),
          child: Padding(
            padding: EdgeInsets.all(5),
            child: Icon(icon),
          ),
        ),
      ),
    );
  }
}
