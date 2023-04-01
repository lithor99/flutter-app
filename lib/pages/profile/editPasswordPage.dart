import 'package:flutter/material.dart';
import 'package:one_water_mobile/constants/constant.dart';
import 'package:one_water_mobile/services/userService.dart';
import 'package:one_water_mobile/widgets/alertDialogWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditPasswordPage extends StatefulWidget {
  const EditPasswordPage({Key? key}) : super(key: key);

  @override
  _EditPasswordPageState createState() => _EditPasswordPageState();
}

class _EditPasswordPageState extends State<EditPasswordPage> {
  final formKey = GlobalKey<FormState>();
  FocusNode? focusNode;
  final TextEditingController? oldPassword = TextEditingController();
  final TextEditingController? newPassword = TextEditingController();
  bool? oldObscureText = true;
  bool? newObscureText = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColor,
        title: Text(
          "ປ່ຽນລະຫັດຜ່ານ",
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
        actions: [
          TextButton(
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                FocusScope.of(context).unfocus();
                var result = await UserService().changePassword(
                    newPassword: newPassword!.text,
                    oldPassword: oldPassword!.text);
                if (result == 'Successfuly') {
                  ResultDialog(
                    icon: Icons.check_circle,
                    iconColor: Colors.green,
                    title: 'ປ່ຽນລະຫັດຜ່ານສຳເລັດ',
                    titletColor: fontColor,
                    onOk: () {
                      Navigator.of(context).pop();
                    },
                  ).showResult(context).then((value) async {
                    SharedPreferences? preferences =
                        await SharedPreferences.getInstance();
                    setState(() {
                      preferences.setBool('rememberUser', false);
                    });
                  });
                } else if (result == 'PleaseCheckYourPasswordAgain') {
                  ResultDialog(
                    icon: Icons.warning_rounded,
                    iconColor: Colors.orange,
                    title: 'ລະຫັດຜ່ານເກົ່າບໍ່ຖືກຕ້ອງ',
                    titletColor: fontColor,
                    onOk: () {
                      Navigator.of(context).pop();
                    },
                  ).showResult(context);
                } else {
                  ResultDialog(
                    icon: Icons.error,
                    iconColor: Colors.red,
                    title: 'ປ່ຽນລະຫັດຜ່ານບໍ່ສຳເລັດ',
                    titletColor: Colors.red,
                    onOk: () {
                      Navigator.of(context).pop();
                    },
                  ).showResult(context);
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
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: oldPassword,
                  obscureText: oldObscureText!,
                  style: TextStyle(
                    fontFamily: fontFamily,
                    fontSize: 16,
                    color: fontColor,
                  ),
                  decoration: InputDecoration(
                    hintText: "ລະຫັດຜ່ານເກົ່າ",
                    labelText: 'ລະຫັດຜ່ານເກົ່າ',
                    labelStyle: TextStyle(
                      fontFamily: fontFamily,
                      color: labelTextColor,
                      fontSize: 16,
                    ),
                    hintStyle: TextStyle(
                      fontFamily: fontFamily,
                      color: hintTextColor,
                      fontSize: 16,
                    ),
                    prefixIcon: Icon(
                      Icons.vpn_key_rounded,
                      color: appColor,
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          oldObscureText = !oldObscureText!;
                        });
                      },
                      child: Icon(
                        oldObscureText!
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: oldObscureText! ? Colors.black : Colors.blue,
                      ),
                    ),
                    errorStyle: TextStyle(
                      fontFamily: fontFamily,
                      color: errorColor,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'ກະລຸນາປ້ອນລະຫັດຜ່ານເກົ່າ';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: newPassword,
                  obscureText: newObscureText!,
                  style: TextStyle(
                    fontFamily: fontFamily,
                    fontSize: 16,
                    color: fontColor,
                  ),
                  decoration: InputDecoration(
                    hintText: "ລະຫັດຜ່ານໃໝ່",
                    labelText: 'ລະຫັດຜ່ານໃໝ່',
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
                    prefixIcon: Icon(
                      Icons.vpn_key_rounded,
                      color: appColor,
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          newObscureText = !newObscureText!;
                        });
                      },
                      child: Icon(
                        newObscureText!
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: newObscureText! ? Colors.black : Colors.blue,
                      ),
                    ),
                    errorStyle: TextStyle(
                      fontFamily: fontFamily,
                      color: errorColor,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'ກະລຸນາປ້ອນລະຫັດຜ່ານໃໝ່';
                    } else if (value.length < 6) {
                      return 'ລະຫັດຜ່ານສັ້ນເກີນໄປ';
                    } else if (value.length > 20) {
                      return 'ລະຫັດຜ່ານຍາວເກີນໄປ';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
