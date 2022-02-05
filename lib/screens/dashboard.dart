import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'add_products.dart';
import 'multi_form.dart';

class DashboardPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DashboardPageState();
  }
}

var dashboardMenu = [
  {
    "name": "Create Bill",
    "icon": Icons.receipt,
    "destinationPage": MultiForm()
  },
  {
    "name": "Add Product",
    "icon": Icons.add_shopping_cart,
    "destinationPage": ImagePickerPage()
  },
  {
    "name": "Add Scale",
    "icon": Icons.straighten,
    "destinationPage": MultiForm()
  },
  {
    "name": "Add Customer",
    "icon": Icons.group_add,
    "destinationPage": MultiForm()
  },
];

class _DashboardPageState extends State<DashboardPage> {
  final rnd = math.Random();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.store),
            Text("EC-pos"),
          ],
        ),
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
      drawer: Drawer(
        child: Center(child: Text("EC-pos")),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: dashboardMenu.length,
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (BuildContext context, int index) {
                return FeatureProduct(
                  productName: dashboardMenu[index]['name'] as String,
                  iconName: dashboardMenu[index]['icon'] as IconData,
                  destinationPage:
                      dashboardMenu[index]['destinationPage'] as Widget,
                  randcolor: Color(rnd.nextInt(0xFF1DCC8C)),
                  index: index,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class FeatureProduct extends StatelessWidget {
  final String productName;
  final IconData iconName;
  final Widget destinationPage;
  final int index;
  final Color randcolor;

  FeatureProduct(
      {this.productName,
      this.iconName,
      this.index,
      this.destinationPage,
      this.randcolor});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Hero(
        tag: index,
        child: Material(
          color: randcolor,
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => destinationPage),
              );
            },
            child: GridTile(
                footer: Container(
                  color: Colors.white70,
                  child: ListTile(
                      title: Center(
                    child: Text(
                      productName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )),
                ),
                child: Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Icon(
                      iconName,
                      size: 80,
                    ))),
          ),
        ),
      ),
    );
  }
}
