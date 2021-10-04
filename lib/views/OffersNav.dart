import 'package:flutter/material.dart';

class OffersNav extends StatefulWidget {
  OffersNavState createState() => OffersNavState();
}

class OffersNavState extends State<OffersNav> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [],
            ),
          )
        ],
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: Text('Offeres is  under development'),
        ),
      ),
    );
  }

  void showFilter() {
    /* showSearch(context: context, delegate: SearchSubcategories(listSubCategories: listSubcategories, categoryId: categoryId)).then((value) {
      print("KKKKKKKKKKKKKKK ${value.toString()}");
      setState(() {
        subCategoryId = value;
        productListBloc.fetchProductsList(categoryId: categoryId, subCategoryId: subCategoryId);
      });
    });*/
  }
}
