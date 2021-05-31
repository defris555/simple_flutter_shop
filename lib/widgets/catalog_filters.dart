import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_storage/get_storage.dart';

import '../json/data.dart';

class CatalogFilters extends StatefulWidget {
  @override
  _CatalogFiltersState createState() => _CatalogFiltersState();
}

class _CatalogFiltersState extends State<CatalogFilters> {
  final GetStorage box = GetStorage();
  List<String> _categoriesList = [];
  late String _categoryValue;
  String? _priceValue;
  Color? _colorValue;
  TextStyle? headline2, bodyText1;

  void _createCategories() {
    for (int i = 0; i < categories.length; i++) {
      String category = (categories[i])["title"].toString();
      _categoriesList.add(category);
    }
  }

  @override
  void initState() {
    super.initState();
    box.write('color', 'none');
    box.write('price', 'none');
    _createCategories();
    if (!box.hasData('category')) {
      box.write('category', _categoriesList[0]);
      _categoryValue = _categoriesList[0];
    } else {
      _categoryValue = box.read('category');
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    headline2 = Theme.of(context).textTheme.headline2;
    bodyText1 = Theme.of(context).textTheme.bodyText1;
    return Row(
      children: [
        SizedBox(width: size.width * 0.07),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Opacity(
                  opacity: 0.4,
                  child: Text(
                    'Категории',
                    style: headline2,
                    textAlign: TextAlign.end,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Container(
                    width: size.width * 0.05,
                    height: size.width * 0.05,
                    child: Opacity(
                      opacity: 0.4,
                      child: SvgPicture.asset(
                        'assets/svg/dropdown.svg',
                        color: Color(0xFF181B32),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            DropdownButton<String>(
              onChanged: (var value) {
                box.write('category', value.toString());
                setState(() {
                  _categoryValue = value.toString();
                });
              },
              focusColor: Colors.white,
              value: _categoryValue,
              items: _categoriesList
                  .map<DropdownMenuItem<String>>((String? value) {
                return DropdownMenuItem(
                  value: value,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 5.0),
                    decoration: BoxDecoration(
                      color: Color(0xFFDADEFA),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Text(
                      value!,
                      style: bodyText1!.copyWith(color: Color(0xFF2A00A2)),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
        SizedBox(width: size.width * 0.1),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Opacity(
                  opacity: 0.4,
                  child: Text(
                    'Фильтр',
                    style: headline2,
                    textAlign: TextAlign.end,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Container(
                    width: size.width * 0.05,
                    height: size.width * 0.05,
                    child: Opacity(
                      opacity: 0.4,
                      child: SvgPicture.asset(
                        'assets/svg/filter.svg',
                        color: Color(0xFF181B32),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                DropdownButton<String>(
                  onChanged: (var value) {
                    box.write('price', value.toString());
                    setState(() {
                      _priceValue = value.toString();
                    });
                  },
                  focusColor: Colors.white,
                  value: _priceValue,
                  hint: Text(
                    'Стоимость',
                    style: bodyText1,
                  ),
                  items: <String>['Дешевле', 'Дороже']
                      .map<DropdownMenuItem<String>>((String? value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 5.0),
                        decoration: BoxDecoration(
                            color: Color(0xFFDADEFA),
                            borderRadius: BorderRadius.circular(20.0)),
                        child: Text(
                          value!,
                          style: bodyText1!.copyWith(color: Color(0xFF2A00A2)),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(width: size.width * 0.02),
                DropdownButton<Color>(
                  onChanged: (var value) {
                    if (value == Color(0xFF505C72)) {
                      box.write('color', 'black');
                    } else if (value == Color(0xFFE4B34C)) {
                      box.write('color', 'yellow');
                    } else if (value == Color(0xFF9A9E9F)) {
                      box.write('color', 'grey');
                    } else if (value == Color(0xFFB2A39D)) {
                      box.write('color', 'brown');
                    }
                    setState(() {
                      _colorValue = value;
                    });
                  },
                  focusColor: Colors.white,
                  value: _colorValue,
                  hint: Text(
                    'Цвет',
                    style: bodyText1,
                  ),
                  items: <Color>[
                    Color(0xFF505C72),
                    Color(0xFFE4B34C),
                    Color(0xFF9A9E9F),
                    Color(0xFFB2A39D),
                  ].map<DropdownMenuItem<Color>>((Color? value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Container(
                        width: size.width * 0.05,
                        height: size.width * 0.05,
                        color: value ?? Colors.white,
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
