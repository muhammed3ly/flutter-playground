import 'dart:io';

import 'package:flutter/material.dart';
import 'package:places_app/providers/places_provider.dart';
import 'package:places_app/widgets/location_input_widget.dart';
import 'package:provider/provider.dart';

import '../widgets/image_input_widget.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = '/add-place';

  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  File _pickedImage;
  String _title;
  final _form = GlobalKey<FormState>();

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  Future<void> _showErrorDialog() async {
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Fill The Missing Data'),
        content: Text('Please take a photo of this place!'),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Okay'),
          ),
        ],
      ),
    );
  }

  void _saveForm() {
    if (!_form.currentState.validate()) {
      return;
    }
    if (_pickedImage == null) {
      _showErrorDialog();
      return;
    }
    _form.currentState.save();
    Provider.of<PlacesProvider>(context, listen: false)
        .addPlace(_title, _pickedImage);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a New Place'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Form(
              key: _form,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        cursorColor: Theme.of(context).primaryColor,
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(labelText: 'Title'),
                        validator: (val) {
                          if (val.isEmpty) return 'Please enter a title.';
                          return null;
                        },
                        onSaved: (val) {
                          _title = val;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ImageInput(_selectImage),
                      SizedBox(
                        height: 20,
                      ),
                      LocationInput(),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 50,
            child: RaisedButton.icon(
              icon: Icon(Icons.add),
              label: Text(
                'Add Place',
                style: TextStyle(fontSize: 20),
              ),
              onPressed: _saveForm,
              elevation: 0,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              color: Theme.of(context).accentColor,
            ),
          ),
        ],
      ),
    );
  }
}
