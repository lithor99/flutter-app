import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:one_water_mobile/constants/constant.dart';
import 'package:one_water_mobile/pages/expence/expencePage.dart';

class ExpenceFilterPage extends StatefulWidget {
  const ExpenceFilterPage({Key? key}) : super(key: key);

  @override
  _ExpenceFilterPageState createState() => _ExpenceFilterPageState();
}

class _ExpenceFilterPageState extends State<ExpenceFilterPage> {
  final formKey = GlobalKey<FormState>();
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  String? startDate;
  String? endDate;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            height: MediaQuery.of(context).size.width * 0.8,
            width: MediaQuery.of(context).size.width - 30,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'ສະແດງລາຍຈ່າຍລະຫວ່າງວັນທີ',
                    style: TextStyle(
                      fontFamily: fontFamily,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 2 - 50,
                        child: TextFormField(
                          controller: startDateController,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "ກະລຸນາເລືອກວັນທີ";
                            }
                            return null;
                          },
                          style: TextStyle(
                            fontFamily: fontFamily,
                          ),
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            hintText: 'ເລືອກຈາກວັນທີ',
                            hintStyle: TextStyle(
                              fontFamily: fontFamily,
                              fontSize: 14,
                              color: hintTextColor,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                selectStartDateFunc(context);
                              },
                              icon: Icon(
                                Icons.today,
                                color: appColor,
                              ),
                            ),
                            errorStyle: TextStyle(
                              fontFamily: fontFamily,
                              color: errorColor,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 40,
                        child: Center(
                          child: Text(
                            'ຫາ',
                            style: TextStyle(
                              fontFamily: fontFamily,
                              fontSize: 20,
                              color: fontColor,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 2 - 50,
                        child: TextFormField(
                          controller: endDateController,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "ກະລຸນາເລືອກວັນທີ";
                            }
                            return null;
                          },
                          style: TextStyle(
                            fontFamily: fontFamily,
                          ),
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            hintText: 'ເລືອກຫາວັນທີ',
                            hintStyle: TextStyle(
                              fontFamily: fontFamily,
                              fontSize: 14,
                              color: hintTextColor,
                            ),
                            errorStyle: TextStyle(
                              fontFamily: fontFamily,
                              color: errorColor,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                selectEndDateFunc(context);
                              },
                              icon: Icon(
                                Icons.today,
                                color: appColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 45,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'ຍົກເລີກ',
                            style: TextStyle(
                              fontFamily: fontFamily,
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(pendingColor),
                          ),
                        ),
                      ),
                      Container(
                        height: 45,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: ElevatedButton(
                          child: Text(
                            'ຕົກລົງ',
                            style: TextStyle(
                              fontFamily: fontFamily,
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ExpencePage(
                                    startDate: startDate,
                                    endDate: endDate,
                                  ),
                                ),
                              );
                            }
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.blue),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void selectStartDateFunc(BuildContext context) async {
    final DateTime? date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime(2032));
    if (date != null) {
      setState(() {
        startDate = date.toString();
        startDateController.text =
            DateFormat('dd-MM-yyyy').format(date).toString();
      });
    }
  }

  void selectEndDateFunc(BuildContext context) async {
    final DateTime? date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2021),
        lastDate: DateTime(2032));
    if (date != null) {
      setState(() {
        print(date);
        endDate = date.toString();
        endDateController.text =
            DateFormat('dd-MM-yyyy').format(date).toString();
      });
    }
  }
}
