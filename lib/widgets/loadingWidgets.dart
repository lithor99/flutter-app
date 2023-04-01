import 'package:flutter/material.dart';
import 'package:one_water_mobile/constants/constant.dart';

class LoadingWidgets extends StatelessWidget {
  const LoadingWidgets({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(color: appColor),
    );
  }
}
