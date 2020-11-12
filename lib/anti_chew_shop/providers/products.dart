import 'package:flutter/material.dart';

import './product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Milk Thistle',
      description: 'Milk thistle is often promoted for its liver-protecting effects.It’s regularly used as a complementary therapy by people who have liver damage due to conditions like alcoholic liver disease, non-alcoholic fatty liver disease, hepatitis and even liver cancer .It’s also used to protect the liver against toxins like amatoxin, which is produced by the death cap mushroom and is deadly if ingested . ',
      price: 29.99,
      imageUrl:
          'https://img4.hkrtcdn.com/10148/prd_1014783-Natures-Velvet-Milk-Thistle-Extract-60-softgels_c_l.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Chlorella Powder',
      description: 'Chlorella’s impressive nutritional profile has led some to call it a “super food.” While its exact nutrient content depends on growing conditions, the species used and how supplements are processed, it’s clear it packs several beneficial nutrients. Chlorella has gotten some buzz for its ability to help the body “detox.” In fact, animal studies indicate that it’s effective at helping remove heavy metals and other harmful compounds from the body (9Trusted Source, 10Trusted Source, 11Trusted Source). Heavy metals include some elements that are essential in small amounts, such as iron and copper, but these and other heavy metals like cadmium and lead can be toxic in larger amounts.',
      price: 59.99,
      imageUrl:
          'https://rukminim1.flixcart.com/image/832/832/jyg5lzk0/vitamin-supplement/g/u/w/60-organic-chlorella-parry-s-original-imafgnzge7ftrfgk.jpeg?q=70',
    ),
    Product(
      id: 'p3',
      title: 'Organic Spirulina',
      description: 'Spirulina is a type of blue-green algae that contains a number of nutrients, including B vitamins, beta-carotene, and vitamin E. Spirulina also contains antioxidants, minerals, chlorophyll, and phycocyanobilin and is commonly used as a source of vegan protein. Among proponents, spirulina has been used to support a number of health conditions, including fatigue, high cholesterol, high triglycerides, and viral infections. Purported spirulina benefits also include weight loss, increased energy, and stimulation of the immune system.',
      price: 19.99,
      imageUrl:
          'https://images-na.ssl-images-amazon.com/images/I/71PzCaQvPUL._SL1500_.jpg',
    ),
    Product(
      id: 'p4',
      title: '10 MUSHROOM BLEND',
      description: 'Our 10 Mushroom Blend includes the most powerful body and mind defending mushrooms, beta-glucans and antioxidant properties from chaga, reishi, cordyceps and lion"s mane, along with our other favorite fungi legends shiitake, maitake, enokitake, agaricus blazei, meshima, and tremella.',
      price: 49.99,
      imageUrl:
          'https://cdn.shopify.com/s/files/1/0253/7842/2831/products/MushroomBlend_Canister_800x.png?v=1594466066',
    ),
  ];
  // var _showFavoritesOnly = false;

  List<Product> get items {
    // if (_showFavoritesOnly) {
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // }
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  // void showFavoritesOnly() {
  //   _showFavoritesOnly = true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   _showFavoritesOnly = false;
  //   notifyListeners();
  // }

  void addProduct(Product product) {
    final newProduct = Product(
      title: product.title,
      description: product.description,
      price: product.price,
      imageUrl: product.imageUrl,
      id: DateTime.now().toString(),
    );
    _items.add(newProduct);
    // _items.insert(0, newProduct); // at the start of the list
    notifyListeners();
  }

  void updateProduct(String id, Product newProduct) {
    final prodIndex = _items.indexWhere((prod) =>
        prod.id == id); //funtion which runs on every item tocheck condition
    if (prodIndex >= 0) {
      _items[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print('...');
    }
  }

  void deleteProduct(String id) {
    _items.removeWhere((prod) => prod.id == id);
    notifyListeners();
  }
}
