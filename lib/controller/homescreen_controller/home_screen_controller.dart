import 'dart:convert';
import 'dart:developer';

import 'package:connection_rqst/controller/homescreen_controller/home_screen_state.dart';
import 'package:connection_rqst/model/product_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final homeScreenStateProvider = StateNotifierProvider(
  (ref) => HomeScreenStateNotifier(),
);

class HomeScreenStateNotifier extends StateNotifier<HomeScreenState> {
  HomeScreenStateNotifier() : super(HomeScreenState());

  Future<void> getCategories() async {
    state = state.copyWith(isLoading: true);

    final categoryUrl =
        Uri.parse("https://fakestoreapi.com/products/categories");

    try {
      final response = await http.get(categoryUrl);

      if (response.statusCode == 200) {
        log("Categories fetched successfully: ${response.statusCode}");
        state = state.copyWith(catagories: jsonDecode(response.body));
      } else {
        log("Failed to fetch categories: ${response.statusCode}");
      }
    } catch (e) {
      log("Error fetching categories: $e");
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> getAllProducts({String? categoryIndex}) async {
    state = state.copyWith(isLoading: true);

    final getAllProductsUrl = Uri.parse("https://fakestoreapi.com/products");
    final categoryWiseUrl =
        Uri.parse("https://fakestoreapi.com/products/category/$categoryIndex");

    try {
      final response = await http.get(
        (categoryIndex == null || categoryIndex == "All")
            ? getAllProductsUrl
            : categoryWiseUrl,
      );

      if (response.statusCode == 200) {
        log("Products fetched successfully: ${response.statusCode}");
        state = state.copyWith(
          productlist: productlistresponsemodelFromJson(response.body),
        );
      } else {
        log("Failed to fetch products: ${response.statusCode}");
      }
    } catch (e) {
      log("Error fetching products: $e");
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}
