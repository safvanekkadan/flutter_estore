import 'package:card_swiper/card_swiper.dart';
import 'package:estore/constants/constcolor.dart';
import 'package:estore/controller/homescreen_provider.dart';
import 'package:estore/home/categories_screen.dart';
import 'package:estore/home/feed_screen.dart';
import 'package:estore/home/users_screen.dart';
import 'package:estore/model/products_model.dart';
import 'package:estore/service/api_fetch.dart';
import 'package:estore/widgets/appbar_widget.dart';
import 'package:estore/widgets/feedgrid_widget.dart';
import 'package:estore/widgets/sales_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var homeprovider = Provider.of<HomeScreenProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
        leading: AppBarIcons(
          function: () {
            Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.fade,
                child: const CategoriesScreen(),
              ),
            );
          },
          icon: IconlyBold.category,
        ),
        actions: [
          AppBarIcons(
            function: () {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.fade,
                  child: const UsersScreen(),
                ),
              );
            },
            icon: IconlyBold.user3,
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(6),
        child: Column(
          children: [
            SizedBox(
              height: 16,
            ),
            TextField(
              controller: homeprovider.SearchText,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  hintText: "Search",
                  filled: true,
                  fillColor: Theme.of(context).cardColor,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Theme.of(context).cardColor,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      width: 1,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  suffixIcon: Icon(
                    IconlyLight.search,
                    color: lightIconsColor,
                  )),
            ),
            SizedBox(
              height: 18,
            ),
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.25,
                    child: Swiper(
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return const SaleWidget();
                      },
                      autoplay: true,
                      pagination: SwiperPagination(
                          alignment: Alignment.bottomCenter,
                          builder: DotSwiperPaginationBuilder(
                              color: Colors.white, activeColor: Colors.red)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Text(
                          "Latest Products",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 18),
                        ),
                        const Spacer(),
                        AppBarIcons(
                            function: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.fade,
                                      child: const FeedsScreen()));
                            },
                            icon: IconlyBold.arrowRight3)
                      ],
                    ),
                  ),
                  FutureBuilder<List<ProductsModel>>(
                      future: APIHandler.getAllProducts(limit: "3"),
                      builder: ((context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          Center(
                            child: Text("An error occured ${snapshot.error}"),
                          );
                        } else if (snapshot.data == null) {
                          const Center(
                            child: Text("No products has been added yet"),
                          );
                        }
                        return FeedsGridWidget(productsList: snapshot.data!);
                      }))
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
