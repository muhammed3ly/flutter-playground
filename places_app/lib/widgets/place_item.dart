import 'dart:io';

import 'package:flutter/material.dart';
import 'package:places_app/screens/place_detail_screen.dart';

class PlaceItem extends StatelessWidget {
  final File _image;
  final String _title;
  PlaceItem(this._image, this._title);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: Card(
        elevation: 8,
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: FileImage(_image),
          ),
          title: Text(_title),
          onTap: () {
            //Navigator.of(context).pushNamed(PlaceDetailsScreen.routeName);
          },
        ),
      ),
    );
  }
}
