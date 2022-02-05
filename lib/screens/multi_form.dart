import 'package:collection/collection.dart' show IterableExtension;
import 'package:flutter/material.dart';
import 'bill_preview.dart';
import '../widgets/empty_state.dart';
import '../widgets/form.dart';
import '../models/product_class.dart';

class MultiForm extends StatefulWidget {
  @override
  _MultiFormState createState() => _MultiFormState();
}

class _MultiFormState extends State<MultiForm> {
  List<ProductForm> products = [];

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
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFCCC01D),
              Color(0xFF867F18),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: products.length <= 0
            ? Center(
                child: EmptyState(
                  title: 'Oops',
                  message: 'Add form by tapping add button below',
                ),
              )
            : SingleChildScrollView(
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  addAutomaticKeepAlives: true,
                  itemCount: products.length,
                  itemBuilder: (_, i) => products[i],
                ),
              ),
      ),
      floatingActionButton: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: FloatingActionButton(
              child: Icon(Icons.print),
              onPressed: onSave,
              foregroundColor: Colors.white,
              heroTag: null,
            ),
          ),
          FloatingActionButton(
            child: Icon(Icons.add_shopping_cart),
            onPressed: onAddForm,
            foregroundColor: Colors.white,
            heroTag: null,
          )
        ],
      ),
    );
  }

  ///on form user deleted
  void onDelete(Product _product) {
    setState(() {
      var find = products.firstWhereOrNull(
        (it) => it.product == _product,
      );
      if (find != null) products.removeAt(products.indexOf(find));
    });
  }

  ///on add form
  void onAddForm() {
    setState(() {
      var _product = Product();
      print(products.length);
      products.add(ProductForm(
        product: _product,
        onDelete: () => onDelete(_product),
      ));
      print(products.length);
    });
  }

  ///on save forms
  void onSave() {
    if (products.length > 0) {
      var allValid = true;
      products.forEach((form) => allValid = allValid && form.isValid());
      if (allValid) {
        var data = products.map((it) => it.product).toList();
        Navigator.push(
          context,
          MaterialPageRoute(
            fullscreenDialog: true,
            builder: (_) => BillPreviewPage(context: context, data: data),
          ),
        );
      }
    }
  }
}
