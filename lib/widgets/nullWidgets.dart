import 'package:flutter/material.dart';
import 'package:one_water_mobile/constants/constant.dart';

class NullWidgets extends StatelessWidget {
  const NullWidgets({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'ຂໍ້ມູນຫວ່າງເປົ່າ',
        style: TextStyle(
          fontFamily: fontFamily,
          fontSize: 20,
          color: fontColor,
        ),
      ),
    );
  }
}
