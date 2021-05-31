import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:test_catalog/screens/bagScreen.dart';

class Details extends StatefulWidget {
  final Map<String, Object>? productMap;

  Details({required this.productMap});
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  final GetStorage box = GetStorage();
  TextStyle? headline1, headline2, headline3, bodyText1;
  String? title, description, price, imgUrl;
  late Size size;
  late int _invoice;
  late List _bagList;

  @override
  void initState() {
    super.initState();
    box.hasData('invoice') ? _invoice = box.read('invoice') : _invoice = 0;
    box.hasData('bag') ? _bagList = box.read('bag') : _bagList = [];
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    headline1 = Theme.of(context).textTheme.headline1;
    headline2 = Theme.of(context).textTheme.headline2;
    headline3 = Theme.of(context).textTheme.headline3;
    bodyText1 = Theme.of(context).textTheme.bodyText1;
    description = widget.productMap!['description'].toString();
    imgUrl = widget.productMap!['imgUrl'].toString();
    price = widget.productMap!['price'].toString();
    title = widget.productMap!['title'].toString();
    return Scaffold(
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
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: size.width * 0.9,
              height: size.height * 0.5,
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xFFEFF0F6)),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(),
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
                    ),
                  ),
                  Image.network(imgUrl!),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title!, style: headline2!.copyWith(fontSize: 20.0)),
                  Text('$price Руб', style: headline1),
                ],
              ),
            ),
            Row(
              children: [
                Text(
                  'Описание',
                  style: headline2!.copyWith(color: Color(0xFF6376E9)),
                ),
                const SizedBox(width: 10.0),
                Text(
                  'Отзывы',
                  style: headline2!.copyWith(color: Color(0xFFA0A3BD)),
                ),
                const SizedBox(width: 10.0),
                Text(
                  'Доставка',
                  style: headline2!.copyWith(color: Color(0xFFA0A3BD)),
                ),
              ],
            ),
            Stack(
              children: [
                Divider(
                  thickness: 2.0,
                  endIndent: size.width * 0.2,
                  height: size.height * 0.03,
                  color: Color(0xFFA0A3BD),
                ),
                Divider(
                  thickness: 2.0,
                  endIndent: size.width * 0.677,
                  height: size.height * 0.03,
                  color: Color(0xFF6376E9),
                ),
              ],
            ),
            Text(
              description!,
              style: headline2,
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.all(size.height * 0.03),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            primary: Colors.white,
            shadowColor: Colors.transparent,
            onPrimary: Colors.white,
          ),
          onPressed: () {
            _bagList.add(widget.productMap!);
            box.write('invoice', _invoice);
            box.write('bag', _bagList);
            Get.to(BagScreen());
          },
          child: Container(
            width: size.width,
            height: size.height * 0.07,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              color: Color(0xFF6376E9),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Добавить',
                    style: headline2!.copyWith(color: Colors.white)),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: SvgPicture.asset(
                    'assets/svg/bag.svg',
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
