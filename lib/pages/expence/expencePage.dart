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

class ExpencePage extends StatefulWidget {
  const ExpencePage({Key? key, this.startDate, this.endDate}) : super(key: key);
  final String? startDate;
  final String? endDate;

  @override
  _ExpencePageState createState() => _ExpencePageState();
}

class _ExpencePageState extends State<ExpencePage> {
  List<Orders>? order = [];
  int? amount = 0;
  Future refresh() async {
    order = await OrderService().getOrderExpences(
      startDate: DateFormat("yyyy-MM-dd")
          .format(DateTime.parse(widget.startDate!..split(" ")[0])),
      endDate: DateFormat("yyyy-MM-dd")
          .format(DateTime.parse(widget.endDate!.split(" ")[0])),
    );
    setState(() {
      for (int i = 0; i < order!.length; i++) {
        amount = amount! + order![i].totalPayment!;
      }
    });
  }

  @override
  void didChangeDependencies() {
    print(DateFormat("yyyy-MM-dd")
        .format(DateTime.parse(widget.startDate!.split(" ")[0])));
    refresh();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColor,
        title: Column(
          children: [
            Text(
              "ລາຍຈ່າຍທັງໝົດ",
              style: TextStyle(
                fontFamily: fontFamily,
              ),
            ),
            Text(
              DateFormat("dd-MM-yyyy")
                      .format(DateTime.parse(widget.startDate!.split(" ")[0])) +
                  "  ຫາ  " +
                  DateFormat("dd-MM-yyyy")
                      .format(DateTime.parse(widget.endDate!.split(" ")[0])),
              style: TextStyle(
                fontFamily: fontFamily,
                fontSize: 12,
              ),
            ),
          ],
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
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: FutureBuilder(
          future: OrderService().getOrderExpences(
            startDate: DateFormat("yyyy-MM-dd")
                .format(DateTime.parse(widget.startDate!.split(" ")[0])),
            endDate: DateFormat("yyyy-MM-dd")
                .format(DateTime.parse(widget.endDate!.split(" ")[0])),
          ),
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
                                status: null,
                                statusColor: null,
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
                                height: 80,
                                width: 80,
                                child: QrImage(
                                  data: orders[index].id!,
                                  version: QrVersions.auto,
                                  size: 80.0,
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
      bottomNavigationBar: Container(
        height: 60,
        color: Colors.white,
        child: Center(
          child: Text(
            amount != 0
                ? "ລວມລາຍຈ່າຍທັງໝົດ: " +
                    NumberFormat("#,### ກີບ").format(amount)
                : '',
            style: TextStyle(
              fontFamily: fontFamily,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}
