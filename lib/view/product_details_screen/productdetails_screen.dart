import 'package:connection_rqst/controller/product_details_screen_controller.dart/product_details_controller.dart';
import 'package:connection_rqst/controller/product_details_screen_controller.dart/product_details_state.dart';
import 'package:connection_rqst/view/status_screen/status_screen.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductdetailsScreen extends ConsumerStatefulWidget {
  final int id;
  const ProductdetailsScreen({super.key, required this.id});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ProductdetailsScreenState();
}

class _ProductdetailsScreenState extends ConsumerState<ProductdetailsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        await ref
            .read(ProductdetailsProvider.notifier)
            .getProductdetails(widget.id);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final productdetailsstate =
        ref.watch(ProductdetailsProvider) as ProductDetailsState;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade300,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple.shade300, Colors.deepPurple.shade100],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: productdetailsstate.isLoading
            ? Center(
                child: CircularProgressIndicator.adaptive(),
              )
            : Padding(
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // Product Image Section
                      Stack(
                        children: [
                          Container(
                            height: 450,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                    productdetailsstate.productdetails?.image ??
                                        ''),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 20,
                            right: 50,
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                          Positioned(
                            right: 60,
                            top: 36,
                            child: Icon(
                              Icons.favorite_border_outlined,
                              color: Colors.black,
                              size: 30,
                            ),
                          )
                        ],
                      ),

                      // Product Details Section
                      Column(
                        children: [
                          Text(
                            productdetailsstate.productdetails?.title ?? '',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              RatingBar.readOnly(
                                size: 20,
                                filledIcon: Icons.star,
                                emptyIcon: Icons.star_border,
                                initialRating: productdetailsstate
                                        .productdetails?.rating?.rate ??
                                    0,
                                maxRating: 5,
                              ),
                              SizedBox(width: 10),
                              Text(
                                "${productdetailsstate.productdetails?.rating?.count ?? 0}/rating",
                                style: TextStyle(
                                  color: Colors.amber,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          Text(
                            productdetailsstate.productdetails?.description ??
                                '',
                            maxLines: 3,
                            textAlign: TextAlign.justify,
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              Text(
                                "Choose size",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: ['S', 'M', 'L'].map((size) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                  ),
                                  child: Center(
                                    child: Text(
                                      size,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),

                      // Price and Buy Now Section
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text("Price"),
                              Text(
                                "\$ ${productdetailsstate.productdetails?.price.toString() ?? '0.00'}",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                ),
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: () async {
                              User? user = FirebaseAuth.instance.currentUser;

                              ref
                                  .read(ProductdetailsProvider.notifier)
                                  .addOrder(
                                      itmeName: productdetailsstate
                                          .productdetails!.title
                                          .toString(),
                                      imageUrl: productdetailsstate
                                          .productdetails!.image
                                          .toString(),
                                      userId: user!.uid.toString(),
                                      productId: productdetailsstate
                                          .productdetails!.id
                                          .toString(),
                                      email: user.email.toString(),
                                      status: 'pendng');
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => StatusPage(),
                                  ));
                            },
                            child: Container(
                              height: 50,
                              width: 150,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  SizedBox(width: 25),
                                  Icon(
                                    Icons.local_mall_outlined,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    "Buy Now",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
