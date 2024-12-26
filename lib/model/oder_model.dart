import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  final String id;
  final String userId;
  final String productId;
  final String imageUrl;
  final String itemName;
  final int quantity;
  final String status;
  final DateTime? timestamp;

  OrderModel({
    required this.id,
    required this.userId,
    required this.productId,
    required this.imageUrl,
    required this.itemName,
    required this.quantity,
    required this.status,
    this.timestamp,
  });

  factory OrderModel.fromMap(Map<String, dynamic> data, String id) {
    return OrderModel(
      id: id,
      userId: data['userId'],
      productId: data['productId'],
      imageUrl: data['imageUrl'],
      itemName: data['itemName'],
      quantity: data['quantity'],
      status: data['status'],
      timestamp: (data['timestamp'] as Timestamp?)?.toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'productId': productId,
      'imageUrl': imageUrl,
      'itemName': itemName,
      'quantity': quantity,
      'status': status,
      'timestamp': FieldValue.serverTimestamp(),
    };
  }
}
