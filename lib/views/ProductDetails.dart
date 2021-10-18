import 'dart:async';
import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:rentswale/bloc/ProductDetailsBloc.dart';
import 'package:rentswale/database/Database.dart';
import 'package:rentswale/main.dart';
import 'package:rentswale/models/ProductDetailsModel.dart';
import 'package:rentswale/models/ProductsListModel.dart';
import 'package:rentswale/networking/ApiProvider.dart';
import 'package:rentswale/utils/Colors.dart';
import 'package:rentswale/utils/constants.dart';
import 'package:rentswale/utils/utils.dart';
import 'package:rentswale/views/Dashboard.dart';

class ProductDetails extends StatefulWidget {
  ProductList data;
  ProductDetails({this.data});

  ProductDetailsState createState() => ProductDetailsState(data: data);
}

enum selected { details, terms }
var selectedValue;

class ProductDetailsState extends State<ProductDetails> {
  ProductList data;

  ProductDetailsState({this.data});
  var myFormat = DateFormat('yyyy-MM-dd');
  int indexChecked = 0;
  List<dynamic> list = ['1 Day', '1 Month', '3 Month', '6 Month', '12 Months'];
  double currentValue = 1.0;
  int quantity = 1;
  String duration;
  String fromdate, todate;
  TextEditingController depositEditingCtrl;
  String total;
  String netPrice;
  int itemPrice;
  AsyncSnapshot<List<ProductDescription>> snapshotGlobal;

