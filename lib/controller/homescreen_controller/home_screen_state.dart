import 'package:connection_rqst/model/product_model.dart';

class HomeScreenState {
  bool isLoading;
  List? catagories;
  List<Productmodel>? productlist = [];
  HomeScreenState({this.isLoading = false, this.catagories, this.productlist});

  HomeScreenState copyWith(
      {bool? isLoading, List? catagories, List<Productmodel>? productlist}) {
    return HomeScreenState(
        catagories: catagories ?? this.catagories,
        isLoading: isLoading ?? this.isLoading,
        productlist: productlist ?? this.productlist);
  }
}
