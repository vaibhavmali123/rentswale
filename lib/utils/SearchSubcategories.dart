import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rentswale/models/SubcategoriesModel.dart';
import 'package:rentswale/utils/Colors.dart';

class SearchSubcategories extends SearchDelegate {
  List<SubcategoryList> listSubCategories = [];
  String categoryId;
  bool showLoader = true;
  SearchSubcategories({this.listSubCategories, this.categoryId});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var request = {'category_id': categoryId};
    bool showLoader = false;
    List<SubcategoryList> suggestionsList = [];


    for (int i = 0; i < listSubCategories.length; i++) {
      if (listSubCategories[i].subCategory == query ||
          listSubCategories[i].subCategory.startsWith(query) ||
          listSubCategories[i].subCategory.toLowerCase() == query.toLowerCase() ||
          listSubCategories[i].subCategory.startsWith(query.toUpperCase()) ||
          listSubCategories[i].subCategory.toUpperCase() == query.toUpperCase()) {
        suggestionsList.add(listSubCategories[i]);
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 10, right: 10, top: 20),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 1.8,
          child: GridView.count(
            crossAxisCount: 3,
            childAspectRatio: 2.4,
            crossAxisSpacing: 10,
            mainAxisSpacing: 8,
            children: List.generate(suggestionsList.length, (index) {
              return GestureDetector(
                onTap: () {

                  Navigator.pop(context, suggestionsList[index].subCategoryId);
                },
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width / 12,
                  padding: EdgeInsets.only(left: 0, right: 0),
                  decoration: BoxDecoration(
                    color: color.primaryColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        suggestionsList[index].subCategory,
                        style: GoogleFonts.poppins(color: Colors.white, fontSize: 13),
                        softWrap: true,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
