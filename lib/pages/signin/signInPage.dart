import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:one_water_mobile/constants/constant.dart';
import 'package:one_water_mobile/services/userService.dart';
import 'package:one_water_mobile/widgets/alertDialogWidget.dart';
import 'package:one_water_mobile/widgets/elevatedButtonWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../home/homePage.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final formKey = GlobalKey<FormState>();
  String? token;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool? obscureText = true;
  bool? checkedBox = false;
  bool? rememberUser;
  Color? usernameTextColor = Colors.black;
  Color? passwordTextColor = Colors.black;
  String? usernameOrPasswordFaild = '';

  Future checkRemember() async {
    SharedPreferences? preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('token');
    rememberUser = preferences.getBool('rememberUser');
    if (rememberUser != null) {
      setState(() {
        checkedBox = rememberUser;
      });
    }
    if (token != null && rememberUser == true) {
      bool? isExpired = JwtDecoder.isExpired(token);
      if (isExpired == false &&
          preferences.getString('userName') != null &&
          preferences.getString('password') != null) {
        setState(() {
          usernameController.text =
              preferences.getString('userName').toString();
          passwordController.text =
              preferences.getString('password').toString();
        });
      } else {
        preferences.setBool('rememberUser', false);
      }
    }
  }

  @override
  void initState() {
    checkRemember();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                appLogo!,
                scale: 1.0,
                height: 200,
                width: 200,
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Form(
                  key: formKey,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: usernameController,
                            inputFormatters: [
                              FilteringTextInputFormatter.deny(RegExp(r'\s'))
                            ],
                            style: TextStyle(
                              fontFamily: fontFamily,
                              fontSize: 20,
                              color: usernameTextColor,
                            ),
                            textAlign: TextAlign.start,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'ກະລຸນາປ້ອນຊື່ຜູ້ໃຊ້';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 15,
                                horizontal: 0,
                              ),
                              prefixIcon: Icon(
                                Icons.person,
                                color: appColor,
                              ),
                              labelText: 'ຊື່ຜູ້ໃຊ້',
                              labelStyle: TextStyle(
                                fontFamily: fontFamily,
                                color: labelTextColor,
                              ),
                              hintText: 'ຊື່ຜູ້ໃຊ້',
                              hintStyle: TextStyle(
                                fontFamily: fontFamily,
                                color: hintTextColor,
                              ),
                              errorStyle: TextStyle(
                                fontFamily: fontFamily,
                                color: errorColor,
                              ),
                            ),
                          ),
                          TextFormField(
                            controller: passwordController,
                            inputFormatters: [
                              FilteringTextInputFormatter.deny(RegExp(r'\s'))
                            ],
                            style: TextStyle(
                              fontFamily: fontFamily,
                              fontSize: 20,
                              color: passwordTextColor,
                            ),
                            textAlign: TextAlign.start,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'ກະລຸນາປ້ອນລະຫັດຜ່ານ';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 15,
                                horizontal: 0,
                              ),
                              labelText: 'ລະຫັດຜ່ານ',
                              labelStyle: TextStyle(
                                fontFamily: fontFamily,
                                color: labelTextColor,
                              ),
                              hintText: 'ລະຫັດຜ່ານ',
                              hintStyle: TextStyle(
                                fontFamily: fontFamily,
                                color: hintTextColor,
                              ),
                              prefixIcon: Icon(
                                Icons.vpn_key_rounded,
                                color: appColor,
                              ),
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    obscureText = !obscureText!;
                                  });
                                },
                                child: Icon(
                                  obscureText!
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color:
                                      obscureText! ? Colors.black : Colors.blue,
                                ),
                              ),
                            ),
                            obscureText: obscureText!,
                          ),
                          Row(
                            children: [
                              Checkbox(
                                value: checkedBox,
                                checkColor: whiteColor,
                                activeColor: appColor,
                                onChanged: (value) async {
                                  SharedPreferences? preferences =
                                      await SharedPreferences.getInstance();
                                  setState(() {
                                    checkedBox = value;
                                    preferences.setBool(
                                        'rememberUser', checkedBox!);
                                  });
                                },
                              ),
                              Text(
                                'ຈື່ຜູ້ໃຊ້ໄວ້',
                                style: TextStyle(
                                  fontFamily: fontFamily,
                                  color: hintTextColor,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ElevateButton(
                            height: 60,
                            width: (MediaQuery.of(context).size.width) - 20,
                            buttonColor: appColor,
                            title: 'ເຂົ້າສູ່ລະບົບ',
                            fontColor: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                await UserService().rememberUser(
                                  userName: usernameController.text,
                                  password: passwordController.text,
                                );
                                var res = await UserService().signIn(
                                  usernameController.text,
                                  passwordController.text,
                                );
                                if (res.toString() != '') {
                                  if (res.toString() ==
                                      'USERNAME_OR_PASSWORD_FAILED') {
                                    ResultDialog(
                                      title:
                                          'ຊື່ຜູ້ໃຊ້ ຫຼື ລະຫັດຜ່ານບໍ່ຖືກຕ້ອງ',
                                      icon: Icons.error,
                                      iconColor: Colors.red,
                                      onOk: () {
                                        Navigator.of(context).pop();
                                      },
                                    ).showResult(context).then((value) {
                                      setState(() {
                                        usernameController.clear();
                                        passwordController.clear();
                                      });
                                    });
                                  } else {
                                    Navigator.of(context).pop();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (value) => HomePage(),
                                      ),
                                    );
                                  }
                                }
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
