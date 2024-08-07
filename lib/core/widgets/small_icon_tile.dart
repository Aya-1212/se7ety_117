
import 'package:flutter/material.dart';
import 'package:se7ety_117/core/utils/text_style.dart';

class SmallIconTile extends StatelessWidget {
  const SmallIconTile({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
  });
  final Widget icon;
  final String text;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(8),
          color: Colors.black26,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                text,
                style: getBodyStyle(),
              ),
              icon,
            ],
          ),
        ),
      ),
    );
  }
}
