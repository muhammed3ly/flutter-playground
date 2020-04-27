import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/helpers/custom_route.dart';
import 'package:shop_app/providers/auth.dart';
import 'package:shop_app/providers/cart_provider.dart';
import 'package:shop_app/providers/ordersProvider.dart';
import 'package:shop_app/screens/auth_screen.dart';
import 'package:shop_app/screens/cart_screen.dart';
import 'package:shop_app/screens/edit_product_screen.dart';
import 'package:shop_app/screens/orders_screen.dart';
import 'package:shop_app/screens/product_detail_screen.dart';
import 'package:shop_app/screens/products_overview_screen.dart';
import 'package:shop_app/screens/splash.dart';
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
          create: (ctxx) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, ProductsProvider>(
          create: (ctx) => ProductsProvider(null, null, []),
          update: (ctx, auth, previousProducts) => ProductsProvider(
            auth.token,
            auth.userId,
            previousProducts == null ? [] : previousProducts.items,
          ),
        ),
        ChangeNotifierProvider(
          create: (ctxx) => CartProvider(),
        ),
        ChangeNotifierProxyProvider<Auth, OrdersProvider>(
          create: (ctx) => OrdersProvider(null, null, []),
          update: (ctx, auth, previousOrders) => OrdersProvider(
            auth.token,
            auth.userId,
            previousOrders == null ? [] : previousOrders.orders,
          ),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'MyShop',
          theme: ThemeData(
              primarySwatch: colorCustom,
              accentColor: Colors.black,
              fontFamily: 'Lato',
              pageTransitionsTheme: PageTransitionsTheme(builders: {
                TargetPlatform.android: CustomePageTransitionBuilder(),
                TargetPlatform.iOS: CustomePageTransitionBuilder(),
              })),
          home: auth.isAuth
              ? ProductsOverviewScreen()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (ctx, authResultSnapshot) =>
                      authResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? SplashScreen()
                          : AuthScreen(),
                ),
          routes: {
            ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
            CartScreen.routeName: (ctx) => CartScreen(),
            OrdersScreen.routeName: (ctx) => OrdersScreen(),
            UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
            EditProductScreen.routeName: (ctx) => EditProductScreen(),
          },
        ),
      ),
    );
  }
}
