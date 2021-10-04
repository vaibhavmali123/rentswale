import 'package:flutter/material.dart';
import 'package:rentswale/database/Database.dart';
import 'package:rentswale/utils/Colors.dart';
import 'package:rentswale/views/Dashboard.dart';

class LocationScreen extends StatefulWidget {
  LocationScreenState createState() => LocationScreenState();
}

class LocationScreenState extends State<LocationScreen> {
  List<String> listCity = ['Mumbai', 'Pune', 'Ahemadabad', 'Aurangabad', 'Surat'];
  int selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black87,
            )),
        title: Text(
          'Select city',
          style: TextStyle(color: Colors.black87),
        ),
        backgroundColor: Colors.white,
        elevation: 12,
      ),
      body: Container(
          padding: EdgeInsets.only(left: 20, right: 10),
          color: Colors.grey.shade100,
          child: GridView.count(
            crossAxisCount: 3,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            childAspectRatio: 1.3,
            children: List.generate(listCity.length, (index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                  Database.initDatabase();
                  Database.setAddres(listCity[selectedIndex]);
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                    return Dashboard();
                  }));
                },
                child: Container(
                  margin: EdgeInsets.only(left: 2, right: 12, top: 12),
                  height: 50,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(width: selectedIndex == index ? 1 : 0, color: Colors.red),
                    color: Colors.white54,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.home_work_outlined,
                        size: 50,
                        color: selectedIndex != index ? Colors.grey : color.primaryColor.withOpacity(0.8),
                      ),
                      Text(
                        listCity[index],
                        style: TextStyle(color: selectedIndex != index ? Colors.black87.withOpacity(0.5) : color.primaryColor.withOpacity(0.8), fontWeight: selectedIndex != index ? FontWeight.w800 : FontWeight.w900),
                      )
                    ],
                  ),
                ),
              );
            }),
          )),
    );
  }
}
