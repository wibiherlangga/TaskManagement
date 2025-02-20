import 'package:flutter/material.dart';

mixin SnackBarMixin {
  Widget showLoadingPage(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  void showLoadingSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context)
        .showSnackBar(
          const SnackBar(
            content: Center(
              child: SizedBox(
                width: 40,
                height: 40,
                child: CircularProgressIndicator(),
              ),
            ),
            backgroundColor: Colors.transparent,
            duration: Duration(days: 1),
          ),
        )
        .closed
        .then((reason) {
      if (reason == SnackBarClosedReason.swipe) {
        showLoadingSnackBar(context);
      }
    });
  }

  void showErrorSnackBar(BuildContext context, {String? message}) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message ?? ''),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 5),
      ),
    );
  }

  void showSuccessSnackBar(BuildContext context,
      {String? message, VoidCallback? onClosed}) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context)
        .showSnackBar(
          SnackBar(
            content: Text(message ?? ''),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 2),
          ),
        )
        .closed
        .then(
      (_) {
        if (onClosed != null) {
          onClosed();
        }
      },
    );
  }

  void removeSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
  }
}
