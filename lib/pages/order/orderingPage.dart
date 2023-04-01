import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:one_water_mobile/constants/constant.dart';
import 'package:one_water_mobile/models/orders.dart';
import 'package:one_water_mobile/pages/cart/cartPage.dart';
import 'package:one_water_mobile/pages/order/orderDetailPage.dart';
import 'package:one_water_mobile/services/cartService.dart';
import 'package:one_water_mobile/services/orderService.dart';
import 'package:one_water_mobile/widgets/errorWidgets.dart';
import 'package:one_water_mobile/widgets/loadingWidgets.dart';
import 'package:one_water_mobile/widgets/nullWidgets.dart';
import 'package:qr_flutter/qr_flutter.dart';

class OrderingPage extends StatefulWidget {
  const OrderingPage({Key? key}) : super(key: key);

  @override
  _OrderingPageState createState() => _OrderingPageState();
}

class _OrderingPageState extends State<OrderingPage> {
  Future refresh() async {
    await CartService().getCart();
    setState(() {});
  }

  @override
  void didChangeDependencies() async {
    refresh();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackgroundColor,
      appBar: AppBar(
        title: Text(
          'ລາຍການສັ່ງຊື້',
          style: TextStyle(
            fontFamily: fontFamily,
          ),
        ),
        centerTitle: true,
        backgroundColor: appColor,
        actions: [
          Badge(
            badgeContent: Text(
              CartService.orderTotal.toString(),
              style: TextStyle(
                fontFamily: fontFamily,
                fontSize: 10.0,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            toAnimate: false,
            badgeColor: Colors.red,
            position: BadgePosition.topEnd(top: 0, end: 0),
            child: IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
              iconSize: 28,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (value) => CartPage()),
                ).then((value) => setState(() {}));
              },
            ),
          ),
          SizedBox(width: 5)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: FutureBuilder(
          future: OrderService().getOrderings(),
          builder: (context, AsyncSnapshot? snapshot) {
            if (snapshot!.hasData) {
              List<Orders>? orders = snapshot.data;
              if (orders!.length > 0) {
                return ListView.builder(
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    String? status;
                    Color? statusColor;
                    int? totalOrder = 0;
                    if (orders[index].orderStatus == 'NEW') {
                      status = 'ລໍດຳເນີນການ';
                      statusColor = newColor;
                    }
                    if (orders[index].orderStatus == 'PENDING') {
                      status = 'ກຳລັງກວດສອບ';
                      statusColor = pendingColor;
                    }
                    if (orders[index].orderStatus == 'PACKED') {
                      status = 'ກຳລັງຈັດສົ່ງ';
                      statusColor = packedColor;
                    }
                    if (orders[index].orderStatus == 'SHIPPED') {
                      status = 'ຈັດສົ່ງແລ້ວ';
                      statusColor = shippedColor;
                    }
                    for (int i = 0; i < orders[index].items!.length; i++) {
                      totalOrder =
                          totalOrder! + orders[index].items![i].quantity!;
                    }
                    return Card(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OrderDetailPage(
                                id: orders[index].id,
                                totalOrder: totalOrder,
                                status: status,
                                statusColor: statusColor,
                              ),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 100,
                                width: 100,
                                child: QrImage(
                                  data: orders[index].id!,
                                  version: QrVersions.auto,
                                  size: 100.0,
                                  embeddedImage: AssetImage(appQR!),
                                  embeddedImageStyle: QrEmbeddedImageStyle(
                                    size: Size(12, 16),
                                  ),
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "ຈຳນວນທັງໝົດ: " +
                                        totalOrder.toString() +
                                        " ແພັກ",
                                    style: TextStyle(
                                      fontFamily: fontFamily,
                                      fontSize: 14,
                                      color: fontColor,
                                    ),
                                  ),
                                  Text(
                                    "ລາຄາລວມ: " +
                                        NumberFormat("#,### ກີບ")
                                            .format(orders[index].totalPayment),
                                    style: TextStyle(
                                      fontFamily: fontFamily,
                                      fontSize: 14,
                                      color: fontColor,
                                    ),
                                  ),
                                  Text(
                                    'ວັນທີສັ່ງຊື້: ' +
                                        DateFormat("dd-MM-yyyy").format(
                                            DateTime.parse(orders[index]
                                                .createdAt!
                                                .split("T")[0])),
                                    style: TextStyle(
                                      fontFamily: fontFamily,
                                      fontSize: 14,
                                      color: fontColor,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "ສະຖານະ: ",
                                        style: TextStyle(
                                          fontFamily: fontFamily,
                                          fontSize: 14,
                                          color: fontColor,
                                        ),
                                      ),
                                      Text(
                                        status!,
                                        style: TextStyle(
                                          fontFamily: fontFamily,
                                          fontSize: 14,
                                          color: statusColor!,
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
                  },
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
