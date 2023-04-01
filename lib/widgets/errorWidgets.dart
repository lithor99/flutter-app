import 'package:flutter/material.dart';
import 'package:one_water_mobile/constants/constant.dart';

class ErrorWidgets extends StatelessWidget {
  const ErrorWidgets({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.error, size: 35, color: Colors.red),
          SizedBox(width: 10),
          Text(
            "ຜິດພາດ",
            style: TextStyle(
              fontFamily: fontFamily,
              fontSize: 20,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
