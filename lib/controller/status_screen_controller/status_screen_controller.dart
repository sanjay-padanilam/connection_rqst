import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connection_rqst/controller/status_screen_controller/status_screen_state.dart';
import 'package:connection_rqst/model/oder_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final StatusStateProvider = StateNotifierProvider((ref) {
  return StatusstateNotifier();
});

class StatusstateNotifier extends StateNotifier<StatusScreenState> {
  StatusstateNotifier() : super(StatusScreenState());

  Stream<List<OrderModel>> fetchUserOrders(String userId) {
    return FirebaseFirestore.instance
        .collection('orders')
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              return OrderModel.fromMap(doc.data(), doc.id);
            }).toList());
  }
}
