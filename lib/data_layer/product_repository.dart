import 'package:http/http.dart' as http;
import 'package:nesa_screening/data_layer/models.dart';
import 'dart:convert';

const String url = "dummyjson.com";
const int limit = 10;

class ProductRepository {
  final http.Client _httpClient;
  List<Product> productList;

  ProductRepository()
      : _httpClient = http.Client(),
        productList = [];

  Future<void> fetchProductList({
    int limit = limit,
    int skip = 0,
  }) async {
    Uri uri = Uri.http(url, 'products', <String, String>{
      'limit': '$limit',
      'skip': '$skip',
    });

    final response = await _httpClient.get(uri);
    if (response.statusCode == 200) {
      Map<String, dynamic> resultMap = jsonDecode(response.body);
      productList.addAll(ProductList.fromJson(resultMap).products);
      return;
    }
    // todo: improve error handling
    throw Exception();
  }
}
