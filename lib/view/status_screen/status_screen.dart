import 'package:connection_rqst/controller/status_screen_controller/status_screen_controller.dart';
import 'package:connection_rqst/model/oder_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StatusPage extends ConsumerStatefulWidget {
  const StatusPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomepageState();
}

class _HomepageState extends ConsumerState<StatusPage> {
  final User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.deepPurple.shade200,
        appBar: AppBar(
          backgroundColor: Colors.deepPurple.shade400,
          title: Text('Order List'),
        ),
        body: StreamBuilder<List<OrderModel>>(
          stream: ref
              .read(StatusStateProvider.notifier)
              .fetchUserOrders(user!.uid.toString()),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            if (snapshot.hasError || !snapshot.hasData) {
              return Text('Error fetching orders ${snapshot.error}');
            }

            final orders = snapshot.data!;
            return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      ListTile(
                        leading: Image.network(order.imageUrl),
                        title: Text(
                          ' ${order.itemName}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          'Quantity: ${order.quantity}\nStatus: ${order.status}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        trailing: order.status.toLowerCase() == 'approved'
                            ? Container(
                                color: Colors.green,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("Order Approved"),
                                ),
                              )
                            : order.status.toLowerCase() == 'rejected'
                                ? Container(
                                    color: Colors.red,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("Order Rejected"),
                                    ),
                                  )
                                : Container(
                                    color: Colors.yellow,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("Order pending"),
                                    ),
                                  ),
                      ),
                      Divider(
                        height: 12,
                      )
                    ],
                  ),
                );
              },
            );
          },
        ));
  }
}
