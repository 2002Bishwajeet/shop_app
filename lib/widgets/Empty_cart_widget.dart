import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../themes.dart';

class EmptyCartWidget extends StatelessWidget {
  const EmptyCartWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FittedBox(child: SvgPicture.asset("assets/images/empty_cart.svg")),
          Spacer(),
          Container(
            child: Text(
              "Looks Empty, Try Adding Some",
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  .copyWith(color: ShopTheme.headingColor),
            ),
          ),
          Spacer(),
        ],
      )),
    );
  }
}
