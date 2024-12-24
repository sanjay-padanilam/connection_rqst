import 'package:connection_rqst/controller/homescreen_controller/home_screen_controller.dart';
import 'package:connection_rqst/controller/homescreen_controller/home_screen_state.dart';
import 'package:connection_rqst/view/product_details_screen/productdetails_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Homescreen extends ConsumerStatefulWidget {
  const Homescreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomescreenState();
}

class _HomescreenState extends ConsumerState<Homescreen> {
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        await ref.read(homeScreenStateProvider.notifier).getAllProducts();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final homescreeenstate =
        ref.watch(homeScreenStateProvider) as HomeScreenState;
    return DefaultTabController(
      length: homescreeenstate.catagories!.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple.shade300,
          title: Text(
            "Discover",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          actions: [
            InkWell(
              onTap: () {},
              child: Icon(
                Icons.local_mall_outlined,
                size: 30,
              ),
            ),
            SizedBox(
              width: 20,
            )
          ],
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurple.shade300, Colors.deepPurple.shade300],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: homescreeenstate.isLoading
              ? CircularProgressIndicator.adaptive()
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: homescreeenstate.productlist!.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 1 / 2, crossAxisCount: 2),
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll(
                                    Colors.deepPurple.shade300)),
                            onPressed: () {
                              if (homescreeenstate.productlist![index].id !=
                                  null) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ProductdetailsScreen(
                                              id: homescreeenstate
                                                      .productlist?[index].id ??
                                                  0),
                                    ));
                              }
                            },
                            child: Column(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 600,
                                    width: 180,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        image: DecorationImage(
                                            fit: BoxFit.contain,
                                            image: NetworkImage(homescreeenstate
                                                .productlist![index].image
                                                .toString()))),
                                  ),
                                ),
                                Column(
                                  children: [
                                    Text(
                                      homescreeenstate.productlist![index].title
                                          .toString(),
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    Text(
                                        "\$ ${homescreeenstate.productlist![index].price.toString()}",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15))
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
