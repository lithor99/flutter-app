import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:one_water_mobile/constants/constant.dart';
import 'package:one_water_mobile/models/orders.dart';
import 'package:one_water_mobile/services/orderService.dart';
import 'package:one_water_mobile/widgets/errorWidgets.dart';
import 'package:one_water_mobile/widgets/loadingWidgets.dart';
import 'package:qr_flutter/qr_flutter.dart';

class OrderDetailPage extends StatefulWidget {
  const OrderDetailPage({
    Key? key,
    this.id,
    this.totalOrder,
    this.status,
    this.statusColor,
  }) : super(key: key);
  final String? id;
  final int? totalOrder;
  final String? status;
  final Color? statusColor;

  @override
  _OrderDetailPageState createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColor,
        title: Text(
          "ລາຍລະອຽດໃບບິນ",
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
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: FutureBuilder(
          future: OrderService().getOrderById(id: widget.id),
          builder: (context, AsyncSnapshot? snapshot) {
            if (snapshot!.hasData) {
              Orders? order = snapshot.data;
              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: QrImage(
                        data: order!.id!,
                        version: QrVersions.auto,
                        size: 200.0,
                        embeddedImage: AssetImage(appQR!),
                        embeddedImageStyle: QrEmbeddedImageStyle(
                          size: Size(22, 28),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "ຈໍານວນທັງໝົດ: " + widget.totalOrder.toString() + " ແພັກ",
                      style: TextStyle(
                        fontFamily: fontFamily,
                        fontSize: 20,
                        color: fontColor,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      "ລາຄາລວມ: " +
                          NumberFormat("#,### ກີບ").format(
                            int.parse(order.totalPayment.toString()),
                          ),
                      style: TextStyle(
                        fontFamily: fontFamily,
                        fontSize: 20,
                        color: fontColor,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      'ວັນທີສັ່ງຊື້: ' +
                          DateFormat("dd-MM-yyyy").format(
                              DateTime.parse(order.createdAt!.split("T")[0])),
                      style: TextStyle(
                        fontFamily: fontFamily,
                        fontSize: 20,
                        color: fontColor,
                      ),
                    ),
                    SizedBox(height: 3),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: widget.status != null
                          ? [
                              Text(
                                'ສະຖານະ: ',
                                style: TextStyle(
                                  fontFamily: fontFamily,
                                  fontSize: 20,
                                  color: fontColor,
                                ),
                              ),
                              Text(
                                widget.status!,
                                style: TextStyle(
                                  fontFamily: fontFamily,
                                  fontSize: 20,
                                  color: widget.statusColor!,
                                ),
                              ),
                            ]
                          : [],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      color: appColor1,
                      child: Table(
                        columnWidths: const <int, TableColumnWidth>{
                          0: const FixedColumnWidth(50),
                          1: const FlexColumnWidth(3),
                          2: const FixedColumnWidth(100),
                        },
                        children: [
                          TableRow(
                            children: [
                              Text(
                                'ລຳດັບ',
                                style: TextStyle(
                                  fontFamily: fontFamily,
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                'ລາຍການ',
                                style: TextStyle(
                                  fontFamily: fontFamily,
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                'ຈຳນວນ',
                                style: TextStyle(
                                  fontFamily: fontFamily,
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      height: 150,
                      child: ListView.builder(
                        itemCount: order.items!.length,
                        itemBuilder: (context, index) {
                          return Container(
                            child: Table(
                              columnWidths: const <int, TableColumnWidth>{
                                0: const FixedColumnWidth(50),
                                1: const FlexColumnWidth(3),
                                2: const FixedColumnWidth(100),
                              },
                              children: [
                                TableRow(
                                  children: [
                                    Text(
                                      (index + 1).toString(),
                                      style: TextStyle(
                                        fontFamily: fontFamily,
                                        fontSize: 16,
                                        color: fontColor,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      order.items![index].product!.productName!,
                                      style: TextStyle(
                                        fontFamily: fontFamily,
                                        fontSize: 16,
                                        color: fontColor,
                                      ),
                                    ),
                                    Text(
                                      order.items![index].quantity.toString() +
                                          ' ແພັກ',
                                      style: TextStyle(
                                        fontFamily: fontFamily,
                                        fontSize: 16,
                                        color: fontColor,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
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
