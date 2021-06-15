import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
class BrandTypeWidget extends StatelessWidget {
  final String text;
  const BrandTypeWidget({
    Key key,
    @required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        softWrap: true,
        style: Theme.of(context)
            .textTheme
            .subtitle1
            .copyWith(color: HexColor("#98A2AE")),
      ),
    );
  }
}
