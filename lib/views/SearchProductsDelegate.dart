import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rentswale/models/AllProductsModel.dart';
import 'package:rentswale/models/ProductsListModel.dart';
import 'package:rentswale/networking/ApiProvider.dart';

import 'ProductDetails.dart';

class SearchProductsDelegate extends SearchDelegate {
  List<AllProductList> listProducts = [];

  SearchProductsDelegate({this.listProducts});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: Icon(Icons.clear)),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          color: Colors.black87,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {}

  @override
  Widget buildSuggestions(BuildContext context) {
    List<AllProductList> suggestionsList = [];

    for (int i = 0; i < listProducts.length; i++) {
      if (listProducts[i].itemName == query || listProducts[i].itemName.startsWith(query) || listProducts[i].itemName.toLowerCase() == query.toLowerCase() || listProducts[i].itemName.startsWith(query.toUpperCase()) || listProducts[i].itemName.toUpperCase() == query.toUpperCase()) {
        suggestionsList.add(listProducts[i]);
      }
    }

    print("SUGGSS ${suggestionsList.length}");

    return Container(
        padding: EdgeInsets.only(left: 5, right: 8, top: 10),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 1.1,
          children: List.generate(suggestionsList.length, (index) {
            return GestureDetector(
              onTap: () {
                ProductList productList = ProductList();
                productList.itemName = suggestionsList[index].itemName;
                productList.price = suggestionsList[index].price;
                productList.priceTwel = suggestionsList[index].priceTwel;
                productList.priceNine = suggestionsList[index].priceNine;
                productList.priceSix = suggestionsList[index].priceSix;
                productList.priceThree = suggestionsList[index].priceThree;
                productList.priceMonth = suggestionsList[index].priceMonth;
                productList.itemImg = suggestionsList[index].itemImg;

                productList.itemImgOne = suggestionsList[index].itemImgOne;
                productList.itemMasterId = suggestionsList[index].itemMasterId;
                productList.deposite = suggestionsList[index].deposite;
                productList.subCategoryId = suggestionsList[index].subCategoryId;
                productList.deliveryCharge = suggestionsList[index].deliveryCharge;
                productList.description = suggestionsList[index].description;

                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ProductDetails(data: productList);
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
                      suggestionsList[index].itemImgOne != null && suggestionsList[index].itemImgOne != "" ? ApiProvider.baseUrlImage + suggestionsList[index].itemImgOne : 'ps500x-3-500-lumens-xga-education-projector-500x500.jpg',
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
                            suggestionsList[index].itemName,
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
                      'Price:  ₹ ' + suggestionsList[index].price,
                      style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black87.withOpacity(0.6)) /*TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.black87.withOpacity(0.7))*/,
                    )
                  ],
                ),
              ),
            );
          }),
        ));
  }
}
