import 'package:flutter/material.dart';
import 'package:one_water_mobile/constants/constant.dart';

class ShowUserImage extends StatelessWidget {
  const ShowUserImage({Key? key, this.image}) : super(key: key);
  final String? image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackgroundColor,
      appBar: AppBar(
        backgroundColor: appColor,
        title: Text(
          "ຮູບພາບ",
          style: TextStyle(
            fontFamily: fontFamily,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(5),
        child: Center(
          child: image == null
              ? Text(
                  'ບໍ່ມີຮູບພາບ',
                  style: TextStyle(
                    fontFamily: 'NotoSans',
                    fontSize: 20,
                    color: Colors.white,
                  ),
                )
              : InteractiveViewer(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(0.0),
                    child: FadeInImage.assetNetwork(
                      placeholder: gitLoading!,
                      image: image!,
                    ),
                  ),
                  panEnabled: true,
                  minScale: 1,
                  maxScale: 5,
                ),
        ),
      ),
    );
  }
}
