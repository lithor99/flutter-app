import 'package:flutter/material.dart';
import 'package:one_water_mobile/constants/constant.dart';

class OrderCart extends StatelessWidget {
  const OrderCart({
    Key? key,
    this.productImage,
    this.productName,
    this.productQty,
    this.productPrice,
    this.orderTotal,
    this.removeOrder,
    this.addOrder,
  }) : super(key: key);

  final String? productImage;
  final String? productName;
  final int? productQty;
  final double? productPrice;
  final int? orderTotal;
  final dynamic removeOrder;
  final dynamic addOrder;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Image.network(
                productImage!,
                scale: 1.0,
                height: 100,
                width: 200,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "ນໍ້າດື່ມຕຸກໃຫຍ່",
                    style: TextStyle(
                      fontFamily: fontFamily,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "ຈໍານວນ: " + "100",
                    style: TextStyle(
                      fontFamily: fontFamily,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "ລາຄາ: 5000",
                    style: TextStyle(
                      fontFamily: fontFamily,
                      color: Colors.orange,
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      InkWell(
                        onTap: removeOrder,
                        child: CircleAvatar(
                          backgroundColor: errorColor,
                          child: Text(
                            "-",
                            style: TextStyle(
                              fontFamily: fontFamily,
                              fontSize: 24,
                              color: whiteColor,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        orderTotal.toString(),
                        style: TextStyle(
                          fontFamily: fontFamily,
                          fontSize: 24,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      InkWell(
                        onTap: addOrder,
                        child: CircleAvatar(
                          backgroundColor: successColor,
                          child: Text(
                            "+",
                            style: TextStyle(
                              fontFamily: fontFamily,
                              fontSize: 24,
                              color: whiteColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
