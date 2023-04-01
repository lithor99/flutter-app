import 'package:flutter/material.dart';
import 'package:one_water_mobile/constants/constant.dart';
import 'package:one_water_mobile/services/cartService.dart';
import 'package:one_water_mobile/services/orderService.dart';

class ChoosePaymentPage extends StatefulWidget {
  const ChoosePaymentPage({Key? key, this.datas}) : super(key: key);
  static String? orderResult;
  final List<List>? datas;

  @override
  _ChoosePaymentPageState createState() => _ChoosePaymentPageState();
}

class _ChoosePaymentPageState extends State<ChoosePaymentPage> {
  bool? cash = false;
  bool? card = false;
  bool? checkedPayment = true;
  String? pleaseChoosePayment;
  String? paymentType;

  @override
  Widget build(BuildContext context) {
    double? w = MediaQuery.of(context).size.width * 0.7;
    double? h = MediaQuery.of(context).size.width * 0.6;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Card(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(5),
            ),
            height: card == true ? h + 220 : h,
            width: w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(height: 5),
                Text(
                  'ເລືອກຮູບແບບການຊຳລະ',
                  style: TextStyle(
                    fontFamily: fontFamily,
                    fontSize: 18,
                    color: fontColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Checkbox(
                              value: card,
                              checkColor: whiteColor,
                              activeColor: appColor,
                              onChanged: (value) {
                                setState(() {
                                  card = value;
                                  cash = !value!;
                                  checkedPayment = true;
                                  paymentType = 'CARD';
                                  pleaseChoosePayment = '';
                                });
                              }),
                          Text(
                            'ຈ່າຍຜ່ານບັດ',
                            style: TextStyle(
                              fontFamily: fontFamily,
                              fontSize: 16,
                              color: fontColor,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Checkbox(
                              value: cash,
                              checkColor: whiteColor,
                              activeColor: appColor,
                              onChanged: (value) {
                                setState(() {
                                  cash = value;
                                  card = !value!;
                                  checkedPayment = true;
                                  paymentType = 'CASH';
                                  pleaseChoosePayment = '';
                                });
                              }),
                          Text(
                            'ຈ່າຍເງິນສົດ',
                            style: TextStyle(
                              fontFamily: fontFamily,
                              fontSize: 16,
                              color: fontColor,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                if (card == true)
                  Image.asset(
                    onePayQr!,
                    scale: 1.0,
                    height: 260,
                    width: 260,
                  ),
                if (card == false && cash == false && checkedPayment == false)
                  Text(
                    pleaseChoosePayment!,
                    style: TextStyle(
                      fontFamily: fontFamily,
                      color: Colors.red,
                      fontSize: 16,
                    ),
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'ຍົກເລີກ',
                        style: TextStyle(
                          fontFamily: fontFamily,
                          color: Colors.red,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    TextButton(
                      child: Text(
                        'ຕົກລົງ',
                        style: TextStyle(
                          fontFamily: fontFamily,
                          color: Colors.blue,
                          fontSize: 18,
                        ),
                      ),
                      onPressed: () async {
                        if (cash == false && card == false) {
                          setState(() {
                            pleaseChoosePayment = 'ກະລຸນາເລືອກແບບຊຳລະກ່ອນ';
                            checkedPayment = false;
                          });
                        } else {
                          var res = await OrderService().addOrder(
                            datas: widget.datas,
                            paymentType: paymentType,
                            totalPayment: CartService.amount, 
                          );
                          if (res == 'Success') {
                            setState(() {
                              ChoosePaymentPage.orderResult = 'Success';
                            });
                          } else {
                            setState(() {
                              ChoosePaymentPage.orderResult = '';
                            });
                          }
                          Navigator.of(context).pop();
                        }
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
