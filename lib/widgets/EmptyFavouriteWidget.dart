import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../themes.dart';

class EmptyFavWidget extends StatelessWidget {
  const EmptyFavWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height:
            MediaQuery.of(context).size.height - AppBar().preferredSize.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(),
            FittedBox(
                fit: BoxFit.contain,
                child: SvgPicture.asset("assets/images/LikeDislike.svg")),
            Spacer(),
            Text(
              "No Favorites for now",
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  .copyWith(color: ShopTheme.headingColor),
            ),
            Spacer(),
          ],
        ));
  }
}
