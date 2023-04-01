// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:one_water_mobile/constants/constant.dart';
import 'package:one_water_mobile/models/customer.dart';
import 'package:one_water_mobile/widgets/alertDialogWidget.dart';
import 'package:one_water_mobile/services/customerService.dart';
import 'package:one_water_mobile/widgets/errorWidgets.dart';
import 'package:one_water_mobile/widgets/loadingWidgets.dart';
import 'package:one_water_mobile/widgets/nullWidgets.dart';

class EditUserInfoPage extends StatefulWidget {
  const EditUserInfoPage({Key? key}) : super(key: key);

  @override
  _EditUserInfoPageState createState() => _EditUserInfoPageState();
}

class _EditUserInfoPageState extends State<EditUserInfoPage> {
  final formKey = GlobalKey<FormState>();
  FocusNode? focusNode;
  String? id;
  var getCustomer;
  final TextEditingController? firstNameController = TextEditingController();
  final TextEditingController? lastNameController = TextEditingController();
  final TextEditingController? phoneNumberController = TextEditingController();
  final TextEditingController? emailController = TextEditingController();

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    getCustomer = await CustomerService().getCustomer();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColor,
        title: Text(
          "ແກ້ໄຂຂໍ້ມູນສ່ວນຕົວ",
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
        actions: getCustomer.toString() != 'null'
            ? [
                TextButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      FocusScope.of(context).unfocus();
                      var updateUser;
                      updateUser = await CustomerService().updateCustomer(
                        id: id,
                        firstName: firstNameController!.text,
                        lastName: lastNameController!.text,
                        phoneNumber: phoneNumberController!.text,
                        email: emailController!.text,
                      );
                      if (updateUser == 'Successful') {
                        ResultDialog(
                          icon: Icons.check_circle,
                          iconColor: Colors.green,
                          title: 'ແກ້ໄຂຂໍ້ມູນສຳເລັດ',
                          titletColor: fontColor,
                          onOk: () {
                            Navigator.of(context).pop();
                            CustomerService().getCustomer();
                            setState(() {});
                          },
                        ).showResult(context);
                      } else if (updateUser == 'Update failed') {
                        ResultDialog(
                          icon: Icons.error,
                          iconColor: Colors.red,
                          title: 'ແກ້ໄຂຂໍ້ມູນບໍ່ສຳເລັດ',
                          titletColor: Colors.red,
                          onOk: () {
                            Navigator.of(context).pop();
                          },
                        ).showResult(context);
                      } else {
                        Center(
                          child: CircularProgressIndicator(color: appColor),
                        );
                      }
                    }
                  },
                  child: Text(
                    "ບັນທຶກ",
                    style: TextStyle(
                      fontFamily: fontFamily,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: whiteColor,
                    ),
                  ),
                ),
              ]
            : [],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: FutureBuilder(
          future: CustomerService().getCustomer(),
          builder: (context, AsyncSnapshot? snapshot) {
            if (snapshot!.hasData) {
              if (snapshot.data.toString() != 'null') {
                Customer? customer = snapshot.data;
                id = customer!.id;
                if (firstNameController!.text == '' ||
                    firstNameController!.text.isEmpty) {
                  firstNameController!.text = customer.firstName!;
                }

                if (lastNameController!.text == '' ||
                    lastNameController!.text.isEmpty) {
                  lastNameController!.text = customer.lastName!;
                }
                if (phoneNumberController!.text == '' ||
                    phoneNumberController!.text.isEmpty) {
                  phoneNumberController!.text = customer.phoneNumber!;
                }
                if (emailController!.text == '' ||
                    emailController!.text.isEmpty) {
                  emailController!.text = customer.email!;
                }
                return Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextFormField(
                        controller: firstNameController,
                        style: TextStyle(
                          fontFamily: fontFamily,
                          fontSize: 16,
                          color: fontColor,
                        ),
                        decoration: InputDecoration(
                          hintText: "ຊື່",
                          labelText: 'ຊື່',
                          labelStyle: TextStyle(
                            fontFamily: fontFamily,
                            fontSize: 16,
                            color: labelTextColor,
                          ),
                          hintStyle: TextStyle(
                            fontFamily: fontFamily,
                            fontSize: 16,
                            color: hintTextColor,
                          ),
                          errorStyle: TextStyle(
                            fontFamily: fontFamily,
                            color: errorColor,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'ກະລຸນາປ້ອນຊື່';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: lastNameController,
                        style: TextStyle(
                          fontFamily: fontFamily,
                          fontSize: 16,
                          color: fontColor,
                        ),
                        decoration: InputDecoration(
                          hintText: "ນາມສະກຸນ",
                          labelText: 'ນາມສະກຸນ',
                          labelStyle: TextStyle(
                            fontFamily: fontFamily,
                            fontSize: 16,
                            color: labelTextColor,
                          ),
                          hintStyle: TextStyle(
                            fontFamily: fontFamily,
                            fontSize: 16,
                            color: hintTextColor,
                          ),
                          errorStyle: TextStyle(
                            fontFamily: fontFamily,
                            color: errorColor,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'ກະລຸນາປ້ອນນາມສະກຸນ';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: phoneNumberController,
                        style: TextStyle(
                          fontFamily: fontFamily,
                          fontSize: 16,
                          color: fontColor,
                        ),
                        decoration: InputDecoration(
                          hintText: "ເບີໂທ",
                          labelText: 'ເບີໂທ',
                          labelStyle: TextStyle(
                            fontFamily: fontFamily,
                            fontSize: 16,
                            color: labelTextColor,
                          ),
                          hintStyle: TextStyle(
                            fontFamily: fontFamily,
                            color: hintTextColor,
                          ),
                          errorStyle: TextStyle(
                            fontFamily: fontFamily,
                            color: errorColor,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'ກະລຸນາປ້ອນເບີໂທ';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.phone,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: emailController,
                        style: TextStyle(
                          fontFamily: fontFamily,
                          fontSize: 16,
                          color: fontColor,
                        ),
                        decoration: InputDecoration(
                          hintText: "ອີເມວ",
                          labelText: 'ອີເມວ',
                          labelStyle: TextStyle(
                            fontFamily: fontFamily,
                            fontSize: 16,
                            color: labelTextColor,
                          ),
                          hintStyle: TextStyle(
                            fontFamily: fontFamily,
                            color: hintTextColor,
                          ),
                          errorStyle: TextStyle(
                            fontFamily: fontFamily,
                            color: errorColor,
                          ),
                        ),
                        validator: (value) {
                          if (value == '' || value!.isEmpty) {
                            return 'ກະລຸນາປ້ອນອີເມລ';
                          } else if (!regExp!.hasMatch(value)) {
                            return 'ອີເມລບໍ່ຖືກຕ້ອງ';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ],
                  ),
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
