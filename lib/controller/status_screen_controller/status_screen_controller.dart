import 'package:connection_rqst/controller/status_screen_controller/status_screen_state.dart';
import 'package:connection_rqst/model/product_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final StatusStateProvider = StateNotifierProvider((ref) {
  return StatusstateNotifier();
});

class StatusstateNotifier extends StateNotifier<StatusScreenState> {
  StatusstateNotifier() : super(StatusScreenState());

  Future<void> getProductdetails(int productid) async {
    state = state.copyWith(isLoadng: true);
    final url = Uri.parse("https://fakestoreapi.com/products/$productid");
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        state = state.copyWith(
            data: productlistresponsemodelFromJson(response.body));
      }
    } catch (e) {
      print(e);
    }
    state = state.copyWith(isLoadng: false);
  }

  // Map<String, dynamic>? userData; // External variable to hold user data

  // Future<void> fetchUserData() async {
  //   try {
  //     // Ensure the user is authenticated
  //     final User? user = FirebaseAuth.instance.currentUser;

  //     if (user == null) {
  //       print('No authenticated user found.');
  //       return;
  //     }

  //     // Access Firestore document
  //     DocumentSnapshot snapshot = await FirebaseFirestore.instance
  //         .collection('user')
  //         .doc(user.uid)
  //         .get();

  //     // Check if the document exists and store the data
  //     if (snapshot.exists) {
  //       userData = snapshot.data() as Map<String, dynamic>?;
  //       state = state.copyWith(userData: userData);
  //       print('User data fetched successfully: $userData');
  //     } else {
  //       print('User document not found in Firestore.');
  //       userData = null;
  //     }
  //   } catch (e, stackTrace) {
  //     // Log the error with the stack trace for debugging
  //     print('Error fetching user data: $e');
  //     print(stackTrace);
  //     userData = null;
  //   }
  // }
}
