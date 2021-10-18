import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rentswale/bloc/AllProductsBloc.dart';
import 'package:rentswale/database/Database.dart';
import 'package:rentswale/main.dart';
import 'package:rentswale/models/AllProductsModel.dart';
import 'package:rentswale/utils/Colors.dart';
import 'package:rentswale/utils/constants.dart';
import 'package:rentswale/utils/utils.dart';
import 'package:rentswale/views/AccountNav.dart';
import 'package:rentswale/views/CartPageNav.dart';
import 'package:rentswale/views/HomePageNav.dart';
import 'package:rentswale/views/LocationScreen.dart';
import 'package:rentswale/views/OffersNav.dart';

import 'SearchProductsDelegate.dart';

class Dashboard extends StatefulWidget {
  String flag;

  Dashboard({this.flag});

  DashboardState createState() => DashboardState(flag: flag);
}

class DashboardState extends State<Dashboard> {
  String flag;

  DashboardState({this.flag});

  List<dynamic> listSlider = [
    {"image": "assets/images/rentswale icon.jpeg"},
    {"image": "assets/images/rentswale icon.jpeg"},
    {"image": "assets/images/rentswale icon.jpeg"}
  ];
  List<dynamic> listCart = [];

  List<dynamic> listCategories = [
    {'title': 'Real Estate', 'icon': 'assets/images/home.png'},
    {'title': 'Electronics', 'icon': 'assets/images/electronics.png'},
    {'title': 'Costume', 'icon': 'assets/images/costume.png'},
    {'title': 'Books', 'icon': 'assets/images/book.png'},
    {'title': 'Vehicles', 'icon': 'assets/images/vehicle.png'},
    {'title': 'Events', 'icon': 'assets/images/events.png'},
    {'title': 'Medical', 'icon': 'assets/images/me.png'},
    {'title': 'Furniture', 'icon': 'assets/images/furniture.png'},
    {'title': 'Services', 'icon': 'assets/images/service.png'},
  ];
  List<Widget> _children = [
    HomePageNav(),
    OffersNav(),
    CartPageNav(),
    AccountNav(),
  ];
  List<AllProductList> listProducts = [];
  String address;
  int _currentIndex;
  @override
  void initState() {
    // TODO: implement initState
    checkServiceLocation();

    super.initState();

    if (flag != constants.flagCart) {
      setState(() {
        _currentIndex = 0;
      });
    } else {
      setState(() {
        _currentIndex = 2;
      });
    }

    setState(() {});

    Database.initDatabase();
    print("aaaaddess ${address}");
    setState(() {});
    Timer(Duration(seconds: 2), () {
      address = Database.getAddres();
      getCartDetails();
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    allProductDetailsBloc.getAllProducts(address: address);
    cartCount = listCart.length;

    allProductDetailsBloc.productDescriptionStream.listen((event) {
      listProducts = event;
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: color.primaryColor,
        title: GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return LocationScreen();
            }));
          },
          child: Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return LocationScreen();
                    }));
                  },
                  icon: Icon(Icons.add_location)),
              Text(
                Database.getAddres() == null ? 'Pune' : Database.getAddres(),
                style: GoogleFonts.poppins(fontSize: 17, fontWeight: FontWeight.w700),
              )
            ],
          ),
        ),
        automaticallyImplyLeading: false,
        actions: [
          Container(
            child: IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 22,
                ),
                onPressed: () {
                  if (listProducts != null) {
                    print("EVENT LLLLL ${listProducts.length}");
                    showSearch(context: context, delegate: SearchProductsDelegate(listProducts: listProducts));
                  } else {
                    setState(() {
                      isServiceAvailable = false;
                    });
                    Utils.showMessage(message: "Soon we will service in this area", type: false);
                  }
                  //showSearch(context: context, delegate: SearchOrders(list));
                }),
          )
        ],
      ),
      bottomNavigationBar: getBottomNavigationBar(),
      body: _children[_currentIndex],
    );
  }

  getBottomNavigationBar() {
    return Container(
      height: 70,
      width: MediaQuery.of(context).size.width,
      child: BottomNavigationBar(
        backgroundColor: Colors.white,
        unselectedLabelStyle: TextStyle(color: Colors.orange),
        unselectedItemColor: Colors.black87.withOpacity(0.7),
        currentIndex: _currentIndex,
        onTap: onTapBottomNav,
        selectedItemColor: color.primaryColor,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              title: Text(
                'Home',
                style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w500),
              )),
          BottomNavigationBarItem(
              icon: Icon(Icons.local_offer),
              title: Text(
                'Offers',
                style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w500),
              )),
          BottomNavigationBarItem(
              icon: Stack(
                children: [
                  Icon(
                    Icons.shopping_cart,
                    size: 30,
                  ),
                  Positioned(
                      left: 10,
                      bottom: 13,
                      child: Container(
                        width: 17,
                        height: 17,
                        decoration: BoxDecoration(color: Colors.black87, shape: BoxShape.circle),
                        child: Center(
                          child: Text(
                            cartCount.toString(),
                            style: GoogleFonts.poppins(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w500),
                          ),
                        ),
                      )),
                ],
              ),
              title: Text(
                'Cart',
                style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w500),
              )),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_sharp),
              title: Text(
                'Account',
                style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w500),
              )),
        ],
      ),
    );
  }

  void onTapBottomNav(int value) {
    setState(() {
      _currentIndex = value;
    });
  }

  void getCartDetails() async {
    print("CARTDATA pre");

    var response = await Database.getCart();
    if (response != null) {
      setState(() {
        listCart = json.decode(response);
      });
      setState(() {});
      cartCount = listCart.length;
      print("LENGTH");
      print("LENGTH ${cartCount} ${listCart}");
    }
    print("CARTDATA ${response}");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void checkServiceLocation() {
    if (listProducts == null) {
      setState(() {
        isServiceAvailable = false;
      });
    }
  }
}
