import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  final Object? param;

  const ErrorPage({super.key, this.param});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Text(
            param != null ? 'Unexpected error: $param.' : 'Unexpected error.'),
      ),
    );
  }
}
