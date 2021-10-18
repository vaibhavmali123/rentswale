import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:rentswale/bloc/ProductsHomeBloc.dart';
import 'package:rentswale/models/ProductsListModel.dart';
import 'package:rentswale/networking/ApiProvider.dart';
import 'package:rentswale/utils/utils.dart';
import 'package:rentswale/views/ProductDetails.dart';
import 'package:rentswale/views/SubcategoriesPage.dart';

class HomePageNav extends StatefulWidget {
  HomePageNavState createState() => HomePageNavState();
}

class HomePageNavState extends State<HomePageNav> {
  List<dynamic> listCategories = [
    {'title': 'Real Estate', 'icon': 'assets/images/home.png', 'id': '1'},
    {'title': 'Electronics', 'icon': 'assets/images/electronics.png', 'id': '2'},
    {'title': 'Costume', 'icon': 'assets/images/costume.png', 'id': '3'},
    {'title': 'Vehicles', 'icon': 'assets/images/vehicle.png', 'id': '5'},
    {'title': 'Events', 'icon': 'assets/images/events.png', 'id': '6'},
    {'title': 'Medical', 'icon': 'assets/images/me.png', 'id': '7'},
    {'title': 'Furniture', 'icon': 'assets/images/furniture.png', 'id': '8'},
    {'title': 'Services', 'icon': 'assets/images/service.png', 'id': '9'},
  ];

  List<dynamic> listSlider = [
    {"image": "assets/images/baner_one.jpeg"},
    {"image": "assets/images/baner_three.png"},
    {"image": "assets/images/baner_two.png"}
  ];

  @override
  void initState() {
    /* Database.initDatabase();
    address = Database.getAddres();
   */
    Future.delayed(Duration(seconds: 1), () {
      productsHomeBloc.fetchProductsHome(address: "address");
    });
    super.initState();
  }

  @override
  void didUpdateWidget(covariant HomePageNav oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    productsHomeBloc.fetchProductsHome(address: "address");
  }

  @override
  bool get mounted {
    productsHomeBloc.fetchProductsHome(address: "address");
  }

  @override
  Widget build(BuildContext context) {
    productsHomeBloc.fetchProductsHome(address: "address");
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [getSlider()],
              ),
              getCategories(),
              getHomeProducts(),
            ],
          ),
        ),
      ),
    );
  }

  getSlider() {
    return CarouselSlider(
      options: CarouselOptions(height: 158, disableCenter: false, viewportFraction: 1, autoPlay: true, aspectRatio: 4.2, enlargeCenterPage: false),
      items: listSlider.map((e) {
        return Builder(builder: (BuildContext context) {
          return Row(
            children: [
              Image.asset(
                e['image'],
                scale: 0.3,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.contain,
                // width: MediaQuery.of(context).size.width / 1.4,
              )
            ],
          );
        });
      }).toList(),
    );
  }

  getLine() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 1,
      color: Colors.black54,
    );
  }

  getCategories() {
    return Container(
      height: 210,
      margin: EdgeInsets.only(left: 6, right: 6, top: 6),
      width: MediaQuery.of(context).size.width,
      child: GridView.count(
        crossAxisCount: 4,
        mainAxisSpacing: 1,
        childAspectRatio: 0.9,
        crossAxisSpacing: 8,
        children: List.generate(listCategories.length, (index) {
          return GestureDetector(
            onTap: () {
              print("IDDDDDD ${listCategories[index]['id']}");
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return SubcategoriesPage(listCategories[index]['id'], listCategories[index]['title']);
              }));
            },
            child: Container(
              height: 350,
              width: MediaQuery.of(context).size.width / 12,
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10.0) /*,
                          boxShadow: [BoxShadow(offset: Offset(1.4, 1.4),
                              color: Colors.grey.shade500, spreadRadius: 0.6, blurRadius: 0.8)]*/
                  ),
              margin: EdgeInsets.only(
                bottom: 10,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    listCategories[index]['icon'].toString(),
                    height: 35,
                    width: 45,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Text(
                          listCategories[index]['title'],
                          maxLines: 2,
                          style: GoogleFonts.poppins(fontSize: 12, color: Colors.black87.withOpacity(0.6), fontWeight: FontWeight.w700) /*TextStyle(fontSize: 12, color: Colors.black87.withOpacity(0.6), fontWeight: FontWeight.w800)*/,
                        ),
                      )
                    ],
                  ),
                  listCategories[index]['title'] == 'Medical'
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: Text(
                                'Equipments',
                                maxLines: 2,
                                style: GoogleFonts.poppins(fontSize: 12, color: Colors.black87.withOpacity(0.6), fontWeight: FontWeight.w700) /*TextStyle(fontSize: 12, color: Colors.black87.withOpacity(0.6), fontWeight: FontWeight.w800)*/,
                              ),
                            )
                          ],
                        )
                      : Container()
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  getHomeProducts() {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 180,
          child: StreamBuilder(
              stream: productsHomeBloc.productStream,
              builder: (context, AsyncSnapshot<ProductsListModel> snapshot) {
                if (snapshot.hasData) {
                  return snapshot.data.statusCode == "200"
                      ? ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data.productList.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) {
                                  return ProductDetails(data: snapshot.data.productList[index]);
                                }));
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width / 2.6,
                                height: 120,
                                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8.0) /*,
                          boxShadow: [BoxShadow(offset: Offset(1.4, 1.4),
                              color: Colors.grey.shade500, spreadRadius: 0.6, blurRadius: 0.8)]*/
                                    ),
                                margin: EdgeInsets.only(bottom: 10, left: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image.network(
                                      snapshot.data.productList[index].itemImgOne != null && snapshot.data.productList[index].itemImgOne != "" ? ApiProvider.baseUrlImage + snapshot.data.productList[index].itemImgOne : 'ps500x-3-500-lumens-xga-education-projector-500x500.jpg',
                                      fit: BoxFit.contain,
                                      scale: 0.4,
                                      height: 110,
                                      width: 120,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Flexible(
                                          //width: MediaQuery.of(context).size.width / 8,
                                          child: Text(
                                            snapshot.data.productList[index].itemName,
                                            maxLines: 2,
                                            softWrap: true,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.poppins(fontSize: 12, color: Colors.black87.withOpacity(0.7), fontWeight: FontWeight.w700) /* TextStyle(fontSize: 12, color: Colors.black87.withOpacity(0.6), fontWeight: FontWeight.w800)*/,
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Price:  ₹ ' + snapshot.data.productList[index].price,
                                      style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black87.withOpacity(0.6)) /*TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.black87.withOpacity(0.7))*/,
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        )
                      : Center(
                          child: Text('Soon we will service in this area'),
                        );
                } else if (snapshot.hasData == false) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    height: 55,
                    child: Lottie.asset("assets/lotties/loader.json"),
                  );
                } else {
                  return Utils.noData;
                }
              }),
        ),
        Image.asset("assets/images/Now_Work_From_Anywhere.png", scale: 0.3, width: MediaQuery.of(context).size.width, fit: BoxFit.cover)
      ],
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
