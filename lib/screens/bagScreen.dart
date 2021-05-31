import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../widgets/bag_filters.dart';
import '../widgets/bag.dart';
import 'catalogScreen.dart';

class BagScreen extends StatefulWidget {
  @override
  _BagScreenState createState() => _BagScreenState();
}

class _BagScreenState extends State<BagScreen> {
  final GetStorage box = GetStorage();
  late Size size;
  TextStyle? headline1, headline2;
  late int _productsCount;

  @override
  void initState() {
    super.initState();
    try {
      final List bag = box.read('bag');
      _productsCount = bag.length;
    } catch (e) {
      print(e.toString());
      _productsCount = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    headline1 = Theme.of(context).textTheme.headline1;
    headline2 = Theme.of(context).textTheme.headline2;
    return SingleChildScrollView(
      child: Container(
        width: size.width,
        height: size.height,
        child: Scaffold(
          appBar: AppBar(
            leading: ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 0,
                primary: Colors.white,
                onPrimary: Color(0xFF6376E9),
              ),
              onPressed: () => Get.back(),
              child: SvgPicture.asset(
                'assets/svg/back.svg',
                color: Color(0xFF181B32),
              ),
            ),
            iconTheme: IconThemeData(
              size: 32,
              color: Color(0xFF505C72),
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(size.height * 0.15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Корзина',
                    style: headline1,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12.0),
                  BagFilters()
                ],
              ),
            ),
          ),
          bottomNavigationBar: bottomNavBar(),
          body: Bag(),
        ),
      ),
    );
  }

  Widget bottomNavBar() {
    return Container(
      width: size.width,
      height: size.height * 0.1,
      decoration: BoxDecoration(
        color: Color(0xFFEFF0F6),
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(30.0),
          topRight: const Radius.circular(30.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(width: size.width * 0.03),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              primary: Color(0xFFEFF0F6),
              onPrimary: Color(0xFFEFF0F6),
            ),
            onPressed: () {
              Get.to(() => CatalogScreen());
            },
            child: Container(
              height: size.height * 0.085,
              width: size.width * 0.145,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 4.0),
                      child: SvgPicture.asset(
                        'assets/svg/home.svg',
                        color: Color(0xFF181B32),
                      ),
                    ),
                    Container(
                      width: size.width * 0.02,
                      height: size.width * 0.02,
                      child: SvgPicture.asset(
                        'assets/svg/dot.svg',
                        color: Colors.transparent,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              primary: Color(0xFFEFF0F6),
              onPrimary: Color(0xFFEFF0F6),
            ),
            onPressed: () {},
            child: Container(
              height: size.height * 0.085,
              width: size.width * 0.145,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 2.0),
                      child: SvgPicture.asset(
                        'assets/svg/heart.svg',
                        color: Color(0xFF181B32),
                      ),
                    ),
                    Container(
                      width: size.width * 0.02,
                      height: size.width * 0.02,
                    )
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              primary: Color(0xFFEFF0F6),
              onPrimary: Color(0xFFEFF0F6),
            ),
            onPressed: () {
              Get.to(() => BagScreen());
            },
            child: Container(
              height: size.height * 0.085,
              width: size.width * 0.145,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Stack(
                      children: [
                        SvgPicture.asset(
                          'assets/svg/bag.svg',
                          color: Color(0xFF6376E9),
                        ),
                        Opacity(
                          opacity: _productsCount == 0 ? 0.0 : 1.0,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 14.0),
                            child: Container(
                              width: size.width * 0.03,
                              height: size.width * 0.03,
                              decoration: BoxDecoration(
                                color: Color(0xFFEB5757),
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Container(
                      width: size.width * 0.02,
                      height: size.width * 0.02,
                      child: SvgPicture.asset(
                        'assets/svg/dot.svg',
                        color: Color(0xFF6376E9),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              primary: Color(0xFFEFF0F6),
              onPrimary: Color(0xFFEFF0F6),
            ),
            onPressed: () {},
            child: Container(
              height: size.height * 0.085,
              width: size.width * 0.145,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SvgPicture.asset(
                      'assets/svg/profile.svg',
                      color: Color(0xFF181B32),
                    ),
                    Container(
                      width: size.width * 0.02,
                      height: size.width * 0.02,
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(width: size.width * 0.03),
        ],
      ),
    );
  }
}
