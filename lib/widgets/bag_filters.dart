import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BagFilters extends StatefulWidget {
  @override
  _BagFiltersState createState() => _BagFiltersState();
}

class _BagFiltersState extends State<BagFilters> {
  late Size size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    final headline2 = Theme.of(context).textTheme.headline2;
    return Container(
      height: size.height * 0.1,
      width: size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: size.width * 0.05),
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/svg/checkbox_all.svg',
                  color: Colors.black,
                ),
                const SizedBox(width: 3.0),
                Text(
                  'Выбрать все',
                  style: headline2!.copyWith(fontSize: 12.0),
                ),
              ],
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              primary: Colors.white,
              shadowColor: Colors.transparent,
              onPrimary: Colors.white,
            ),
            onPressed: () {},
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/svg/trash.svg',
                  color: Colors.black,
                ),
                const SizedBox(width: 3.0),
                Text(
                  'Удалить выбранные',
                  style: headline2.copyWith(fontSize: 12.0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
