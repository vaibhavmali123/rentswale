import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pay/pay.dart';
import 'package:rentswale/bloc/CouponCodeBloc.dart';
import 'package:rentswale/database/Database.dart';
import 'package:rentswale/models/CheckCouponModel.dart';
import 'package:rentswale/utils/Colors.dart';
import 'package:rentswale/utils/utils.dart';
import 'package:rentswale/views/PlaceOrderScreen.dart';

import '../main.dart';
import 'LoginPage.dart';

class CartPageNav extends StatefulWidget {
  CartPageNavState createState() => CartPageNavState();
}

class CartPageNavState extends State<CartPageNav> {
  List<dynamic> listCart = [];
  int total = 0;
  bool couponApplied = false;
  String couponAmount;
  var _paymentItems = [
    PaymentItem(
      label: 'Total',
      amount: '2',
      status: PaymentItemStatus.final_price,
    )
  ];
  TextEditingController couponCtrl;
  int indexTemp;

  @override
  void initState() {
    // TODO: implement initState
    Database.initDatabase();

    super.initState();
    couponCtrl = TextEditingController();
    getCartDetails();
  }

  @override
  Widget build(BuildContext context) {
    print("DDDDD ${listCart.length}");
    return Scaffold(
      bottomNavigationBar: listCart.length > 0
          ? Container(
              height: 130,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          flex: 3,
                          child: Container(
                              padding: EdgeInsets.only(left: 8, right: 10, bottom: 10),
                              //width: MediaQuery.of(context).size.width / 1.6,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 48,
                                    child: TextFormField(
                                      controller: couponCtrl,
                                      decoration: InputDecoration(
                                          hintText: 'Enter coupon code',
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(
                                                8.0,
                                              ),
                                              borderSide: BorderSide(width: 1, color: Colors.black54))),
                                    ),
                                  ),
                                ],
                              ))),
                      Expanded(
                          flex: 1,
                          child: Container(
                            padding: EdgeInsets.only(left: 0, right: 8, bottom: 10),
                            child: StreamBuilder(
                              stream: couponBloc.checkCouponCodeStream,
                              builder: (context, AsyncSnapshot<CheckCouponModel> snapshot) {
                                return RaisedButton(
                                  onPressed: () {
                                    applyCode(snapshot);
                                  },
                                  color: color.successBtnColor,
                                  child: Text(
                                    'Apply',
                                    style: GoogleFonts.poppins(fontSize: 14, color: Colors.white),
                                  ),
                                );
                              },
                            ),
                          ))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      couponApplied == true
                          ? Text(
                              couponAmount != null ? '₹ ' + couponAmount + ' Coupon applied' : "",
                              style: TextStyle(color: Colors.black),
                            )
                          : Container()
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 5),
                    height: 55,
                    color: color.primaryColor,
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      total != 0 ? Text.rich(TextSpan(text: 'Total:', style: GoogleFonts.poppins(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w500), children: <TextSpan>[TextSpan(text: ' ₹ ' + total.toString())])) : Container(),
                      Padding(
                        padding: EdgeInsets.only(left: 4, right: 4),
                        child: SizedBox(
                          height: 40,
                          width: MediaQuery.of(context).size.width / 3.4,
                          child: RaisedButton(
                            color: color.successBtnColor,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                            onPressed: () {
                              Database.initDatabase();

                              Navigator.push(context, MaterialPageRoute(builder: (context) {
                                return Database.getUserName() == null
                                    ? LoginPage(listProducts: listCart)
                                    : /*KycPage();*/
                                    PlaceOrderScreen(
                                        listProducts: listCart,
                                        couponAmount: couponAmount,
                                      );
                              }));
                            },
                            child: Text(
                              "Checkout",
                              style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white),
                            ),
                          ),
                        ),
                      )
                    ]),
                  )
                ],
              ),
            )
          : Container(),
      body: Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.grey.shade100,
          child: listCart.length > 0
              ? Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          itemCount: listCart.length,
                          itemBuilder: (context, index) {
                            cartCount = listCart.length;

                            return GestureDetector(
                              onTap: () {
                                setState(() {});
                                /*Navigator.push(context, MaterialPageRoute(builder: (context) {
                                  return LoginPage(); */ /*PlaceOrderScreen();*/ /*
                                }));*/
                              },
                              child: Container(
                                height: 140,
                                margin: EdgeInsets.only(top: 10),
                                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8.0)),
                                width: MediaQuery.of(context).size.width / 1.1,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(top: 10),
                                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8.0)),
                                          width: MediaQuery.of(context).size.width / 1.1,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Expanded(flex: 3, child: Image.network('http://rentswale.com/admin/uploads/item/' + listCart[index]['image'])),
                                              Expanded(
                                                flex: 6,
                                                child: Container(
                                                  margin: EdgeInsets.only(left: 4),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Text(
                                                        listCart[index]['productName'],
                                                        style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w800, color: Colors.black87.withOpacity(0.6)),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text('Price:  ₹ ' + listCart[index]['price'], style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.black87.withOpacity(0.5))),
                                                        ],
                                                      ),
                                                      Text('Total:  ₹ ' + listCart[index]['total_price'].toString(), style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.black87.withOpacity(0.5)))
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Expanded(flex: 5, child: Container()),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context).size.width / 3.8,
                                          height: 35,
                                          child: RaisedButton(
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                                            color: Colors.red,
                                            onPressed: () {
                                              setState(() {
                                                listCart.removeAt(index);
                                              });
                                              print("AFTER DELETE ${listCart.toString()}");
                                              Database.initDatabase();
                                              Database.addTocart(json.encode(listCart));
                                              getCartDetails();
                                              setState(() {});
                                            },
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Remove",
                                                  style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.white),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context).size.width / 3.6,
                                          height: 35,
                                          child: RaisedButton(
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                                            color: color.successBtnColor,
                                            onPressed: () {
                                              _showEditDialog(context: context, qty: listCart[index]['quantity'], index: index);
                                              /*ProductList productList = ProductList();
                                              productList.itemName = listCart[index]['productName'];
                                              productList.price = listCart[index]['price'];
                                              productList.itemMasterId = listCart[index]['itemMasterId'];
                                              productList.itemImg = listCart[index]['image'];
                                              productList.deposite = listCart[index]['deposit'];
                                              Navigator.push(context, MaterialPageRoute(builder: (context) {
                                                return ProductDetails(
                                                  data: productList,
                                                );
                                              }));*/
                                            },
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Edit",
                                                  style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.white),
                                                ),
                                                /*Icon(
                                                  Icons.edit,
                                                  color: Colors.white,
                                                ),*/
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          }),
                    )
                  ],
                )
              : Center(
                  child: Utils.noData,
                )),
    );
  }

  void onGooglePayResult(paymentResult) {
    // Send the resulting Google Pay token to your server or PSP
  }

  void _showEditDialog({BuildContext context, int qty, int index}) {
    int quantity = qty;
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return StatefulBuilder(builder: (BuildContext context, StateSetter setState /*You can rename this!*/) {
            return SafeArea(
              child: Container(
                height: MediaQuery.of(context).size.height / 4.6,
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 40,
                      color: color.primaryColor,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Update quantity",
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                            onPressed: () {
                              if (quantity != 1) {
                                setState(() {
                                  quantity = quantity - 1;
                                  indexTemp = index;
                                });
                              }
                            },
                            icon: Icon(Icons.remove_circle_outline)),
                        Container(
                          margin: EdgeInsets.only(left: 0, right: 5),
                          height: 40,
                          width: MediaQuery.of(context).size.width / 5,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                6.0,
                              ),
                              border: Border.all(width: 1, color: Colors.black54)),
                          child: Center(
                            child: Text(
                              quantity.toString(),
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black87),
                            ),
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                quantity = quantity + 1;
                                indexTemp = index;
                              });
                            },
                            icon: Icon(Icons.add)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: ElevatedButton(
                              onPressed: () async {
                                Navigator.pop(context);
                                listCart[indexTemp]['quantity'] = quantity;
                                listCart[indexTemp]['total_price'] = (int.parse(listCart[indexTemp]['price']) * quantity).toString();

                                Database.addTocart(json.encode(listCart));
                                // total = 0;
                                getCartDetails();
                                setState(() {});
                              },
                              style: ElevatedButton.styleFrom(primary: Colors.green, textStyle: TextStyle(fontSize: 12, color: Colors.white)),
                              child: Text('Update')),
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          });
        });
  }

  void getCartDetails() async {
    var response = await Database.getCart();
    if (response != null) {
      setState(() {
        listCart = json.decode(response);
      });
      total = 0;
      for (int i = 0; i < listCart.length; i++) {
        total = total + int.parse(listCart[i]['total_price']);
      }
      setState(() {});
    }
    print("CARTDATA ${response}");
  }

  void applyCode(AsyncSnapshot snapshot) {
    if (couponCtrl.text != "") {
      couponBloc.checkCouponCode(couponCode: couponCtrl.text);
      couponBloc.checkCouponCodeStream.listen((event) {
        print("CPN ${event.toString()}");

        if (event.statusCode == '200') {
          Utils.showMessage(type: true, message: 'coupon code applied');
          setState(() {
            if (couponApplied == false) {
              couponApplied = true;
              couponAmount = event.result.price;
              total = total - int.parse(event.result.price);
            }
          });
        } else {
          Utils.showMessage(type: false, message: event.message);
        }
      });
      print(snapshot.data);
    } else {
      Utils.showMessage(type: false, message: 'Please enter coupon code');
    }
  }
}