  @override
  void initState() {
    super.initState();
    depositEditingCtrl = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    productDetailsBloc.getProductsDetails(itemMasterId: data.itemMasterId);
    List<ProductDescription> listProductDesc = [];

    return Scaffold(
        bottomNavigationBar: getBottomNav(),
        appBar: AppBar(
          backgroundColor: color.primaryColor,
          title: Text(
            data.itemName,
            style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
        ),
        body: SafeArea(
          child: StreamBuilder(
            stream: productDetailsBloc.productDescriptionStream,
            builder: (context, AsyncSnapshot<List<ProductDescription>> snapshot) {
              if (snapshot.hasData) {
                listProductDesc = snapshot.data;
                return SingleChildScrollView(
                  child: IntrinsicHeight(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height + 100,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          getSlider(snapshot),
                          getProductDetails(snapshot),
                          Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: Text("How long do you want to rent this for ? (Months)", style: GoogleFonts.poppins(fontSize: 14, color: Colors.black87, fontWeight: FontWeight.w600)),
                          ),
                          getDurationList(snapshot),
                          getFooter(snapshot),
                          Expanded(child: Container())
                        ],
                      ),
                    ),
                  ),
                );
              } else if (snapshot.hasData == false) {
                return Utils.animatedLoader;
              } else {
                return Utils.noData;
              }
            },
          ),
        ));
  }

  getSlider(AsyncSnapshot<List<ProductDescription>> snapshot) {
    List<String> sliderImages = [];
    sliderImages.add(snapshot.data[0].itemImg);
    sliderImages.add(snapshot.data[0].itemImgOne);
    sliderImages.add(snapshot.data[0].itemImgTwo);
    sliderImages.add(snapshot.data[0].itemImgThree);
    return Container(
      color: Colors.white,
      child: CarouselSlider(
        options: CarouselOptions(height: 200, disableCenter: false, viewportFraction: 1, autoPlay: true, aspectRatio: 0.4, enlargeCenterPage: false),
        items: sliderImages.map((e) {
          return Builder(builder: (BuildContext context) {
            return Row(
              //mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.network(
                  ApiProvider.baseUrlImage + e,
                  scale: 0.2,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.contain,
                  height: 200,
                )
              ],
            );
          });
        }).toList(),
      ),
    );
  }

  getProductDetails(AsyncSnapshot<List<ProductDescription>> snapshot) {
    return Padding(
      padding: EdgeInsets.only(left: 10, top: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            snapshot.data[0].itemName,
            style: GoogleFonts.poppins(fontSize: 15, color: Colors.black87, fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            'Price:  ₹ ' + snapshot.data[0].price,
            style: GoogleFonts.poppins(fontSize: 15, color: Colors.black87.withOpacity(0.8), fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            snapshot.data[0].description,
            style: GoogleFonts.poppins(fontSize: 14, color: Colors.black87.withOpacity(0.8), fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  getDurationList(AsyncSnapshot<List<ProductDescription>> snapshot) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 4),
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('1d'),
              Flexible(
                  child: Container(
                //width: MediaQuery.of(context).size.width,
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: Colors.red[700],
                    inactiveTrackColor: Colors.red[100],
                    trackShape: RectangularSliderTrackShape(),
                    trackHeight: 4.0,
                    tickMarkShape: RoundSliderTickMarkShape(),
                    thumbColor: Colors.redAccent,
                    activeTickMarkColor: Colors.red[700],
                    inactiveTickMarkColor: Colors.red[100],
                    valueIndicatorShape: PaddleSliderValueIndicatorShape(),
                    valueIndicatorColor: Colors.redAccent,
                    valueIndicatorTextStyle: TextStyle(
                      color: Colors.white
                      /*currentValue == 1 || currentValue == 4 || currentValue == 7 || currentValue == 11 ? Colors.black87 : Colors.red*/,
                    ),
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10.0),
                    overlayColor: Colors.red.withAlpha(32),
                    overlayShape: RoundSliderOverlayShape(overlayRadius: 20.0),
                  ),
                  child: Slider(
                    divisions: 5,
                    max: 12,
                    min: 1,
                    mouseCursor: MouseCursor.defer,
                    label: getCurrentValue(currentValue != null ? currentValue : 1, snapshot),
                    value: currentValue.toDouble(),
                    onChanged: (value) {
                      setState(() {
                        currentValue = value;
                      });
                    },
                  ),
                ),
              )),
              Text('12M'),
            ],
          ),
        ),
        Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              padding: EdgeInsets.only(left: 85),
              child: Text(
                '1M',
                style: TextStyle(color: Colors.black87),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 50),
              child: Text(
                '3M',
                style: TextStyle(color: Colors.black87),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 45),
              child: Text(
                '6 M',
                style: TextStyle(color: Colors.black87),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 45),
              child: Text(
                '9M',
                style: TextStyle(color: Colors.black87),
              ),
            ),
          ],
        )
      ],
    );
  }

  getFooter(AsyncSnapshot<List<ProductDescription>> snapshot) {
    depositEditingCtrl.text = 'Deposit  ' + snapshot.data[0].deposite;
    return DefaultTabController(
        length: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 25, bottom: 4),
                      child: Text(
                        "Quantity",
                        style: GoogleFonts.poppins(fontSize: 15, color: Colors.black87, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 6,
                        ),
                        IconButton(
                            onPressed: () {
                              if (quantity != 1) {
                                setState(() {
                                  quantity = quantity - 1;
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
                              });
                            },
                            icon: Icon(Icons.add)),
                        SizedBox(
                          width: 38,
                        ),
                        Column(
                          children: [
                            Align(
                              alignment: Alignment.bottomRight,
                              child: SizedBox(
                                width: 140,
                                height: 45,
                                child: TextFormField(
                                  controller: depositEditingCtrl,
                                  enabled: false,
                                  decoration: InputDecoration(hintText: 'Deposit', border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0), borderSide: BorderSide(width: 1, color: Colors.black54)), hintStyle: GoogleFonts.poppins(fontSize: 12, color: Colors.black87.withOpacity(0.6))),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
            SizedBox(
              height: 12,
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    selectDate();
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2.6,
                    height: 50,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0), border: Border.all(width: 1, color: Colors.black38)),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(fromdate == null ? 'From Date' : fromdate, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.black87)),
                          Icon(
                            Icons.calendar_today,
                            size: 20,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    print("DDDDD ${currentValue}");
                    if (currentValue == 1.0) {
                      toDate();
                    }
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2.6,
                    height: 50,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0), border: Border.all(width: 1, color: Colors.black38)),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            todate != null ? todate : 'To Date',
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.black87),
                          ),
                          Icon(
                            Icons.calendar_today,
                            size: 20,
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  child: Text(
                    'Details',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: selectedValue != selected.details ? Colors.black87 : color.primaryColor),
                  ),
                  onTap: () {
                    setState(() {
                      selectedValue = selected.details;
                    });
                  },
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedValue = selected.terms;
                    });
                  },
                  child: Text(
                    'Terms',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: selectedValue != selected.terms ? Colors.black87 : color.primaryColor),
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 14, right: 14, top: 12),
              child: Text(
                snapshot.data[0].termSpecification,
                style: GoogleFonts.poppins(fontSize: 14, color: Colors.black87.withOpacity(0.8), fontWeight: FontWeight.w500),
              ),
            )

            /*TabBar(labelColor: Colors.black87, labelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: Colors.black87), tabs: [
              Tab(
                text: 'Details',
              ),
              Tab(
                text: 'Terms',
              )
            ]),
            Container(
              height: 100,
              width: MediaQuery.of(context).size.width,
              child: TabBarView(children: [
                Padding(
                  padding: EdgeInsets.only(left: 12, top: 12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text("details 1"), Text("details 2"), Text("details 3")],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 55, top: 12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text("terms 1"), Text("terms 2"), Text("terms 3")],
                  ),
                )
              ]),
            )*/
          ],
        ));
  }

  String getTotal(AsyncSnapshot<List<ProductDescription>> snapshot) {
    itemPrice = int.parse(snapshot.data[0].price);

    switch (duration) {
      case "1 Day":
        if (todate != null) {
          netPrice = snapshot.data[0].price;
          print("DIFFRENCE DDD ${DateTime.parse(myFormat.format(DateTime.parse(todate))).difference(DateTime.parse(myFormat.format(DateTime.parse(fromdate)))).inDays}");
          itemPrice = quantity * itemPrice * DateTime.parse(myFormat.format(DateTime.parse(todate).add(Duration(days: 1)))).difference(DateTime.parse(myFormat.format(DateTime.parse(fromdate)))).inDays;
        } else {
          itemPrice = quantity * int.parse(snapshot.data[0].price);
        }
        return itemPrice.toString();
        break;
      case "1 Month":
        print("DURATION D ${duration}");
        netPrice = snapshot.data[0].priceMonth;
        return (quantity * int.parse(snapshot.data[0].priceMonth)).toString();
        break;
      case "3 Months":
        print("DURATION D  ${duration}");
        netPrice = snapshot.data[0].priceThree;
        return (quantity * int.parse(snapshot.data[0].priceThree)).toString();
        break;
      case "6 Months":
        netPrice = snapshot.data[0].priceSix;
        return (quantity * int.parse(snapshot.data[0].priceSix)).toString();
        break;
      case "9 Months":
        if (snapshot.data[0].priceNine != "") {
          netPrice = snapshot.data[0].priceNine;
          return (quantity * int.parse(snapshot.data[0].priceNine)).toString();
        }
        break;

      case "12 Months":
        if (snapshot.data[0].priceTwel != "") {
          netPrice = snapshot.data[0].priceTwel;
          return (quantity * int.parse(snapshot.data[0].priceTwel)).toString();
        }
        break;
    }
  }

  getCurrentValue(double currentValue, AsyncSnapshot<List<ProductDescription>> snapshot) {
    print("CURRENT VALUE RANGE ${currentValue.round().toString()} ${itemPrice} ${duration}");
    switch (currentValue.round()) {
      case 1:
        duration = "1 Day";
        fromdate = myFormat.format(DateTime.now()).toString();
        todate = myFormat.format(Jiffy().add(days: 1).dateTime).toString();
        netPrice = snapshot.data[0].price;
        itemPrice = quantity * int.parse(snapshot.data[0].price);
        return currentValue.round().toString() + ' Day';
        break;

      case 3:
        duration = "1 Month";
        netPrice = snapshot.data[0].priceMonth;
        fromdate = myFormat.format(DateTime.now()).toString();
        todate = myFormat.format(Jiffy().add(months: 1).dateTime).toString();
        itemPrice = quantity * int.parse(snapshot.data[0].priceMonth);
        return '1 Month';
        break;
      case 5:
        duration = "3 Months";
        netPrice = snapshot.data[0].priceThree;
        fromdate = myFormat.format(DateTime.now()).toString();
        todate = myFormat.format(Jiffy().add(months: 3).dateTime).toString();
        itemPrice = quantity * int.parse(snapshot.data[0].priceThree);
        return '3 Months';
        break;

      case 8:
        duration = "6 Months";
        netPrice = snapshot.data[0].priceSix;
        fromdate = myFormat.format(DateTime.now()).toString();
        todate = myFormat.format(Jiffy().add(months: 6).dateTime).toString();
        itemPrice = quantity * int.parse(snapshot.data[0].priceSix);

        return '6 Months';
        break;
      case 10:
        duration = "9 Months";
        netPrice = snapshot.data[0].priceNine;
        itemPrice = quantity * int.parse(snapshot.data[0].priceNine);
        fromdate = myFormat.format(DateTime.now()).toString();
        todate = myFormat.format(Jiffy().add(months: 9).dateTime).toString();
        return '9 Months';
        break;
      case 12:
        duration = "12 Months";
        netPrice = snapshot.data[0].priceTwel;
        itemPrice = quantity * int.parse(snapshot.data[0].priceTwel);
        fromdate = myFormat.format(DateTime.now()).toString();
        todate = myFormat.format(Jiffy().add(months: 12).dateTime).toString();

        print("TOTTTAL ${total}");
        return '12 Months';
        break;
    }
  }

  Future<Null> selectDate() async {
    var picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime(2101),
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.light().copyWith(
                colorScheme: ColorScheme.light(
              primary: color.primaryColor,
              onPrimary: Colors.white,
              surface: color.colorConvert("#39003E"),
            )),
            child: child,
          );
        });
    setState(() {
      var myFormat = DateFormat('yyyy-MM-dd');

      fromdate = myFormat.format(picked).toString();
    });
  }

  Future<Null> toDate() async {
    var myFormat = DateFormat('yyyy-MM-dd');

    DateTime tempDateTime = DateTime.parse(fromdate).add(Duration(days: 30));
    switch (duration) {
      case "1 Day":
        tempDateTime = DateTime.parse(fromdate).add(Duration(days: 1));
        break;
      case "1 Month":
        tempDateTime = DateTime.parse(fromdate).add(Duration(days: 30));
        break;
      case "3 Months":
        tempDateTime = DateTime.parse(fromdate).add(Duration(days: 90));
        break;
      case "6 Months":
        tempDateTime = DateTime.parse(fromdate).add(Duration(days: 180));
        break;
      case "9 Months":
        tempDateTime = DateTime.parse(fromdate).add(Duration(days: 270));
        break;
      case "6 Months":
        tempDateTime = DateTime.parse(fromdate).add(Duration(days: 365));
        break;
    }
    var picked = await showDatePicker(
        context: context,
        initialDate: tempDateTime,
        firstDate: tempDateTime,
        lastDate: tempDateTime.add(Duration(days: 29)),
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.light().copyWith(
                colorScheme: ColorScheme.light(
              primary: color.primaryColor,
              onPrimary: Colors.white,
              surface: color.colorConvert("#39003E"),
            )),
            child: child,
          );
        });
    setState(() {
      todate = myFormat.format(picked).toString();
      print("DIFF ${DateTime.parse(todate).difference(DateTime.parse(fromdate)).inDays}");
      itemPrice = itemPrice * DateTime.parse(todate).difference(DateTime.parse(fromdate)).inDays;
      print("DIFF ${itemPrice}");
    });
  }

  getBottomNav() {
    return Container(
      height: 60,
      color: color.primaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          StreamBuilder(
            stream: productDetailsBloc.productDescriptionStream,
            builder: (context, AsyncSnapshot<List<ProductDescription>> snapshot) {
              snapshotGlobal = snapshot;
              if (snapshot.hasData) {
                //duration = "1 Day";
                duration = "1 Day" ?? getTotal(snapshot);
                print("DIFF DUR ${duration}");
                return Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text('Price: ₹' + itemPrice.toString(), style: GoogleFonts.poppins(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600)),
                );
              } else if (snapshot.hasData == false) {
                return Utils.loader;
              } else {
                return Utils.noData;
              }
            },
          ),
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: SizedBox(
              height: 40,
              child: RaisedButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                color: Colors.black87,
                onPressed: () {
                  if (fromdate != null && todate != null) {
                    addToCart();
                  } else {
                    Utils.showMessage(message: 'Please select dates', type: false);
                  }
                },
                child: Row(
                  children: [
                    Text(
                      'Book now',
                      style: GoogleFonts.poppins(fontSize: 14, color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void addToCart() {
    Database.initDatabase();

    List<dynamic> listCart = [];
    List<dynamic> listCartTemp = [];

    Map<String, dynamic> mapCart = {};
    var value = Database.getCart();
    if (value != null && value.length > 0) {
      listCartTemp = json.decode(value);
      for (int i = 0; i < listCartTemp.length; i++) {
        Map<String, dynamic> mapTemp = listCartTemp[i];
        print("CART ITEM ${mapTemp}");

        listCart.add(mapTemp);
      }

      print("CART Before ${listCart.toString()}");
    }

    mapCart['productName'] = data.itemName;

    mapCart['total_price'] = itemPrice.toString();
    mapCart['price'] = netPrice;
    mapCart['quantity'] = quantity;
    mapCart['duration'] = duration;
    mapCart['image'] = data.itemImg;
    mapCart['fromDate'] = fromdate;
    mapCart['toDate'] = todate;

    mapCart['subCategoryId'] = data.subCategoryId;
    mapCart['itemMasterId'] = data.itemMasterId;
    mapCart['deposit'] = depositEditingCtrl.text.length > 0 ? depositEditingCtrl.text : "0";
    mapCart['cityName'] = data.cityName;
    listCart.add(mapCart);
    Utils.showMessage(message: constants.addedtoCartMsg, type: true);
    Timer(Duration(seconds: 2), () {
      getCartDetails();
    });
    Database.addTocart(json.encode(listCart));
    var value2 = Database.getCart();
    print("CART After ${value2.toString()}");
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return Dashboard(flag: constants.flagCart);
    }));
  }
}
