import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:reapp/anti_chew_shop/widgets/UpiPayment.dart';

import '../anti_chew_shop/screens/cart_screen.dart';
import '../anti_chew_shop/screens/products_overview_screen.dart';
import '../anti_chew_shop/screens/product_detail_screen.dart';
import '../anti_chew_shop/providers/products.dart';
import '../anti_chew_shop/providers/cart.dart';
import '../anti_chew_shop/providers/orders.dart';
import '../anti_chew_shop/screens/orders_screen.dart';

class AntiAlcoholics extends StatelessWidget {
  static const routeName = '/antialcoholicchewables';

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Products(),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
        ChangeNotifierProvider.value(
          value: Orders(),
        ),
      ],
      child: MaterialApp(
          title: 'e-Shoppe',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.blue[600],
            fontFamily: 'Lato',
          ),
          home: ProductsOverviewScreen(),
          routes: {
            ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
            CartScreen.routeName: (ctx) => CartScreen(),
            OrdersScreen.routeName: (ctx) => OrdersScreen(),
            // UpiPayment.routeName: (ctx) => UpiPayment(0.0),
          }),
    );
  }
}
