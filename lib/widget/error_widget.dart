import 'package:flutter/material.dart';

class ErrorCard extends StatelessWidget {
  const ErrorCard({
    super.key,
    required this.message
    });
  
  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Text(
          message,
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}