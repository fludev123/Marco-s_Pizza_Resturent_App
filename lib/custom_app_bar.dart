
import 'package:assignment_two/ui_helper/text_styling.dart';
import 'package:flutter/material.dart';
import 'cart_icon.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  CustomAppBar({this.title});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 1.0),
            child: Image.asset(
              "images/restaurant_logo.png",
              height: 50,
              width: 50,
            ),
          ),
          SizedBox(width: 8),
          Text(title, style: appBarText()),
        ],
      ),
      actions: [
        CartIcon(),
      ],
    );
  }
}
