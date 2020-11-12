import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:provider/provider.dart';

import '../widgets/app_drawer.dart';
import '../widgets/products_grid.dart';
import '../widgets/badge.dart';
import '../providers/cart.dart';
import './cart_screen.dart';
import './orders_screen.dart';

enum FilterOptions {
  Favorites,
  All,
}

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showOnlyFavorites = false;

  Widget imageCarousel = Container(
      padding: EdgeInsets.symmetric(vertical: 18, horizontal: 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15))), 
      height: 200.0,
      // width
      
      child: Carousel(
        borderRadius: true,
        radius: Radius.circular(20),
        showIndicator: false,
        boxFit: BoxFit.fill, //image takes the full box
        images: [
          AssetImage('assets/images/carousel2_1.jpg'),
          AssetImage('assets/images/carousel2_2.jpg'),
          AssetImage('assets/images/carousel2_3.jpg'),
        ],
        autoplay: true,
        animationCurve: Curves.fastLinearToSlowEaseIn,
        animationDuration: Duration(milliseconds: 25),
        autoplayDuration: Duration(seconds: 9),
        dotSize: 0,
      ),
    );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
              gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [Colors.cyanAccent[400],Colors.blue[600]],
        )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: GradientAppBar(
          backgroundColorStart: Colors.blue[600],
    backgroundColorEnd: Colors.cyan,
          title: Text('e-Shoppe'),
          actions: <Widget>[
            PopupMenuButton(
              onSelected: (FilterOptions selectedValue) {
                setState(() {
                  if (selectedValue == FilterOptions.Favorites) {
                    _showOnlyFavorites = true;
                  } else {
                    _showOnlyFavorites = false;
                  }
                });
              },
              icon: Icon(
                Icons.more_vert,
              ),
              itemBuilder: (_) => [
                PopupMenuItem(
                  child: Text('Only Favorites'),
                  value: FilterOptions.Favorites,
                ),
                PopupMenuItem(
                  child: Text('Show All'),
                  value: FilterOptions.All,
                ),
              ],
            ),
            Consumer<Cart>(
              builder: (_, cart, ch) => Badge(
                color: Colors.blue[600],
                child: ch,
                value: cart.itemCount.toString(),
              ),
              child: IconButton(
                icon: Icon(
                  Icons.shopping_cart,
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(CartScreen.routeName);
                },
              ),
            ),
          ],
        ),
        // drawer: MainDrawer(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 25),
            Text("    Live healthy!", style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,fontFamily: 'OpenSans',color:Colors.white)),
            SizedBox(height: 15),
            Text("    Browse our variety of products", style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,fontFamily: 'OpenSans',color:Colors.white)),
            SizedBox(height: 15),
            
            ProductsGrid(_showOnlyFavorites),
            SizedBox(height: 25),
            Text("    Coming soon...", style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,fontFamily: 'OpenSans',color:Colors.white)),
            SizedBox(height: 15),
            imageCarousel
          ],
          
        ),
        /*Column(
          children: <Widget>[
            ProductsGrid(_showOnlyFavorites),
            RaisedButton(
                child: Text('My Orders'),
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacementNamed(OrdersScreen.routeName);
                })
          ],
        ),*/
      ),
    );
  }
}
