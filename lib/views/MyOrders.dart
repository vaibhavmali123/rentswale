import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rentswale/bloc/OrderHistoryBloc.dart';
import 'package:rentswale/models/OrderHistoryModel.dart';
import 'package:rentswale/utils/Colors.dart';
import 'package:rentswale/utils/utils.dart';
import 'package:rentswale/views/OrderDetails.dart';

class MyOrders extends StatefulWidget {
  MyOrdersState createState() => MyOrdersState();
}

class MyOrdersState extends State<MyOrders> {
  @override
  Widget build(BuildContext context) {
    orderHistoryBloc.getOrderHistory();

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: Text(
          'My orders',
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
        ),
        backgroundColor: color.primaryColor,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                child: StreamBuilder(
              stream: orderHistoryBloc.orderHistoryStream,
              builder: (context, AsyncSnapshot<OrderHistoryModel> snapshot) {
                if (snapshot.hasData) {
                  return snapshot.data.orderDetailsList != null || snapshot.data.orderDetailsList.length <= 0
                      ? ListView.builder(
                          reverse: true,
                          itemCount: snapshot.data.orderDetailsList.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.only(left: 0, right: 12, top: 12),
                              color: Colors.white,
                              padding: EdgeInsets.only(
                                left: 14,
                              ),
                              width: MediaQuery.of(context).size.width / 1.2,
                              height: 70,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                            text: 'Order Id:  ',
                                            style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.blueAccent,
                                            ),
                                            children: <TextSpan>[TextSpan(text: snapshot.data.orderDetailsList[index].orderId, style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black54))]),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      RichText(
                                        text: TextSpan(
                                            text: 'Date:  ',
                                            style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.blueAccent,
                                            ),
                                            children: <TextSpan>[TextSpan(text: snapshot.data.orderDetailsList[index].date, style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black54))]),
                                      ),
                                    ],
                                  ),
                                  RaisedButton(
                                    onPressed: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                                        return OrderDetails(snapshot.data.orderDetailsList[index].orderItemDetails);
                                      }));
                                    },
                                    child: Text(
                                      'View Details',
                                      style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.white),
                                    ),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
                                    color: color.primaryColor,
                                  )
                                ],
                              ),
                            );
                          },
                        )
                      : Utils.noData;
                } else if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: Utils.loader,
                  );
                } else {
                  return Center(
                    child: Utils.noData,
                  );
                }
              },
            ))
          ],
        ),
      ),
    );
  }
}
