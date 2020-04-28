import 'package:flutter/material.dart';
import 'package:places_app/providers/places_provider.dart';
import 'package:places_app/screens/add_place_screen.dart';
import 'package:places_app/screens/place_detail_screen.dart';
import 'package:provider/provider.dart';

import 'screens/places_list_screen.dart';

void main() => runApp(MyApp());
final colorMap = {
  50: Color.fromRGBO(80, 4, 114, .1),
  100: Color.fromRGBO(80, 4, 114, .2),
  200: Color.fromRGBO(80, 4, 114, .3),
  300: Color.fromRGBO(80, 4, 114, .4),
  400: Color.fromRGBO(80, 4, 114, .5),
  500: Color.fromRGBO(80, 4, 114, .6),
  600: Color.fromRGBO(80, 4, 114, .7),
  700: Color.fromRGBO(80, 4, 114, .8),
  800: Color.fromRGBO(80, 4, 114, .9),
  900: Color.fromRGBO(80, 4, 114, 1),
};

class MyApp extends StatelessWidget {
  final customColor = MaterialColor(0xFF500472, colorMap);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => PlacesProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: customColor,
          accentColor: Color.fromRGBO(121, 203, 184, 1),
        ),
        home: PlacesListScreen(),
        routes: {
          AddPlaceScreen.routeName: (ctx) => AddPlaceScreen(),
          //PlaceDetailsScreen.routeName: (ctx) => PlaceDetailsScreen(),
        },
      ),
    );
  }
}
