import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:one_water_mobile/constants/constant.dart';
import 'package:one_water_mobile/pages/cart/addCartPage.dart';
import 'package:one_water_mobile/pages/cart/choosePaymetPage.dart';
import 'package:one_water_mobile/services/cartService.dart';
import 'package:one_water_mobile/widgets/alertDialogWidget.dart';
import 'package:one_water_mobile/widgets/errorWidgets.dart';
import 'package:one_water_mobile/widgets/loadingWidgets.dart';
import 'package:one_water_mobile/widgets/nullWidgets.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key, int? items}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  String? id;
  List<List>? data = [];
  String? paymentType;
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
        backgroundColor: appColor,
        title: Column(
          children: [
            Text(
              "ກະຕ່າຂອງຂ້ອຍ",
              style: TextStyle(
                fontFamily: fontFamily,
              ),
            ),
            Text(
              'ລາຄາລວມ: ' +
                  NumberFormat('#,### ກີບ').format(CartService.amount),
              style: TextStyle(
                fontFamily: fontFamily,
                fontSize: 12,
              ),
            )
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
        actions: CartService.amount != 0
            ? [
                IconButton(
                  onPressed: () {
                    ChoiceDialog(
                      icon: Icons.help_outlined,
                      iconColor: Colors.red,
                      title: 'ຕ້ອງການລຶບສິນຄ້າໃນກະຕ່າບໍ?',
                      onCancel: () {
                        Navigator.of(context).pop();
                      },
                      onOk: () async {
                        await CartService().removeCart(id: id);
                        Navigator.of(context).pop();
                        refresh();
                      },
                    ).showChoice(context);
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                )
              ]
            : [],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: FutureBuilder(
          future: CartService().getCart(),
          builder: (context, AsyncSnapshot? snapshot) {
            if (snapshot!.hasData) {
              var cart = snapshot.data;
              if (cart['items'].length > 0) {
                id = cart['_id'];
                data = [];
                for (int i = 0;
                    i < int.parse(cart['items'].length.toString());
                    i++) {
                  data!.add([
                    cart['items'][i]['product']['_id'],
                    cart['items'][i]['quantity'],
                    cart['items'][i]['price']
                  ]);
                }
                List<TextEditingController>? qtyControllers = [];
                List<int>? prices = [];
                return ListView.builder(
                  itemCount: cart['items'].length,
                  itemBuilder: (context, index) {
                    qtyControllers.add(TextEditingController());
                    qtyControllers[index].text =
                        cart['items'][index]['quantity'].toString();
                    prices.add(cart['items'][index]['price']);
                    return Stack(
                      children: [
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 10, top: 20, right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width / 4,
                                  child: FadeInImage.assetNetwork(
                                    placeholder: gitLoading!,
                                    image: cart['items'][index]['product']
                                        ['image'],
                                  ),
                                ),
                                SizedBox(width: 5),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      cart['items'][index]['product']
                                          ['productName'],
                                      style: TextStyle(
                                        fontFamily: fontFamily,
                                        fontSize: 16,
                                        color: fontColor,
                                      ),
                                    ),
                                    Text(
                                      "ລາຄາ: " +
                                          NumberFormat('#,### ກີບ/ແພັກ').format(
                                              cart['items'][index]['price']),
                                      style: TextStyle(
                                        fontFamily: fontFamily,
                                        fontSize: 16,
                                        color: fontColor,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'ຈຳນວນ: ' +
                                              cart['items'][index]['quantity']
                                                  .toString() +
                                              ' ແພັກ',
                                          style: TextStyle(
                                            fontFamily: fontFamily,
                                            fontSize: 18,
                                            color: fontColor,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        IconButton(
                                          onPressed: () async {
                                            addCartAlert(
                                              context: context,
                                              qtyController:
                                                  qtyControllers[index],
                                              onOk: () async {
                                                if (qtyControllers[index]
                                                        .text !=
                                                    '') {
                                                  await CartService()
                                                      .removeItem(
                                                    id: cart['items'][index]
                                                        ['product']['_id'],
                                                  );
                                                  await CartService().addCart(
                                                      productId: cart['items']
                                                              [index]['product']
                                                          ['_id'],
                                                      quantity:
                                                          qtyControllers[index]
                                                              .text,
                                                      price: cart['items']
                                                          [index]['price'].toString());

                                                  refresh();
                                                  Navigator.of(context).pop();
                                                } else {
                                                  Navigator.of(context).pop();
                                                }
                                              },
                                              onCancel: () {
                                                Navigator.of(context).pop();
                                              },
                                            );
                                          },
                                          icon: Icon(
                                            Icons.edit,
                                            color: appColor,
                                            size: 30,
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          right: -8,
                          top: -8,
                          child: IconButton(
                            onPressed: () async {
                              await CartService().removeItem(
                                id: cart['items'][index]['product']['_id'],
                              );
                              refresh();
                            },
                            icon: Icon(
                              Icons.cancel,
                              color: Colors.red,
                              size: 25,
                            ),
                          ),
                        )
                      ],
                    );
                  },
                );
              } else {
                return NullWidgets();
              }
            } else if (snapshot.hasError) {
              return ErrorWidgets();
            }
            return LoadingWidgets();
          },
        ),
      ),
      bottomNavigationBar: CartService.amount != 0
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Card(
                color: appColor,
                child: InkWell(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      "ສັ່ງຊື້ດຽວນີ້",
                      style: TextStyle(
                        fontFamily: fontFamily,
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  onTap: CartService.amount == 0
                      ? () {}
                      : () async {
                          setState(() {
                            ChoosePaymentPage.orderResult = '';
                          });
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (vale) => ChoosePaymentPage(datas: data),
                            ),
                          ).then(
                            (value) {
                              if (ChoosePaymentPage.orderResult == 'Success') {
                                ResultDialog(
                                  icon: Icons.check_circle,
                                  iconColor: Colors.green,
                                  title: 'ສັ່ງຊື້ສຳເລັດ',
                                  titletColor: fontColor,
                                  onOk: () {
                                    Navigator.of(context).pop();
                                    refresh();
                                  },
                                ).showResult(context);
                              }
                            },
                          );
                        },
                ),
              ),
            )
          : SizedBox(),
    );
  }
}
