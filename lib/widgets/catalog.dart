import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:test_catalog/screens/detailsScreen.dart';

import '../screens/detailsScreen.dart';
import '../json/data.dart';
import 'colorIndicator.dart';

class Catalog extends StatefulWidget {
  @override
  _CatalogState createState() => _CatalogState();
}

class _CatalogState extends State<Catalog> {
  final GetStorage box = GetStorage();
  late String _category, _categoryTitle, _categorySubtitle;
  late Size size;

  TextStyle? headline1, headline2, headline3, bodyText1;
  List<Map<String, Object>> _products = [];
  String? _priceFilter, _colorFilter, _categoryImageUrl;
  Map<String, Object>? productMap;

  _getCategoryData() {
    _category = box.read('category');
    for (int i = 0; i < categories.length; i++) {
      final String title = (categories[i])["title"].toString();
      if (_category == title) {
        _categoryTitle = (categories[i])["title"].toString();
        _categorySubtitle = (categories[i])["subtitle"].toString();
        _categoryImageUrl = (categories[i])["imgUrl"].toString();
      }
    }
  }

  _gotoDetails(int index) {
    productMap = _products[index];
    Get.to(Details(productMap: productMap));
  }

  _getProductsByFilters() async {
    final List<Map<String, Object>> prod = [];
    _products.clear();
    await _getCategoryData();
    _colorFilter = box.read('color');
    allProducts.forEach((product) {
      if (product['category'] == _category) {
        if (_colorFilter != 'none') {
          print(_colorFilter);
          if (product['color1'] == _colorFilter ||
              product['color2'] == _colorFilter ||
              product['color3'] == _colorFilter) {
            prod.add(product);
          }
        } else {
          prod.add(product);
        }
      }
    });
    _priceFilter = box.read('price');
    if (_priceFilter != 'none') {
      print(_priceFilter);
      if (_priceFilter == 'Дороже') {
        prod.sort((a, b) => (int.parse(b['price'].toString()))
            .compareTo(int.parse(a['price'].toString())));
        _products = prod;
      } else {
        prod.sort((a, b) => (int.parse(a['price'].toString()))
            .compareTo(int.parse(b['price'].toString())));
        _products = prod;
      }
    } else {
      _products = prod;
    }
    setState(() {
      print('Good');
    });
  }

  @override
  void initState() {
    super.initState();
    _getProductsByFilters();
  }

  @override
  Widget build(BuildContext context) {
    box.listen(() {
      _getProductsByFilters();
      setState(() {});
    });
    size = MediaQuery.of(context).size;
    headline1 = Theme.of(context).textTheme.headline1;
    headline2 = Theme.of(context).textTheme.headline2;
    headline3 = Theme.of(context).textTheme.headline3;
    bodyText1 = Theme.of(context).textTheme.bodyText1;
    return ListView(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
          child: Stack(
            fit: StackFit.loose,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: Image.network(
                  _categoryImageUrl!,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: size.width * 0.02, top: size.width * 0.05),
                    child: Text(_categoryTitle, style: headline3),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: size.width * 0.02),
                    child: Text(_categorySubtitle,
                        style: headline2!.copyWith(color: Colors.white)),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 20.0),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
          child: Container(
            height: (size.height * 0.4) * (_products.length / 1.5),
            width: size.width * 0.5,
            child: GridView.count(
              crossAxisSpacing: 20.0,
              mainAxisSpacing: 20.0,
              crossAxisCount: 2,
              primary: false,
              children: List<Widget>.generate(
                _products.length,
                (index) => GestureDetector(
                  onTap: () => {_gotoDetails(index)},
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        border: Border.all(color: Color(0xFFEFF0F6))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Image.network(
                            (_products[index]['imgUrl']).toString(),
                          ),
                        ),
                        Column(children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 7.0),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 1.0),
                                  child: ColorIndicator(
                                      filter: _products[index]['color1']
                                          .toString()),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4.0),
                                  child: ColorIndicator(
                                      filter: _products[index]['color2']
                                          .toString()),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 1.0),
                                  child: ColorIndicator(
                                      filter: _products[index]['color3']
                                          .toString()),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(_products[index]['title'].toString(),
                                        style:
                                            headline2!.copyWith(fontSize: 12)),
                                    Text(
                                        '${_products[index]['price'].toString()} Руб',
                                        style:
                                            headline1!.copyWith(fontSize: 12)),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(3.0),
                                margin: const EdgeInsets.all(2.0),
                                decoration: BoxDecoration(
                                    color: Color(0xFFDADEFA),
                                    borderRadius: BorderRadius.circular(50.0)),
                                child: SvgPicture.asset(
                                  'assets/svg/heart.svg',
                                  color: Colors.white,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ],
                          )
                        ]),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
