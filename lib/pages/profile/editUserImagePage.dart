// ignore_for_file: unrelated_type_equality_checks

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:one_water_mobile/constants/constant.dart';
import 'package:one_water_mobile/models/customer.dart';
import 'package:one_water_mobile/pages/profile/userImagePage.dart';
import 'package:one_water_mobile/widgets/alertDialogWidget.dart';
import 'package:one_water_mobile/services/customerService.dart';
import 'package:one_water_mobile/widgets/errorWidgets.dart';
import 'package:one_water_mobile/widgets/loadingWidgets.dart';
import 'package:one_water_mobile/widgets/nullWidgets.dart';
import 'package:permission_handler/permission_handler.dart';

class EditUserImagePage extends StatefulWidget {
  const EditUserImagePage({Key? key}) : super(key: key);

  @override
  _EditUserImagePageState createState() => _EditUserImagePageState();
}

class _EditUserImagePageState extends State<EditUserImagePage> {
  Future imageFromCamera() async {
    final status = await Permission.storage.request();
    if (status.isGranted) {
      var imageCamera = await imagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 50,
      );
      if (imageCamera != null) {
        setState(() {
          imageFile = File(imageCamera.path);
        });
      }
    }
    return imageFile;
  }

  Future imageFromGallery() async {
    final status = await Permission.storage.request();
    if (status.isGranted) {
      var imageGallery = await imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
      );
      if (imageGallery != null) {
        setState(() {
          imageFile = File(imageGallery.path);
        });
      }
    }
    return imageFile;
  }

  final formKey = GlobalKey<FormState>();
  FocusNode? focusNode;
  final imagePicker = ImagePicker();
  File? imageFile;
  String? imageNetwork;
  String? id;
  final TextEditingController? firstNameController = TextEditingController();
  final TextEditingController? lastNameController = TextEditingController();
  final TextEditingController? phoneNumberController = TextEditingController();
  final TextEditingController? emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColor,
        title: Text(
          "ປ່ຽນຮູບພາບ",
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
      body: Center(
        child: FutureBuilder(
          future: CustomerService().getCustomer(),
          builder: (context, AsyncSnapshot? snapshot) {
            if (snapshot!.hasData) {
              if (snapshot.data.toString() != 'null') {
                Customer? customer = snapshot.data;
                id = customer!.id;
                if (imageNetwork == '') {
                  imageNetwork = customer.image!;
                }
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (vale) => ShowUserImage(
                              image: customer.image,
                            ),
                          ),
                        );
                      },
                      child: CircleAvatar(
                        backgroundColor: appColor1,
                        radius: 100,
                        child: customer.image != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(100.0),
                                child: FadeInImage.assetNetwork(
                                  placeholder: gitLoading!,
                                  image: customer.image!,
                                  fit: BoxFit.cover,
                                  height: 200,
                                  width: 200,
                                ),
                              )
                            : Icon(
                                Icons.account_circle,
                                color: colorWhiteGrey,
                                size: 200,
                              ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        var uploadImage;
                        ChooseImageDialog(
                          onCameraPressed: () {
                            Navigator.of(context).pop();
                            imageFromCamera().then(
                              (value) {
                                if (value != null) {
                                  UploadImageDialog(
                                    imageFile: imageFile,
                                    onCancel: () {
                                      Navigator.of(context).pop();
                                    },
                                    onOk: () async {
                                      Navigator.of(context).pop();
                                      uploadImage =
                                          await CustomerService().uploadImage(
                                        id: id!,
                                        image: imageFile,
                                      );
                                      if (uploadImage == 'Successful') {
                                        return ResultDialog(
                                          icon: Icons.check_circle,
                                          iconColor: Colors.green,
                                          title: 'ອັບໂຫຼດຮູບພາບສຳເລັດ',
                                          titletColor: fontColor,
                                          onOk: () {
                                            Navigator.of(context).pop();
                                            setState(() {});
                                          },
                                        ).showResult(context);
                                      } else if (uploadImage ==
                                          'Upload failed') {
                                        return ResultDialog(
                                          icon: Icons.error,
                                          iconColor: Colors.red,
                                          title: 'ອັບໂຫຼດຮູບພາບບໍ່ສຳເລັດ',
                                          titletColor: Colors.red,
                                          onOk: () {
                                            Navigator.of(context).pop();
                                          },
                                        ).showResult(context);
                                      }
                                    },
                                  ).uploadImage(context);
                                }
                              },
                            );
                          },
                          onGalleryPressed: () {
                            Navigator.of(context).pop();
                            imageFromGallery().then((value) {
                              if (value != null) {
                                UploadImageDialog(
                                  imageFile: imageFile,
                                  onCancel: () {
                                    Navigator.of(context).pop();
                                  },
                                  onOk: () async {
                                    Navigator.of(context).pop();
                                    uploadImage =
                                        await CustomerService().uploadImage(
                                      id: id!,
                                      image: imageFile,
                                    );
                                    if (uploadImage == 'Successful') {
                                      return ResultDialog(
                                        icon: Icons.check_circle,
                                        iconColor: Colors.green,
                                        title: 'ອັບໂຫຼດຮູບພາບສຳເລັດ',
                                        titletColor: fontColor,
                                        onOk: () {
                                          Navigator.of(context).pop();
                                          setState(() {});
                                        },
                                      ).showResult(context);
                                    } else if (uploadImage == 'Upload failed') {
                                      return ResultDialog(
                                        icon: Icons.error,
                                        iconColor: Colors.red,
                                        title: 'ອັບໂຫຼດຮູບພາບບໍ່ສຳເລັດ',
                                        titletColor: Colors.red,
                                        onOk: () {
                                          Navigator.of(context).pop();
                                        },
                                      ).showResult(context);
                                    }
                                  },
                                ).uploadImage(context);
                              }
                            });
                          },
                        ).chooseImage(context);
                      },
                      child: Text(
                        'ເລືອກຮູບພາບ',
                        style: TextStyle(
                          fontFamily: fontFamily,
                          fontSize: 18,
                          color: fontColor,
                        ),
                      ),
                    ),
                  ],
                );
              }
              return NullWidgets();
            } else if (snapshot.hasError) {
              return ErrorWidgets();
            }
            return LoadingWidgets();
          },
        ),
      ),
    );
  }
}
