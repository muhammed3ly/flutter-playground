import 'package:flutter/material.dart';
import 'package:places_app/providers/places_provider.dart';
import 'package:places_app/widgets/place_item.dart';
import 'package:provider/provider.dart';

import './add_place_screen.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Places'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<PlacesProvider>(context, listen: false)
            .fetchAndSetPlaces(),
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Consumer<PlacesProvider>(
                    builder: (ctx, places, child) => (places.items.length > 0)
                        ? ListView.builder(
                            itemCount: places.items.length,
                            itemBuilder: (ctx, i) => PlaceItem(
                                places.items[i].image, places.items[i].title),
                          )
                        : child,
                    child: const Center(
                      child: Text('You did not add any places yet!'),
                    ),
                  ),
      ),
    );
  }
}
