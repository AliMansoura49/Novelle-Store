import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
class SuccessDialog extends StatelessWidget {
  final String titile;
  final String subtitle;
  final String buttonText;
  final VoidCallback onButtonClick;
  const SuccessDialog({
    super.key,
    this.titile = "Success!",
    this.buttonText = "OK",
    required this.subtitle,
    required this.onButtonClick
    });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Dialog(
      
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
              width: 100,
              child: Lottie.asset(
                'assets/lottie/success.json',
              repeat: false,
              reverse: false,
              ),
            ),
            SizedBox(height: 16,),
            Text(
              "Success!",
              style: textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w800
              ),
            ),
            SizedBox(height: 8,),
            Text(
              subtitle,
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant
              ),
            ),
            SizedBox(height: 16,),
            FilledButton(
              style: FilledButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                minimumSize: Size(double.infinity, 60),
              ),
              onPressed: () {
                onButtonClick();
                Navigator.of(context).pop();
              },
              child: Text(buttonText),
            )
          ],
        ),
      ),
    );
  }
}