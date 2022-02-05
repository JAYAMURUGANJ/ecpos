import 'package:flutter/material.dart';

import '../models/product_class.dart';

class BillPreviewPage extends StatelessWidget {
  const BillPreviewPage({
    Key key,
    this.context,
    this.data,
  }) : super(key: key);

  final BuildContext context;
  final List<Product> data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.print_rounded),
            Text("Bill Preview"),
          ],
        ),
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (_, i) => ListTile(
          leading: CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.secondary,
            child: Text(
              data[i].productName.substring(0, 1),
              style: TextStyle(color: Colors.white),
            ),
          ),
          title: Text(data[i].productName),
          subtitle: Text(data[i].scaleType),
        ),
      ),
    );
  }
}
