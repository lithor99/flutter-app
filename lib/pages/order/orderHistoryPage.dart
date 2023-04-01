import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:one_water_mobile/constants/constant.dart';
import 'package:one_water_mobile/models/orders.dart';
import 'package:one_water_mobile/pages/order/orderDetailPage.dart';
import 'package:one_water_mobile/services/orderService.dart';
import 'package:one_water_mobile/widgets/errorWidgets.dart';
import 'package:one_water_mobile/widgets/loadingWidgets.dart';
import 'package:one_water_mobile/widgets/nullWidgets.dart';
import 'package:qr_flutter/qr_flutter.dart';

class OrderHistoryPage extends StatefulWidget {
  const OrderHistoryPage({Key? key}) : super(key: key);

  @override
  _OrderHistoryPageState createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackgroundColor,
      appBar: AppBar(
        title: Text(
          'ປະຫວັດສັ່ງຊື້',
          style: TextStyle(
            fontFamily: fontFamily,
          ),
        ),
        centerTitle: true,
        backgroundColor: appColor,
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
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: FutureBuilder(
          future: OrderService().getOrderHistorys(),
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

                    if (orders[index].orderStatus == 'DELIVERED') {
                      status = 'ສຳເລັດ';
                      statusColor = deliveredColor;
                    }
                    if (orders[index].orderStatus == 'CANCELED') {
                      status = 'ຍົກເລີກ';
                      statusColor = cancelColor;
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
