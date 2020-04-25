import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart_provider.dart';
import 'package:shop_app/providers/ordersProvider.dart';
import 'package:shop_app/screens/cart_screen.dart';
import 'package:shop_app/screens/edit_product_screen.dart';
import 'package:shop_app/screens/orders_screen.dart';
import 'package:shop_app/screens/product_detail_screen.dart';
import 'package:shop_app/screens/products_overview_screen.dart';
import 'package:shop_app/screens/user_products_screen.dart';
import 'providers/products_provider.dart';

void main() => runApp(MyApp());

const Map<int, Color> color = const {
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
  final MaterialColor colorCustom = const MaterialColor(0xFFF3CA20, color);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctxx) => ProductsProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctxx) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctxx) => OrdersProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MyShop',
        theme: ThemeData(
          primarySwatch: colorCustom,
          accentColor: Colors.black,
          fontFamily: 'Lato',
        ),
        routes: {
          '/': (ctx) => ProductsOverviewScreen(),
          ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
          CartScreen.routeName: (ctx) => CartScreen(),
          OrdersScreen.routeName: (ctx) => OrdersScreen(),
          UserProductsScren.routeName: (ctx) => UserProductsScren(),
          EditProductScreen.routeName: (ctx) => EditProductScreen(),
        },
      ),
    );
  }
}
