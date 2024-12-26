import 'package:connection_rqst/model/product_model.dart';

class ProductDetailsState {
  bool isLoading;
  Productmodel? productdetails;
  Map<String, dynamic>? newOrder;
  ProductDetailsState(
      {this.productdetails, this.isLoading = false, this.newOrder});

  ProductDetailsState copyWith(
      {bool? isLoading,
      List? catagories,
      var productdetails,
      Map<String, dynamic>? newOrder}) {
    return ProductDetailsState(
        isLoading: isLoading ?? this.isLoading,
        productdetails: productdetails ?? this.productdetails,
        newOrder: newOrder ?? this.newOrder);
  }
}
