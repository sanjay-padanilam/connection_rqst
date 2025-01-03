import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
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

  void addOrder({
    required String userId,
    required String productId,
    required String email,
    required String status,
    required String imageUrl,
    required String itmeName,
  }) async {
    final order = {
      'userId': userId,
      'productId': productId,
      'imageUrl': imageUrl,
      "itemName": itmeName,
      'quantity': 1,
      'status': 'pending',
      'timestamp': FieldValue.serverTimestamp(),
    };

    try {
      await FirebaseFirestore.instance.collection('orders').add(order);
      print("Order added successfully!");
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied') {
        print('Permission denied. Please check Firestore rules.');
      } else if (e.code == 'unavailable') {
        print('Firestore is currently unavailable. Try again later.');
      } else if (e.code == 'invalid-argument') {
        print('Invalid data provided. Check the fields and data types.');
      } else {
        print('FirebaseException: ${e.message}');
      }
    } catch (e) {
      print('An unexpected error occurred: $e');
    }
  }

  void onuserdocOrder(
      {required String id,
      required String productId,
      required String status}) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    DocumentReference docRef = firestore.collection("user").doc(id);

    try {
      Map<String, dynamic> newOrder = {
        'productid': productId,
        'status': status,
      };

      await docRef.update({
        'cart items': FieldValue.arrayUnion([newOrder]),
      });

      print("Order for product $productId added successfully!");
    } catch (e) {
      if (e is FirebaseException && e.code == 'not-found') {
        await docRef.set({
          'cart items': ["newOrder"],
        });
        print("Document created and order for product $productId added!");
      } else {
        print("Error adding order: $e");
      }
    }
  }
}
