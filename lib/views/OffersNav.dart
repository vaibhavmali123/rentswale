import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rentswale/bloc/OffersBloc.dart';
import 'package:rentswale/models/OffersModel.dart';
import 'package:rentswale/networking/ApiProvider.dart';
import 'package:rentswale/utils/utils.dart';

class OffersNav extends StatefulWidget {
  OffersNavState createState() => OffersNavState();
}

class OffersNavState extends State<OffersNav> {
  @override
  Widget build(BuildContext context) {
    offersBloc.getOffers();
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
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
          color: Colors.grey.shade50,
          child: StreamBuilder(
            stream: offersBloc.offersStream,
            builder: (context, AsyncSnapshot<OffersModel> snapshot) {
              if (snapshot.hasData) {
                print("RESPONSE snapshot ${snapshot.data.statusCode}");

                return ListView.builder(
                    itemCount: snapshot.data.offerList.length,
                    itemBuilder: (context, index) {
                      return Container(
                        height: 70,
                        margin: EdgeInsets.only(left: 12, right: 12, top: 12),
                        color: Colors.white,
                        child: Image.network(
                          ApiProvider.baseUrlImage + snapshot.data.offerList[index].sliderImage,
                          fit: BoxFit.contain,
                        ),
                      );
                    });
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return Utils.loader;
              } else {
                return Utils.noData;
              }
            },
          )),
    );
  }
}
