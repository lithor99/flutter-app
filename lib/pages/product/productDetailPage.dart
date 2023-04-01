import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:one_water_mobile/constants/constant.dart';
import 'package:one_water_mobile/models/products.dart';
import 'package:one_water_mobile/pages/cart/cartPage.dart';
import 'package:one_water_mobile/services/cartService.dart';
import 'package:one_water_mobile/services/productService.dart';
import 'package:one_water_mobile/pages/cart/addCartPage.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage(
      {Key? key, required this.id, required this.selectedPrice})
      : super(key: key);
  final String? id;
  final String? selectedPrice;

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  final formKey = GlobalKey<FormState>();
  final ButtonStyle style = ElevatedButton.styleFrom(
    textStyle: const TextStyle(fontSize: 20),
  );
  final TextEditingController? qtyController = TextEditingController();
  int? price;
  Future refresh() async {
    await CartService().getCart();
    setState(() {
      qtyController!.clear();
    });
  }

  @override
  void didChangeDependencies() async {
    refresh();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColor,
        title: Text(
          "ລາຍລະອຽດນໍ້າດື່ມ",
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
                ).then((value) => refresh());
              },
            ),
          ),
          SizedBox(width: 5)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: FutureBuilder(
          future: ProductService().getProduct(id: widget.id),
          builder: (context, AsyncSnapshot? snapshot) {
            if (snapshot!.hasData) {
              Products? product = snapshot.data;
              if (widget.selectedPrice == 'normal') {
                price = product!.wholeSale;
              } else {
                price = product!.promotionPrice;
              }
              return SingleChildScrollView(
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.width * 0.7,
                          width: MediaQuery.of(context).size.width,
                          child: product.image != null
                              ? FadeInImage.assetNetwork(
                                  placeholder: gitLoading!,
                                  image: product.image!,
                                )
                              : Center(
                                  child: Text(
                                    'ບໍ່ມີຮູບພາບ',
                                    style: TextStyle(
                                      fontFamily: 'NotoSans',
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          product.productName!,
                          style: TextStyle(
                            fontFamily: fontFamily,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: fontColor,
                          ),
                        ),
                        SizedBox(height: 5),
                        widget.selectedPrice == 'normal'
                            ? Text(
                                "ລາຄາ: " +
                                    NumberFormat("#,### ກີບ/ແພັກ")
                                        .format(product.wholeSale),
                                style: TextStyle(
                                  fontFamily: fontFamily,
                                  fontSize: 16,
                                  color: fontColor,
                                ),
                              )
                            : Text(
                                "ລາຄາໂປຣໂມຊັ່ນ: " +
                                    NumberFormat("#,### ກີບ/ແພັກ")
                                        .format(product.promotionPrice),
                                style: TextStyle(
                                  fontFamily: fontFamily,
                                  fontSize: 16,
                                  color: fontColor,
                                ),
                              ),
                        SizedBox(height: 5),
                        Text(
                          "ລາຍລະອຽດ: ",
                          style: TextStyle(
                            fontFamily: fontFamily,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: fontColor,
                          ),
                        ),
                        if (product.description != null)
                          Text(
                            product.description!,
                            style: TextStyle(
                              fontFamily: fontFamily,
                              fontSize: 14,
                              color: fontColor,
                            ),
                          ),
                      ],
                    ),
                    product.promotionStatus == true
                        ? Positioned(
                            left: 0,
                            top: 4.5,
                            child: Container(
                              height: 60,
                              width: 100,
                              decoration: BoxDecoration(
                                color: errorColor,
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(35),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'ໂປຣໂມຊັ່ນ',
                                  style: TextStyle(
                                    fontFamily: fontFamily,
                                    color: whiteColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : const SizedBox(),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.error, size: 35, color: Colors.red),
                    SizedBox(width: 10),
                    Text(
                      "Error",
                      style: TextStyle(
                        fontFamily: fontFamily,
                        fontSize: 20,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              );
            }
            return Center(
              child: CircularProgressIndicator(color: appColor),
            );
          },
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: Card(
          color: appColor,
          child: InkWell(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                "ເພີ່ມເຂົ້າກະຕ່າ",
                style: TextStyle(
                  fontFamily: fontFamily,
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            onTap: () {
              addCartAlert(
                context: context,
                qtyController: qtyController,
                onOk: () async {
                  if (qtyController!.text != '') {
                    print('controller:====>>>>${qtyController!.text}');
                    await CartService().addCart(
                      productId: widget.id,
                      quantity: qtyController!.text,
                      price: price.toString(),
                    );
                    // refresh();
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
          ),
        ),
      ),
      // bottomNavigationBar: Container(
      //   height: 60,
      //   color: appColor,
      //   child: TextButton(
      //     child: Text(
      //       "ເພີ່ມເຂົ້າກະຕ່າ",
      //       style: TextStyle(
      //         fontFamily: fontFamily,
      //         fontSize: 22,
      //         color: Colors.white,
      //       ),
      //     ),
      //     onPressed: () {
      // addCartAlert(
      //   context: context,
      //   qtyController: qtyController,
      //   onOk: () async {
      //     if (qtyController!.text != '') {
      //       await CartService().addCart(
      //         productId: widget.id,
      //         quantity: qtyController!.text,
      //       );
      //       refresh();
      //       Navigator.of(context).pop();
      //     } else {
      //       Navigator.of(context).pop();
      //     }
      //   },
      //   onCancel: () {
      //     Navigator.of(context).pop();
      //   },
      // );
      //     },
      //   ),
      // ),
    );
  }
}
