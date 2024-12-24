import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connection_rqst/controller/homescreen_controller/home_screen_controller.dart';
import 'package:connection_rqst/controller/status_screen_controller/status_screen_controller.dart';
import 'package:connection_rqst/controller/status_screen_controller/status_screen_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StatusScreen extends ConsumerStatefulWidget {
  StatusScreen({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _StatusScreenState();
}

class _StatusScreenState extends ConsumerState<StatusScreen> {
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        await ref.read(homeScreenStateProvider.notifier).getAllProducts();
      },
    );
    super.initState();
  }

  final Stream<QuerySnapshot> _userStream =
      FirebaseFirestore.instance.collection('user').snapshots();

  @override
  Widget build(BuildContext context) {
    final statusscreenstate =
        ref.watch(StatusStateProvider) as StatusScreenState;
    return StreamBuilder(
      stream: _userStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text('Something went wrong'),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text('No services available'),
          );
        }

        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(),
            body: Container(
              height: double.infinity,
              width: double.infinity,
              child: ListView.builder(
                itemCount: statusscreenstate.data!.length,
                itemBuilder: (context, index) {
                  final productlist = snapshot.data!.docs;
                  final productid = productlist[index]["productid"];
                  log(productid);

                  return ListTile(
                    title:
                        Text(statusscreenstate.data![index].title.toString()),
                  );
                },
              ),
            ),
          );
        }
        return SizedBox();
      },
    );
  }
}
