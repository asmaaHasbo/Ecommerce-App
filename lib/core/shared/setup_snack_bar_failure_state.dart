import 'package:flutter/material.dart';

////setup snackbar when state is failure
setupSnackbarForFailureState(BuildContext context, String errMsg) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        errMsg,
        style: const TextStyle(color: Colors.white, fontSize: 14),
        maxLines: 10, // السماح بعرض أكثر من سطر
        overflow: TextOverflow.visible, // عرض كل النص
      ),
      backgroundColor: Colors.red.shade700,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      duration: const Duration(seconds: 6), // وقت أطول للرسائل الطويلة
      action: SnackBarAction(
        label: 'OK',
        textColor: Colors.white,
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
    ),
  );
}
