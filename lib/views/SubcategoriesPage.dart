import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rentswale/bloc/ProductListBloc.dart';
import 'package:rentswale/bloc/SubcategoriesBloc.dart';
import 'package:rentswale/models/ProductsListModel.dart';
import 'package:rentswale/models/SubcategoriesModel.dart';
import 'package:rentswale/networking/ApiHandler.dart';
import 'package:rentswale/networking/ApiProvider.dart';
import 'package:rentswale/networking/EndApi.dart';
import 'package:rentswale/utils/Colors.dart';
import 'package:rentswale/utils/SearchSubcategories.dart';
import 'package:rentswale/utils/utils.dart';
import 'package:rentswale/views/ProductDetails.dart';

class SubcategoriesPage extends StatefulWidget {
  String categoryId, title;

  SubcategoriesPage(this.categoryId, this.title);

  SubcategoriesPageState createState() => SubcategoriesPageState(categoryId, title);
}

class SubcategoriesPageState extends State<SubcategoriesPage> {
  String categoryId, title, subCategoryId;
  List<SubcategoryList> listSubcategories = [];
  bool isAvailable = false;
  SubcategoriesPageState(this.categoryId, this.title);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initSearch();
  }

  @override
  Widget build(BuildContext context) {
    print("CATID ${categoryId}");

    subCategoriesBloc.fetchSubcategories(categoryId);
    productListBloc.fetchProductsList(categoryId: categoryId, subCategoryId: subCategoryId);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: color.primaryColor,
        centerTitle: false,
        title: Text(
          'Rentswale',
          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
        ),
        automaticallyImplyLeading: false,
        actions: [
          Container(
            padding: EdgeInsets.only(right: 14),
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    )),
                Text(
                  title,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                      onPressed: () {
                        if (isAvailable == true) {
                          showSearch(context: context, delegate: SearchSubcategories(listSubCategories: listSubcategories, categoryId: categoryId)).then((value) {
                            print("KKKKKKKKKKKKKKK ${value.toString()}");
                            setState(() {
                              subCategoryId = value;
                              productListBloc.fetchProductsList(categoryId: categoryId, subCategoryId: subCategoryId);
                            });
                          });
                        } else {
                          Utils.showMessage(message: "Soon we will service in this area", type: false);
                        }
                      },
                      icon: Icon(
                        Icons.filter_list,
                        color: Colors.white,
                        size: 30,
                      )),
                )
              ],
            ),
          )
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: StreamBuilder(
          stream: productListBloc.productListStream,
          builder: (context, AsyncSnapshot<ProductsListModel> snapshot) {
            if (snapshot.hasData == true) {
              // listSubcategories = snapshot.data;
              if (snapshot.data.statusCode == "200") {
                isAvailable = true;
                return ListView.builder(
                    itemCount: snapshot.data.productList.length,
                    //  scrollDirection:Axis.horizontal,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return ProductDetails(data: snapshot.data.productList[index]);
                            }));
                          },
                          child: Container(
                            height: 80,
                            margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                            width: MediaQuery.of(context).size.width / 1.4,
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10.0), boxShadow: [BoxShadow(offset: Offset(0.5, 0.5), blurRadius: 0.2, spreadRadius: 0.2, color: Colors.grey)]),
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: Image.network(
                                      'http://rentswale.com/admin/uploads/item/' + snapshot.data.productList[index].itemImg,
                                    )),
                                Expanded(
                                    flex: 3,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 10, top: 14),
                                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                        Text(
                                          snapshot.data.productList[index].itemName,
                                          style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.black87.withOpacity(0.7) /* TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.black87.withOpacity(0.7)*/),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'Price:  ₹ ' + snapshot.data.productList[index].price,
                                          style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.black87.withOpacity(0.6)),
                                        )
                                      ]),
                                    ))
                              ],
                            ),
                          ));
                    });
              } else {
                return Center(
                  child: Text('Soon we will service in this area'),
                );
              }
            } else if (snapshot.hasData == false) {
              return Center(
                child: Utils.animatedLoader,
              );
            } else {
              return Utils.noData;
            }
          },
        ),
      ),
    );
  }

  void showFilter() async {}

  void initSearch() {
    var request = {'category_id': categoryId};

    ApiHandler.postApi(baseUrl: ApiProvider.baseUrl, endApi: EndApi.subcategoryList, request: request).then((value) {
      setState(() {
        listSubcategories = SubcategoriesModel.fromJson(value).subcategoryList;
      });
    });
  }
}
