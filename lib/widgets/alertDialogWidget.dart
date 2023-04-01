import 'dart:io';
import 'package:flutter/material.dart';
import 'package:one_water_mobile/constants/constant.dart';

class ChooseImageDialog {
  dynamic onCameraPressed;
  dynamic onGalleryPressed;
  ChooseImageDialog({
    this.onCameraPressed,
    this.onGalleryPressed,
  });
  Future chooseImage(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'ເລືອກຮູບພາບ',
            style: TextStyle(
              fontFamily: fontFamily,
              fontSize: 18,
              color: appColor,
            ),
            textAlign: TextAlign.center,
          ),
          content: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                child: Icon(
                  Icons.photo_camera,
                  size: 80,
                  color: appColor,
                ),
                onTap: onCameraPressed,
              ),
              InkWell(
                child: Icon(
                  Icons.photo,
                  size: 80,
                  color: appColor,
                ),
                onTap: onGalleryPressed,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'ຍົກເລີກ',
                style: TextStyle(
                  fontFamily: fontFamily,
                  fontSize: 18,
                  color: Colors.red,
                ),
              ),
            )
          ],
        );
      },
    );
  }
}

class UploadImageDialog {
  File? imageFile;
  dynamic onCancel;
  dynamic onOk;
  UploadImageDialog({
    this.imageFile,
    this.onCancel,
    this.onOk,
  });

  Future uploadImage(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'ອັບໂຫຼດຮູບພາບ',
            style: TextStyle(
              fontFamily: fontFamily,
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
          content: CircleAvatar(
            radius: 60,
            backgroundImage: FileImage(imageFile!),
            backgroundColor: appColor,
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: onCancel,
                  child: Text(
                    'ຍົກເລີກ',
                    style: TextStyle(
                      fontFamily: fontFamily,
                      fontSize: 18,
                      color: Colors.red,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: onOk,
                  child: Text(
                    'ຕົກລົງ',
                    style: TextStyle(
                      fontFamily: fontFamily,
                      fontSize: 18,
                      color: Colors.blue,
                    ),
                  ),
                )
              ],
            )
          ],
        );
      },
    );
  }
}

class ResultDialog {
  IconData? icon;
  Color? iconColor;
  String? title;
  Color? titletColor;
  dynamic onOk;
  ResultDialog({
    this.icon,
    this.iconColor,
    this.title,
    this.titletColor,
    this.onOk,
  });

  Future showResult(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            height: MediaQuery.of(context).size.width / 3,
            width: MediaQuery.of(context).size.width / 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(icon, color: iconColor, size: 80),
                Text(
                  title!,
                  style: TextStyle(
                    fontFamily: fontFamily,
                    fontSize: 18,
                    color: titletColor,
                  ),
                )
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: onOk,
              child: Text(
                'ຕົກລົງ',
                style: TextStyle(
                  fontFamily: fontFamily,
                  fontSize: 18,
                  color: Colors.blue,
                ),
              ),
            )
          ],
        );
      },
    );
  }
}

class ChoiceDialog {
  IconData? icon;
  Color? iconColor;
  String? title;
  dynamic onOk;
  dynamic onCancel;
  ChoiceDialog({
    this.icon,
    this.iconColor,
    this.title,
    this.onOk,
    this.onCancel,
  });

  Future showChoice(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            height: MediaQuery.of(context).size.width / 3,
            width: MediaQuery.of(context).size.width / 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(icon, color: iconColor, size: 80),
                Text(
                  title!,
                  style: TextStyle(
                    fontFamily: fontFamily,
                    fontSize: 18,
                    color: Colors.red,
                  ),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: onCancel,
              child: Text(
                'ຍົກເລີກ',
                style: TextStyle(
                  fontFamily: fontFamily,
                  fontSize: 18,
                  color: Colors.blue,
                ),
              ),
            ),
            const Spacer(),
            TextButton(
              onPressed: onOk,
              child: Text(
                'ຕົກລົງ',
                style: TextStyle(
                  fontFamily: fontFamily,
                  fontSize: 18,
                  color: Colors.red,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
