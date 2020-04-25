import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/providers/products_provider.dart';

class EditProductScreen extends StatefulWidget {
  static const String routeName = '/edit-product';

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFoucusNode = FocusNode();
  final _descFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _product = Product(
    id: null,
    title: '',
    description: '',
    imageUrl: '',
    price: 0,
    isFavorite: false,
  );
  var _initValues = {
    'title': '',
    'description': '',
    'imageUrl': '',
    'price': '',
  };
  var editingMood = false;
  bool isInit = false;

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!isInit) {
      final productID = ModalRoute.of(context).settings.arguments as String;
      if (productID != null) {
        _product = Provider.of<ProductsProvider>(context, listen: false)
            .getProduct(productID);
        _initValues = {
          'title': _product.title,
          'description': _product.description,
          'imageUrl': _product.imageUrl,
          'price': _product.price.toString(),
        };
        _imageUrlController.text = _initValues['imageUrl'];
        editingMood = true;
      }
      isInit = true;
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _priceFoucusNode.dispose();
    _descFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  void _saveForm() {
    if (!_form.currentState.validate()) return;
    _form.currentState.save();
    if (!editingMood)
      Provider.of<ProductsProvider>(context, listen: false)
          .addProduct(_product);
    else
      Provider.of<ProductsProvider>(context, listen: false)
          .editProduct(_product);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(editingMood ? 'Edit Product' : 'AddProduct'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  initialValue: _initValues['title'],
                  decoration: const InputDecoration(labelText: 'Title'),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value.isEmpty) return 'Please enter a title,';
                    return null;
                  },
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_priceFoucusNode);
                  },
                  onSaved: (value) {
                    _product = Product(
                      isFavorite: _product.isFavorite,
                      id: _product.id,
                      title: value,
                      description: _product.description,
                      imageUrl: _product.imageUrl,
                      price: _product.price,
                    );
                  },
                ),
                TextFormField(
                  initialValue: _initValues['price'],
                  decoration: const InputDecoration(labelText: 'Price'),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  focusNode: _priceFoucusNode,
                  validator: (value) {
                    if (double.tryParse(value) == null)
                      return 'Please enter a valid value.';
                    else if (double.parse(value) <= 0)
                      return 'Please enter a positive value';
                    return null;
                  },
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_descFocusNode);
                  },
                  onSaved: (value) {
                    _product = Product(
                      isFavorite: _product.isFavorite,
                      id: _product.id,
                      title: _product.title,
                      description: _product.description,
                      imageUrl: _product.imageUrl,
                      price: double.parse(value),
                    );
                  },
                ),
                TextFormField(
                  initialValue: _initValues['description'],
                  decoration: InputDecoration(labelText: 'Description'),
                  focusNode: _descFocusNode,
                  maxLines: 3,
                  keyboardType: TextInputType.multiline,
                  validator: (value) {
                    if (value.isEmpty)
                      return 'Please enter a description.';
                    else if (value.length < 10)
                      return 'Desciption should be at least 10 characters long.';
                    return null;
                  },
                  onSaved: (value) {
                    _product = Product(
                      isFavorite: _product.isFavorite,
                      id: _product.id,
                      title: _product.title,
                      description: value,
                      imageUrl: _product.imageUrl,
                      price: _product.price,
                    );
                  },
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      width: 100,
                      height: 100,
                      margin: const EdgeInsets.only(
                        top: 8,
                        right: 10,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Colors.grey,
                        ),
                      ),
                      child: _imageUrlController.text.isEmpty
                          ? const Center(child: const Text('No Image'))
                          : FittedBox(
                              child: Image.network(
                                _imageUrlController.text,
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: _imageUrlController,
                        decoration: const InputDecoration(
                          labelText: 'Image Url',
                        ),
                        keyboardType: TextInputType.url,
                        textInputAction: TextInputAction.done,
                        focusNode: _imageUrlFocusNode,
                        validator: (value) {
                          if (value.isEmpty)
                            return 'Please enter an image URL.';
                          else if (!value.startsWith('http') &&
                              !value.startsWith('https'))
                            return 'Please enter a valid URL.';
                          return null;
                        },
                        onSaved: (value) {
                          _product = Product(
                            isFavorite: _product.isFavorite,
                            id: _product.id,
                            title: _product.title,
                            description: _product.description,
                            imageUrl: value,
                            price: _product.price,
                          );
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                FlatButton.icon(
                  onPressed: _saveForm,
                  color: Theme.of(context).primaryColor,
                  icon: Icon(
                    editingMood ? Icons.edit : Icons.add,
                    size: 18,
                  ),
                  label: Text(
                    editingMood ? 'Edit Product' : 'Add Product',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
