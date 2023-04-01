import 'package:flutter/material.dart';
import 'package:one_water_mobile/constants/constant.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

Future addCartAlert({
  Key? key,
  dynamic context,
  TextEditingController? qtyController,
  dynamic onCancel,
  dynamic onOk,
}) async {
  return Alert(
    context: context,
    closeIcon: Icon(
      Icons.close_sharp,
      color: Colors.white,
    ),
    closeFunction: () {},
    content: Column(
      children: [
        Text(
          'ເພີ່ມເຂົ້າກະຕ່າ',
          style: TextStyle(
            fontFamily: fontFamily,
            fontSize: 20,
            color: fontColor,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          width: 90,
          child: Form(
            key: key,
            child: TextFormField(
              controller: qtyController,
              style: TextStyle(
                fontFamily: fontFamily,
                fontSize: 25,
              ),
              decoration: InputDecoration(
                hintText: '0',
              ),
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
            ),
          ),
        ),
      ],
    ),
    buttons: [
      DialogButton(
        onPressed: onCancel,
        child: Text(
          'ຍົກເລີກ',
          style: TextStyle(
            fontFamily: fontFamily,
            fontSize: 18,
            color: Colors.red,
          ),
        ),
        color: Colors.white,
      ),
      DialogButton(
        onPressed: onOk,
        child: Text(
          'ຕົກລົງ',
          style: TextStyle(
            fontFamily: fontFamily,
            fontSize: 18,
            color: Colors.blue,
          ),
        ),
        color: Colors.white,
      ),
    ],
  ).show();
}
