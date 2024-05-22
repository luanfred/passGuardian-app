
import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class CardPassword extends StatelessWidget {
  const CardPassword({super.key, required this.title, required this.email});
  final String title;
  final String email;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      //width: MediaQuery.of(context).size.width - 40,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 10,
          left: 20,
          right: 10,
          bottom: 10,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: ThemeColors.blueText,
                    ),
                  ),
                  Text(
                    email,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }
}