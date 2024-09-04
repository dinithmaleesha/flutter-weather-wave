import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weather_app/util/color_pallet.dart';

class PopupHandler {
  static void showErrorDialog(BuildContext context, {required String message}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: ColorPallet.offWhite,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          title: Row(
            children: [
              Icon(Icons.error_outline, color: ColorPallet.blue),
              SizedBox(width: 8),
              Text('Error', style: TextStyle(color: ColorPallet.blue)),
            ],
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  message,
                  style: TextStyle(color: ColorPallet.black_opacity, fontSize: 16),
                ),
                SizedBox(height: 20),
                Text(
                  'Please try again later.',
                  style: TextStyle(color: ColorPallet.gray, fontSize: 14),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                SystemNavigator.pop();
              },
              style: TextButton.styleFrom(
                backgroundColor: ColorPallet.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'OK',
                style: TextStyle(color: ColorPallet.white),
              ),
            ),
          ],
        );
      },
    );
  }
}
