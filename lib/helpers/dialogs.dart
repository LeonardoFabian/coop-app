import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

// adapt to null safety

infoDialog(
    {required BuildContext context,
    required String title,
    required String content}) {
  // iOS
  if (Platform.isIOS) {
    return showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text(title),
            content: Text(content),
            actions: <Widget>[
              CupertinoDialogAction(
                  isDefaultAction: true,
                  child: const Text('Cancelar'),
                  onPressed: () => Navigator.pop(context)),
              CupertinoDialogAction(
                isDefaultAction: true,
                child: const Text('Ir'),
                onPressed: () => print('Mostrando el dialogo'),
              ),
            ],
          );
        });
  }

  // Android
  if (Platform.isAndroid) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: <Widget>[
              TextButton(
                  child: const Text('Cancelar'),
                  onPressed: () => Navigator.pop(context)),
              TextButton(
                child: const Text('Ir'),
                onPressed: () => print('Mostrando el dialogo'),
              ),
            ],
          );
        });
  }
}
