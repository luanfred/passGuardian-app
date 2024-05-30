
import 'package:flutter/material.dart';

import '../pages/query_password.dart';
import '../theme/app_colors.dart';

class CardPassword extends StatefulWidget {
  const CardPassword({super.key, required this.title, required this.email, required this.passwordId, required this.onReturn});
  final String title;
  final String email;
  final int passwordId;
  final VoidCallback onReturn;

  @override
  State<CardPassword> createState() => _CardPasswordState();
}

class _CardPasswordState extends State<CardPassword> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      //width: MediaQuery.of(context).size.width - 40,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 10,
          left: 25,
          right: 0,
          bottom: 10,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: ThemeColors.blueText,
                    ),
                  ),
                  Text(
                    widget.email,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            TextButton(
                onPressed: () async {
                  await Navigator.push(context, MaterialPageRoute(builder: (context) => QueryPassword(passwordId: widget.passwordId)));
                  setState(() {
                    widget.onReturn();
                  });
                },
                child: const Icon(
                  Icons.arrow_forward_ios,
                  color: ThemeColors.blueText,
                ),
            )
          ],
        ),
      ),
    );
  }
}