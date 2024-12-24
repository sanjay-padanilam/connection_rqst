import 'package:connection_rqst/model/product_model.dart';

class StatusScreenState {
  bool isLoadng;
  List<Productmodel>? data;
  Map<String, dynamic>? userData;
  StatusScreenState({this.data, this.isLoadng = false, this.userData});
  StatusScreenState copyWith(
      {bool? isLoadng,
      List<Productmodel>? data,
      Map<String, dynamic>? userData}) {
    return StatusScreenState(
        data: data ?? this.data,
        isLoadng: isLoadng ?? this.isLoadng,
        userData: userData ?? this.userData);
  }
}
