import 'package:connection_rqst/controller/product_details_screen_controller.dart/product_details_controller.dart';
import 'package:connection_rqst/controller/product_details_screen_controller.dart/product_details_state.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';
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
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        await ref
            .read(ProductdetailsProvider.notifier)
            .getProductdetails(widget.id);
      },
    );
    super.initState();
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
            ? CircularProgressIndicator.adaptive()
            : Padding(
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: 450,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(productdetailsstate
                                        .productdetails!.image
                                        .toString()))),
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
                                weight: 30,
                              ))
                        ],
                      ),
                      Container(
                        child: Column(
                          children: [
                            Text(
                              productdetailsstate.productdetails!.title
                                  .toString(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Row(
                              children: [
                                RatingBar.readOnly(
                                  size: 20,
                                  filledIcon: Icons.star,
                                  emptyIcon: Icons.star_border,
                                  initialRating: productdetailsstate
                                          .productdetails!.rating!.rate ??
                                      0,
                                  maxRating: 5,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "${productdetailsstate.productdetails!.rating!.count}/rating",
                                  style: TextStyle(
                                      color: Colors.amber,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                                maxLines: 3,
                                textAlign: TextAlign.justify,
                                productdetailsstate.productdetails!.description
                                    .toString()),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Text(
                                  "choose size",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                    child: Center(
                                      child: Text(
                                        "S",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                    ),
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black),
                                    )),
                                SizedBox(width: 10),
                                Container(
                                    child: Center(
                                      child: Text(
                                        "M",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                    ),
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 1,
                                        color: const Color.fromARGB(
                                            255, 49, 48, 48),
                                      ),
                                    )),
                                SizedBox(width: 10),
                                Container(
                                    child: Center(
                                      child: Text(
                                        "L",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                    ),
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black),
                                    ))
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text("Price"),
                              Text(
                                "\$ ${productdetailsstate.productdetails!.price.toString()}",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25),
                              )
                            ],
                          ),
                          InkWell(
                            onTap: () {
                              // context
                              //     .read<CartScreenController>()
                              //     .addProduct(productdetailscontroller.product!);
                              // context.read<CartScreenController>().getAllProducts();

                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: (context) => Cartscreen(),
                              //     ));
                            },
                            child: Container(
                              height: 50,
                              width: 150,
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 25,
                                  ),
                                  Icon(
                                    Icons.local_mall_outlined,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "add to cart",
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      )
                    ] //colums
                    ,
                  ),
                ),
              ),
      ),
    );
  }
}
