import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pay/pay.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:rentswale/bloc/PlaceOrderBloc.dart';
import 'package:rentswale/database/Database.dart';
import 'package:rentswale/models/PlaceOrderModel.dart';
import 'package:rentswale/utils/Colors.dart';
import 'package:rentswale/utils/utils.dart';
import 'package:rentswale/views/Dashboard.dart';
import 'package:rentswale/views/KycPage.dart';

class PlaceOrderScreen extends StatefulWidget {
  List<dynamic> listProducts;
  String couponAmount;

  PlaceOrderScreen({this.listProducts, this.couponAmount});

  PlaceOrderScreenState createState() => PlaceOrderScreenState(listProducts: listProducts, couponAmount: couponAmount);
}

class PlaceOrderScreenState extends State<PlaceOrderScreen> {
  List<dynamic> listProducts;
  String couponAmount;

  PlaceOrderScreenState({this.listProducts, this.couponAmount});
  int rentProducts = 0;
  int taxTotal = 0;
  int rentTotal;
  int totalDeposit = 0, deliveryCharges = 0, totalPayout = 0;
  TextEditingController addressCtrl;
  var paymentMethod = 'offline';
  var _razorpay = Razorpay();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTotalPayment();
    addressCtrl = TextEditingController();
    print("DDDDD ${couponAmount}");
    initPaymentCallbacks();
  }

  var _paymentItems = [
    PaymentItem(
      label: 'Total',
      amount: '200',
      status: PaymentItemStatus.final_price,
    )
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: GestureDetector(
        onTap: () {
          if (addressCtrl.text.length > 0) {
            Database.initDatabase();
            Database.isKycCompleted();

            print("KYC ${Database.isKycCompleted()}");
            if (Database.isKycCompleted() != null) {
              if (paymentMethod == 'offline') {
                placeOrder();
              } else {
                openCheckout();
                // showPaymentSheet(context);
              }
            } else {
              Utils.showMessage(message: 'Please first complete KYC');
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return KycPage();
              }));
            }
          } else {
            Utils.showMessage(message: 'Please enter address', type: false);
          }
        },
        child: Container(
          color: color.primaryColor,
          height: 55,
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Text(
              'Place Order',
              style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.white),
            ),
          ),
        ),
      ),
      appBar: AppBar(
        title: Text(
          'Place your Order',
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
        ),
        backgroundColor: color.primaryColor,
      ),
      body: Container(
        color: Colors.grey.shade100,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 1.1,
              margin: EdgeInsets.only(bottom: 10, top: 20),
              padding: EdgeInsets.all(18),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0), color: Colors.white),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: color.primaryColor,
                      ),
                      Text(
                        'Address',
                        style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w800, color: Colors.black87.withOpacity(0.6)),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1,
                    height: 50,
                    child: TextFormField(
                      controller: addressCtrl,
                      decoration: InputDecoration(hintText: "Delivery address", border: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.black54))),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 20,
                ),
                Text(
                  'Order summary',
                  style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w800, color: Colors.black87.withOpacity(0.6)),
                )
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8.0)),
              width: MediaQuery.of(context).size.width / 1.1,
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Payment details',
                      style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w800, color: Colors.black87.withOpacity(0.6)),
                    ),
                    getLine(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Products rent',
                          style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.black87.withOpacity(0.6)),
                        ),
                        Text(
                          '₹ ' + rentProducts.toString(),
                          style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.black87.withOpacity(0.6)),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Deposit',
                          style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.black87.withOpacity(0.6)),
                        ),
                        Text(
                          totalDeposit.toString(),
                          style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.black87.withOpacity(0.6)),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Delivery charges',
                          style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.black87.withOpacity(0.6)),
                        ),
                        Text(
                          '₹ 10',
                          style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.black87.withOpacity(0.6)),
                        ),
                      ],
                    ),
                    couponAmount != null
                        ? Padding(
                            padding: EdgeInsets.only(top: 6),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Coupon Applied',
                                  style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.black87.withOpacity(0.6)),
                                ),
                                Text(
                                  '₹ ' + couponAmount,
                                  style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.black87.withOpacity(0.6)),
                                ),
                              ],
                            ),
                          )
                        : Container(),
                    getLine(),
                    SizedBox(
                      height: 4,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total amount to pay',
                          style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w800, color: Colors.black87.withOpacity(0.6)),
                        ),
                        couponAmount != null
                            ? Text(
                                '₹ ' + (rentProducts + 10 + totalDeposit - int.parse(couponAmount)).toString(),
                                style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w800, color: Colors.black87.withOpacity(0.6)),
                              )
                            : Text(
                                '₹ ' + (rentProducts + 10 + totalDeposit).toString(),
                                style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w800, color: Colors.black87.withOpacity(0.6)),
                              ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        child: Row(
                          children: [
                            Flexible(
                                child: Row(
                              children: [
                                Radio(
                                    value: 'offline',
                                    groupValue: paymentMethod,
                                    onChanged: (value) {
                                      setState(() {
                                        paymentMethod = value;
                                      });
                                    }),
                                Text('Offline Payment')
                              ],
                            )),
                            SizedBox(
                              width: 8,
                            ),
                            Flexible(
                                child: Row(
                              children: [
                                Radio(
                                    value: 'online',
                                    groupValue: paymentMethod,
                                    onChanged: (value) {
                                      setState(() {
                                        paymentMethod = value;
                                      });
                                    }),
                                Text('Online Payment')
                              ],
                            ))
                          ],
                        )),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  getLine() {
    return Container(
      margin: EdgeInsets.only(top: 8, bottom: 8),
      width: MediaQuery.of(context).size.width / 1.2,
      height: 0.6,
      color: Colors.black54.withOpacity(0.5),
    );
  }

  void getTotalPayment() {
    print("DATATATAATA ${listProducts.toString()}");
    for (int i = 0; i < listProducts.length; i++) {
      setState(() {
        rentProducts = rentProducts + int.parse(listProducts[i]['price']);
      });
      totalDeposit = int.parse(listProducts[i]['deposit'].toString().substring(
            7,
          ));
      print("DATATATAATA ${totalDeposit}");

      //totalDeposit = listProducts[i]['deposit'];
    }
  }

  void placeOrder() {
    PlaceOrderModel placeOrderModel = PlaceOrderModel();
    List<dynamic> placeOrderList = [];
    for (int i = 0; i < listProducts.length; i++) {
      print("DDDDDD ${listProducts.toString()}");
      placeOrderModel.itemName = listProducts[i]['productName'];
      placeOrderModel.categoryId = listProducts[i]['subCategoryId'];
      placeOrderModel.itemPrice = listProducts[i]['price'];
      placeOrderModel.month = listProducts[i]['duration'];
      placeOrderModel.itemId = listProducts[i]['itemMasterId'];
      placeOrderModel.subTotal = int.parse(listProducts[i]['price']).toString();
      placeOrderList.add(placeOrderModel);
    }
    placeOrderBloc.placeOrder(placeOrderList: placeOrderList, address: addressCtrl.text);
    placeOrderBloc.placeOrderStream.listen((event) {
      if (event['status_code'] == '200') {
        Utils.showMessage(message: event["Message"]);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
          return Dashboard();
        }));
      } else {
        Utils.showMessage(message: event["Message"], type: false);
      }
    });
  }

  void showPaymentSheet(BuildContext context) async {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: Container(
              height: MediaQuery.of(context).size.height / 2,
              child: Column(
                children: [],
              ),
            ),
          );
        });
  }

  void onGooglePayResult(Map<String, dynamic> result) {
    print("RESULT ${result.toString()}");
  }

  void initPaymentCallbacks() {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  _handlePaymentError(response) {}
  _handlePaymentSuccess(response) {
    placeOrder();
  }

  _handleExternalWallet(response) {}

  void openCheckout() {
    Database.initDatabase();

    var options = {
      "key": "rzp_test_MuZiq4AflqrplL",
      "amount": 100,
      "name": "Rentswale",
      "description": "everything on rent",
      "prefill": {
        "contact": null,
        "email": "",
      },
      "external": {
        "wallet": ["paytm"]
      }
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      print(e.toString());
    }
  }
}
