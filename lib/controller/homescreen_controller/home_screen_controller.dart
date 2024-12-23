import 'dart:convert';
import 'dart:developer';

import 'package:connection_rqst/controller/homescreen_controller/home_screen_state.dart';
import 'package:connection_rqst/model/product_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final homeScreenStateProvider = StateNotifierProvider(
  (ref) => HomeScreenStateNotifier(),
);
List<Map> allcatagortylist = [];
List cataorylist = [];
List<Productmodel> productlist = [];

class HomeScreenStateNotifier extends StateNotifier<HomeScreenState> {
  HomeScreenStateNotifier() : super(HomeScreenState());

  Future<void> getcatagories() async {
    final catagoryUrl =
        Uri.parse("https://fakestoreapi.com/products/categories");
    try {
      var responce = await http.get(catagoryUrl);
      if (responce.statusCode == 200) {
        log(responce.statusCode.toString());
        state = state.copyWith(catagories: jsonDecode(responce.body));
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> getallProducts({String? catagoryindex}) async {
    final GetallproductsUrl = Uri.parse("https://fakestoreapi.com/products");
    final catagorywiseurl =
        Uri.parse("https://fakestoreapi.com/products/category/$catagoryindex");

    try {
      var responce = await http.get(
          catagoryindex == null || catagoryindex == "All"
              ? GetallproductsUrl
              : catagorywiseurl);
      if (responce.statusCode == 200) {
        state = state.copyWith(
            productlist: productlistresponsemodelFromJson(responce.body));
      }
    } catch (e) {
      print(e);
    }
  }
}
