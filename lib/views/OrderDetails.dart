import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rentswale/models/OrderHistoryModel.dart';
import 'package:rentswale/utils/Colors.dart';

class OrderDetails extends StatefulWidget {
  List<OrderItemDetails> orderItemDetails;

  OrderDetails(this.orderItemDetails);

  OrderDetailsState createState() => OrderDetailsState(orderItemDetails);
}

class OrderDetailsState extends State<OrderDetails> {
  List<OrderItemDetails> orderItemDetails;

  OrderDetailsState(this.orderItemDetails);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Orders Details',
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
        ),
        backgroundColor: color.primaryColor,
      ),
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            itemCount: orderItemDetails.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.only(left: 0, right: 12, top: 12),
                color: Colors.white,
                padding: EdgeInsets.only(
                  left: 14,
                ),
                width: MediaQuery.of(context).size.width / 1.2,
                height: 80,
                child: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                              text: 'Product Name:  ',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: Colors.blueAccent,
                              ),
                              children: <TextSpan>[TextSpan(text: orderItemDetails[index].itemName, style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black54))]),
                        ),
                        RichText(
                          text: TextSpan(
                              text: 'Price:  ',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: Colors.blueAccent,
                              ),
                              children: <TextSpan>[TextSpan(text: orderItemDetails[index].itemPrice, style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black54))]),
                        ),
                        RichText(
                          text: TextSpan(
                              text: 'Total:  ',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: Colors.blueAccent,
                              ),
                              children: <TextSpan>[TextSpan(text: orderItemDetails[index].subTotal, style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black54))]),
                        ),
                        RichText(
                          text: TextSpan(
                              text: 'Date:  ',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: Colors.blueAccent,
                              ),
                              children: <TextSpan>[TextSpan(text: orderItemDetails[index].date, style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black54))]),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          )),
    );
  }
}
