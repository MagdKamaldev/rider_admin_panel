import 'package:flutter/material.dart';
import 'package:tayar_admin_panel/core/themes/text_styles.dart';

class CopyableText extends StatelessWidget {
  final TextEditingController controller;
  final String alternative;
  final Function()? onChanged;

  const CopyableText({
    super.key,
    required this.controller,
    required this.alternative,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width < 600 ? size.width * 0.9 : 600,
      height: 90,
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.grey),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              selectionControls: MaterialTextSelectionControls(),
              
              controller: controller,
              style: TextStyles.normal,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: alternative,
              ),
              onChanged: (value) => onChanged?.call(),
            ),
          ),
        ],
      ),
    );
  }
}
