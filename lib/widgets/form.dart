import 'package:flutter/material.dart';

import '../models/product_class.dart';

typedef OnDelete();

class ProductForm extends StatefulWidget {
  final Product product;
  final state = _ProductFormState();
  final OnDelete onDelete;

  ProductForm({Key key, this.product, this.onDelete}) : super(key: key);
  @override
  _ProductFormState createState() => state;

  bool isValid() => state.validate();
}

class _ProductFormState extends State<ProductForm> {
  final form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Material(
        elevation: 1,
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(8),
        child: Form(
          key: form,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              AppBar(
                leading: Icon(Icons.verified_user),
                elevation: 0,
                title: Text('Product Details'),
                backgroundColor: Theme.of(context).accentColor,
                centerTitle: true,
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: widget.onDelete,
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                child: TextFormField(
                  initialValue: widget.product.productName,
                  onSaved: (val) => widget.product.productName = val,
                  validator: (val) =>
                      val != "" ? null : 'Select a Valid Product Name',
                  decoration: InputDecoration(
                    labelText: 'Product Name',
                    hintText: 'Select a Product Name',
                    icon: Icon(Icons.person),
                    isDense: true,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, right: 16, bottom: 24),
                child: TextFormField(
                  initialValue: widget.product.scaleType,
                  onSaved: (val) => widget.product.scaleType = val,
                  validator: (val) =>
                      val != "" ? null : 'Select a valid Scale Type',
                  decoration: InputDecoration(
                    labelText: 'Scale Type',
                    hintText: 'Select a Scale Type',
                    icon: Icon(Icons.email),
                    isDense: true,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  ///form validator
  bool validate() {
    var valid = form.currentState.validate();
    if (valid) form.currentState.save();
    return valid;
  }
}
