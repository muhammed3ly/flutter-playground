import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/products_overview_screen.dart';
import 'providers/products_provider.dart';

void main() => runApp(MyApp());

Map<int, Color> color = {
  50: Color.fromRGBO(243, 202, 32, .1),
  100: Color.fromRGBO(243, 202, 32, .2),
  200: Color.fromRGBO(243, 202, 32, .3),
  300: Color.fromRGBO(243, 202, 32, .4),
  400: Color.fromRGBO(243, 202, 32, .5),
  500: Color.fromRGBO(243, 202, 32, .6),
  600: Color.fromRGBO(243, 202, 32, .7),
  700: Color.fromRGBO(243, 202, 32, .8),
  800: Color.fromRGBO(243, 202, 32, .9),
  900: Color.fromRGBO(243, 202, 32, 1),
};

class MyApp extends StatelessWidget {
  MaterialColor colorCustom = MaterialColor(0xFFF3CA20, color);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => ProductsProvider(),
      child: MaterialApp(
        title: 'MyShop',
        theme: ThemeData(
          primarySwatch: colorCustom,
          accentColor: Colors.black,
          fontFamily: 'Lato',
        ),
        home: ProductsOverviewScreen(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyShop'),
      ),
      body: Center(
        child: Text('Let\'s build a shop!'),
      ),
    );
  }
}
