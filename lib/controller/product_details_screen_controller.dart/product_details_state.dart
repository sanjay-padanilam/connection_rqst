import 'package:connection_rqst/model/product_model.dart';

class ProductDetailsState {
  bool isLoading;
  Productmodel? productdetails;
  ProductDetailsState({this.productdetails, this.isLoading = false});

  ProductDetailsState copyWith(
      {bool? isLoading, List? catagories, var productdetails}) {
    return ProductDetailsState(
        isLoading: isLoading ?? this.isLoading,
        productdetails: productdetails ?? this.productdetails);
  }
}
