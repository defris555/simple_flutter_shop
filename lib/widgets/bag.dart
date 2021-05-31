import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_storage/get_storage.dart';

class Bag extends StatefulWidget {
  @override
  _BagState createState() => _BagState();
}

class _BagState extends State<Bag> {
  final GetStorage box = GetStorage();
  TextStyle? headline1, headline2, headline3, bodyText1;
  late Size size;
  int _invoice = 0;
  int _allProductsSum = 0;
  late List _bagList, _distinctList;
  Map<String, int> counts = {};
  bool _checkBox = true;

  filteredBagList() {
    box.hasData('bag') ? _bagList = box.read('bag') : _bagList = [];
    print(_bagList);
    _bagList.forEach((product) {
      _invoice = _invoice + int.parse(product['price'].toString());
      final title = product['title'].toString();
      if (counts.containsKey(title)) {
        counts.update(title, (value) => value + 1);
        print(title + counts['title'].toString());
      } else {
        counts[title] = 1;
      }
      _allProductsSum++;
    });
    _distinctList = _bagList.toSet().toList();
  }

  @override
  void initState() {
    super.initState();
    filteredBagList();
    print(_invoice);
    print(_bagList.length);
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    headline1 = Theme.of(context).textTheme.headline1;
    headline2 = Theme.of(context).textTheme.headline2;
    headline3 = Theme.of(context).textTheme.headline3;
    bodyText1 = Theme.of(context).textTheme.bodyText1;
    return _bagList.isEmpty
        ? Center(child: Text('В корзине пока пусто'))
        : Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                child: Text(
                  'В корзине $_allProductsSum товаров, на сумму $_invoice Руб',
                  style: headline2!.copyWith(fontSize: 12.0),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: size.height * 0.03),
                child: ListView.builder(
                  itemCount: _distinctList.length,
                  itemBuilder: (context, index) {
                    final title = _distinctList[index]['title'];
                    return Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.05, vertical: 10.0),
                      child: Container(
                        width: size.width,
                        height: size.height / 4,
                        child: Row(
                          children: [
                            Container(
                              width: size.width / 2,
                              height: size.height / 4,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Stack(
                                        children: [
                                          DecoratedBox(
                                            decoration: BoxDecoration(
                                                border: Border.all()),
                                            child: Opacity(
                                              opacity: _checkBox ? 1.0 : 0.0,
                                              child: SvgPicture.asset(
                                                'assets/svg/checkbox.svg',
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: size.width * 0.05),
                                        child: Text(
                                          _bagList[index]['title'].toString(),
                                          style: headline2,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: size.width * 0.1),
                                    child: Text(
                                      _bagList[index]['color1'].toString(),
                                      style: headline2!
                                          .copyWith(color: Color(0xFFBBBBBB)),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(top: size.width * 0.05),
                                    child: Text(
                                      _bagList[index]['price'].toString() +
                                          ' Руб',
                                      style: headline2!.copyWith(
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      IconButton(
                                        icon: Icon(Icons.remove),
                                        onPressed: () {
                                          if (counts[title]! > 1) {
                                            counts.update(
                                                title, (value) => value - 1);
                                            _invoice = _invoice -
                                                int.parse(
                                                    _bagList[index]['price']);
                                            _allProductsSum--;
                                          } else {
                                            counts.update(
                                                title, (value) => value - 1);
                                            _invoice = _invoice -
                                                int.parse(
                                                    _bagList[index]['price']);
                                            _allProductsSum--;
                                            _bagList.removeWhere((item) =>
                                                item['title'] == title);
                                            _distinctList =
                                                _bagList.toSet().toList();
                                          }
                                          setState(() {});
                                        },
                                        color: Colors.green,
                                      ),
                                      Text(counts[title].toString()),
                                      IconButton(
                                        icon: Icon(Icons.add),
                                        color: Colors.green,
                                        onPressed: () {
                                          counts.update(
                                              title, (value) => value + 1);
                                          _invoice = _invoice +
                                              int.parse(
                                                  _bagList[index]['price']);
                                          _allProductsSum++;

                                          setState(() {});
                                        },
                                      ),
                                      SvgPicture.asset('assets/svg/trash.svg')
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Container(
                              width: size.width / 2.5,
                              height: size.height / 5,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: Image.network(
                                  _bagList[index]['imgUrl'].toString(),
                                  fit: BoxFit.cover,
                                ).image),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
  }
}
