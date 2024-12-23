import 'dart:convert';

import 'package:connection_rqst/controller/product_details_screen_controller.dart/product_details_state.dart';
import 'package:connection_rqst/model/product_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final ProductdetailsProvider = StateNotifierProvider((ref) {
  return ProductDetailsStateNotifier();
});

class ProductDetailsStateNotifier extends StateNotifier<ProductDetailsState> {
  ProductDetailsStateNotifier() : super(ProductDetailsState());
  Future<void> getProductdetails(int productid) async {
    state = state.copyWith(isLoading: true);
    final url = Uri.parse("https://fakestoreapi.com/products/$productid");
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        state = state.copyWith(
            productdetails: Productmodel.fromJson(jsonDecode(response.body)));
      }
    } catch (e) {
      print(e);
    }
    state = state.copyWith(isLoading: false);
  }
}
