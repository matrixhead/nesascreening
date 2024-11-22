import 'package:http/http.dart' as http;
import 'package:nesa_screening/data_layer/models.dart';
import 'dart:convert';

const String url = "dummyjson.com";
const int limit = 10;

class ProductRepository {
  final http.Client _httpClient;
  Map<int, Product> products;
  bool hasReachedMax;

  ProductRepository()
      : _httpClient = http.Client(),
        hasReachedMax = false,
        products = {};

  Future<void> loadMoreCategory() async {
    String? category;

    bool tryAgain = true;

    if (hasReachedMax) {
      return;
    }

    while (tryAgain) {
      Uri uri = Uri.http(url, 'products', <String, String>{
        'limit': '$limit',
        'skip': '${products.length}',
      });
      final response = await _httpClient.get(uri);
      if (response.statusCode == 200) {
        Map<String, dynamic> result = jsonDecode(response.body);

        final productList = ProductList.fromJson(result).products;
        if (productList.isEmpty) {
          tryAgain = false;
          hasReachedMax = true;
        }
        for (final product in productList) {
          if (category != null) {
            if (product.category != category) {
              tryAgain = false;
              break;
            }
          } else {
            category = product.category;
          }
          products[product.id] = product;
        }
      }
      else{
      // todo: improve error handling
      throw Exception();
      }
    }
  }

  Future<Product> fetchProduct({
    required int id,
  }) async {
    if (products[id] != null) {
      return products[id]!;
    }
    Uri uri = Uri.https(url, 'products/$id');
    final response = await _httpClient.get(uri);
    if (response.statusCode == 200) {
      Map<String, dynamic> resultMap = jsonDecode(response.body);
      final product = (Product.fromJson(resultMap));
      products[id] = product;
      return product;
    }
    throw Exception();
  }

  Future<void> updateProduct(final Product product) async {
    final json = jsonEncode(product.toJson());
    Uri uri = Uri.https(
      url,
      'products/${product.id}',
    );
    final response = await _httpClient.put(
      uri,
      body: json,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      products[product.id] = product;
      return;
    }
    throw Exception();
  }

  Map<String, List<Product>> get getCategoryMap {
    Map<String, List<Product>> categoryMap = {};
    for (final product in products.values) {
      if (categoryMap.containsKey(product.category)) {
        categoryMap[product.category]!.add(product);
      } else {
        categoryMap[product.category] = [product];
      }
    }
    return categoryMap;
  }
}
