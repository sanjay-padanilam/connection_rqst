import 'package:connection_rqst/controller/homescreen_controller/home_screen_controller.dart';
import 'package:connection_rqst/controller/homescreen_controller/home_screen_state.dart';
import 'package:connection_rqst/view/product_details_screen/productdetails_screen.dart';
import 'package:connection_rqst/view/status_screen/status_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Homescreen extends ConsumerStatefulWidget {
  const Homescreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomescreenState();
}

class _HomescreenState extends ConsumerState<Homescreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(homeScreenStateProvider.notifier).getAllProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final homescreeenstate =
        ref.watch(homeScreenStateProvider) as HomeScreenState;

    return DefaultTabController(
      length: homescreeenstate.catagories?.length ?? 0,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple.shade300,
          title: const Text(
            "Discover",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          actions: [
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StatusPage(),
                    ));
              },
              child: const Icon(
                Icons.local_mall_outlined,
                size: 30,
              ),
            ),
            const SizedBox(width: 20),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurple.shade300, Colors.deepPurple.shade300],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: homescreeenstate.isLoading
              ? const Center(child: CircularProgressIndicator.adaptive())
              : homescreeenstate.productlist == null ||
                      homescreeenstate.productlist!.isEmpty
                  ? const Center(child: Text("No products available"))
                  : GridView.builder(
                      padding: const EdgeInsets.all(8.0),
                      itemCount: homescreeenstate.productlist!.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 1 / 2,
                        crossAxisCount: 2,
                      ),
                      itemBuilder: (context, index) {
                        final product = homescreeenstate.productlist![index];
                        return ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Colors.deepPurple.shade300),
                          ),
                          onPressed: () {
                            if (product.id != null) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ProductdetailsScreen(id: product.id!),
                                ),
                              );
                            }
                          },
                          child: Column(
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    image: DecorationImage(
                                      fit: BoxFit.contain,
                                      image: NetworkImage(product.image ?? ''),
                                    ),
                                  ),
                                ),
                              ),
                              Column(
                                children: [
                                  Text(
                                    product.title ?? '',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                  Text(
                                    "\$${product.price?.toStringAsFixed(2) ?? '0.00'}",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
        ),
      ),
    );
  }
}
