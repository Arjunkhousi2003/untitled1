import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/product_model.dart';

class ProductService {
  static const String _productsKey = 'products';

  static Future<List<Product>> getProducts() async {
    final prefs = await SharedPreferences.getInstance();
    final productsJson = prefs.getStringList(_productsKey) ?? [];
    
    return productsJson
        .map((json) => Product.fromJson(jsonDecode(json)))
        .toList();
  }

  static Future<bool> addProduct(Product product) async {
    final products = await getProducts();
    
    // Check for duplicates
    final isDuplicate = products.any((p) => 
        p.name.toLowerCase() == product.name.toLowerCase());
    
    if (isDuplicate) {
      return false;
    }

    products.add(product);
    await _saveProducts(products);
    return true;
  }

  static Future<void> deleteProduct(String productId) async {
    final products = await getProducts();
    products.removeWhere((product) => product.id == productId);
    await _saveProducts(products);
  }

  static Future<void> _saveProducts(List<Product> products) async {
    final prefs = await SharedPreferences.getInstance();
    final productsJson = products
        .map((product) => jsonEncode(product.toJson()))
        .toList();
    await prefs.setStringList(_productsKey, productsJson);
  }

  static List<Product> searchProducts(List<Product> products, String query) {
    if (query.isEmpty) return products;
    
    return products
        .where((product) => 
            product.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}
