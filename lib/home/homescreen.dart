import 'package:card_swiper/card_swiper.dart';
import 'package:estore/constants/constcolor.dart';
import 'package:estore/controller/homescreen_provider.dart';
import 'package:estore/widgets/appbar_widget.dart';
import 'package:estore/widgets/sales_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var homeprovider = Provider.of<HomeScreenProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen"),
        leading: AppBarIcons(
          function: () {},
          icon: IconlyBold.category,
        ),
        actions: [
          AppBarIcons(
            function: () {},
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
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
