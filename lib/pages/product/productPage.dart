import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:one_water_mobile/constants/constant.dart';
import 'package:one_water_mobile/models/products.dart';
import 'package:one_water_mobile/pages/cart/cartPage.dart';
import 'package:one_water_mobile/pages/product/productDetailPage.dart';
import 'package:one_water_mobile/services/cartService.dart';
import 'package:one_water_mobile/services/productService.dart';
import 'package:one_water_mobile/pages/cart/addCartPage.dart';
import 'package:one_water_mobile/widgets/errorWidgets.dart';
import 'package:one_water_mobile/widgets/loadingWidgets.dart';
import 'package:one_water_mobile/widgets/nullWidgets.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController? qtyController = TextEditingController();
  // List<List<int>> prices = [];
  List<String> selectedPrices = ['promotion', 'normal'];
  String? dropDownPrices;
  List<Products>? promotions;
  List<bool> hasPromotion = [];
  Future refresh() async {
    await CartService().getCart();
    setState(() {
      qtyController!.clear();
    });
  }

  // void getPromotion() async {
  //   promotions = await ProductService().getProducts();
  //   for (var promotion in promotions!) {
  //     if (promotion.promotionStatus == true) {
  //       setState(() {
  //         hasPromotion = true;
  //       });
  //       break;
  //     }
  //   }
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   getPromotion();
  // }

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
          'ໜ້າຫຼັກ',
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
                ).then((value) => refresh());
              },
            ),
          ),
          SizedBox(width: 5)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(5),
        child: FutureBuilder(
          future: ProductService().getProducts(),
          builder: (context, AsyncSnapshot? snapshot) {
            if (snapshot!.hasData) {
              List<Products>? products = snapshot.data;
              if (products!.length > 0) {
                return ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    // prices.insert(index, [
                    //   products[index].wholeSale!,
                    //   products[index].promotionPrice!
                    // ]);
                    // dropDownPrices!.insert(index, null);
                    hasPromotion.insert(
                        index, products[index].promotionStatus!);
                    return Card(
                      elevation: 0,
                      color: whiteColor,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetailPage(
                                id: products[index].id,
                                selectedPrice:
                                    products[index].promotionStatus == false
                                        ? 'normal'
                                        : dropDownPrices != ''
                                            ? dropDownPrices
                                            : 'promotion',
                              ),
                            ),
                          ).then((value) => refresh());
                        },
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Column(
                              children: [
                                Container(
                                  color: whiteColor,
                                  height:
                                      MediaQuery.of(context).size.width * 0.5,
                                  child: products[index].image != null
                                      ? FadeInImage.assetNetwork(
                                          placeholder: gitLoading!,
                                          image: products[index].image!,
                                        )
                                      : Center(
                                          child: Text(
                                            'ບໍ່ມີຮູບພາບ',
                                            style: TextStyle(
                                              fontFamily: fontFamily,
                                              fontSize: 20,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  products[index].productName!,
                                  style: TextStyle(
                                    fontFamily: fontFamily,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: fontColor,
                                  ),
                                ),
                                hasPromotion[index] == true
                                    ? Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 4),
                                        child: Container(
                                          color: whiteColor,
                                          child: DropdownButtonFormField(
                                            elevation: 0,
                                            decoration: InputDecoration(
                                              enabledBorder: InputBorder.none,
                                            ),
                                            alignment: Alignment.center,
                                            value: dropDownPrices,
                                            dropdownColor: appBackgroundColor,
                                            iconEnabledColor: appColor,
                                            hint: dropDownPrices == null
                                                ? Center(
                                                    child: Text(
                                                      "ລາຄາໂປຣໂມຊັ່ນ ${products[index].promotionPrice} ກີບ/ແພັກ",
                                                      style: TextStyle(
                                                        color: fontColor,
                                                        fontFamily: fontFamily,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                  )
                                                : Center(
                                                    child: Text(
                                                      "ລາຄາ ${products[index].promotionPrice} ກີບ/ແພັກ",
                                                      style: const TextStyle(
                                                        color: fontColor,
                                                        fontFamily: fontFamily,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                  ),
                                            isExpanded: true,
                                            iconSize: 30.0,
                                            style: const TextStyle(
                                              fontFamily: fontFamily,
                                              color: fontColor,
                                              fontSize: 14,
                                            ),
                                            items: selectedPrices.map(
                                              (selectedPrice) {
                                                return DropdownMenuItem<String>(
                                                  value: selectedPrice,
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    selectedPrice == 'normal'
                                                        ? 'ລາຄາ ${NumberFormat("#,### ກີບ/ແພັກ").format(products[index].promotionPrice)} ກີບ/ແພັກ'
                                                        : 'ລາຄາໂປຣໂມຊັ່ນ ${NumberFormat("#,### ກີບ/ແພັກ").format(products[index].promotionPrice)}',
                                                    style: TextStyle(
                                                      fontFamily: fontFamily,
                                                      fontSize: 16,
                                                      color: fontColor,
                                                    ),
                                                  ),
                                                );
                                              },
                                            ).toList(),
                                            onChanged: (dynamic val) {
                                              setState(
                                                () {
                                                  dropDownPrices = val;
                                                },
                                              );
                                            },
                                          ),
                                        ),
                                      )
                                    : Text(
                                        "ລາຄາ: " +
                                            NumberFormat("#,### ກີບ/ແພັກ")
                                                .format(
                                                    products[index].wholeSale),
                                        style: TextStyle(
                                          fontFamily: fontFamily,
                                          fontSize: 16,
                                          color: fontColor,
                                        ),
                                      ),
                                // products[index].promotionStatus == false
                                //     ? Text(
                                //         "ລາຄາ: " +
                                //             NumberFormat("#,### ກີບ/ແພັກ")
                                //                 .format(products[index]
                                //                     .wholeSale),
                                //         style: TextStyle(
                                //           fontFamily: fontFamily,
                                //           fontSize: 16,
                                //           color: fontColor,
                                //         ),
                                //       )
                                //     : dropDownPrice == 'normal'
                                //         ? Text(
                                //             "ລາຄາ: " +
                                //                 NumberFormat(
                                //                         "#,### ກີບ/ແພັກ")
                                //                     .format(
                                //                         products[index]
                                //                             .wholeSale),
                                //             style: TextStyle(
                                //               fontFamily: fontFamily,
                                //               fontSize: 16,
                                //               color: fontColor,
                                //             ),
                                //           )
                                //         : Text(
                                //             "ລາຄາໂປຣໂມຊັ່ນ: " +
                                //                 NumberFormat(
                                //                         "#,### ກີບ/ແພັກ")
                                //                     .format(products[
                                //                             index]
                                //                         .promotionPrice),
                                //             style: TextStyle(
                                //               fontFamily: fontFamily,
                                //               fontSize: 16,
                                //               color: fontColor,
                                //             ),
                                //           ),
                                SizedBox(height: 10),
                                IconButton(
                                  onPressed: () {
                                    addCartAlert(
                                      context: context,
                                      qtyController: qtyController,
                                      onOk: () async {
                                        if (qtyController!.text != '') {
                                          await CartService().addCart(
                                              productId: products[index].id,
                                              quantity: qtyController!.text,
                                              price: dropDownPrices == 'normal'
                                                  ? products[index]
                                                      .wholeSale
                                                      .toString()
                                                  : dropDownPrices ==
                                                          'promotion'
                                                      ? products[index]
                                                          .promotionPrice
                                                          .toString()
                                                      : products[index]
                                                                  .promotionStatus ==
                                                              true
                                                          ? products[index]
                                                              .promotionPrice
                                                              .toString()
                                                          : products[index]
                                                              .wholeSale
                                                              .toString());
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
                                    Icons.add_shopping_cart_rounded,
                                    size: 40,
                                  ),
                                  color: appColor,
                                ),
                                SizedBox(height: 15),
                              ],
                            ),
                            products[index].promotionStatus == true
                                ? Positioned(
                                    left: 0,
                                    top: 0,
                                    child: Container(
                                      height: 50,
                                      width: 90,
                                      decoration: BoxDecoration(
                                        color: errorColor,
                                        borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(30),
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'ໂປຣໂມຊັ່ນ',
                                          style: TextStyle(
                                            fontFamily: fontFamily,
                                            color: whiteColor,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : const SizedBox(),
                          ],
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
