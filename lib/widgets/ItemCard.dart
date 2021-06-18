import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shop_app/Models/ShoesModel.dart';
import 'package:shop_app/Pages/Shoe_details_page.dart';
import 'package:shop_app/providers/auth.dart';
import 'package:shop_app/themes.dart';
import 'package:provider/provider.dart';

class ItemCard extends StatelessWidget {
  // final String id;
  // final double amount;
  // final String img;
  // final String title;
  // ItemCard({
  //   Key? key,
  //   required this.id,
  //   required this.amount,
  //   required this.img,
  //   required this.title,
  // }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context, listen: false);
    // final shoe = Provider.of<ShoesDetails>(context); -> isme har baar build call hoga jab data change
    // ya toh upar waala kar ya consumer se wrap kar de
    return Consumer<ShoesDetails>(
      builder: (ctx, shoe, _) => InkWell(
        borderRadius: BorderRadius.circular(25),
        onTap: () {
          Navigator.of(context).pushNamed(
            ShoeDetailScreen.routname,
            arguments: shoe.id,
          );
        },
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          margin: const EdgeInsets.all(8),
          color: Colors.white,
          elevation: 5,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 12, right: 12, top: 8),
                child: Row(
                  children: [
                    RichText(
                      text: TextSpan(
                          text: "\$",
                          style: Theme.of(context).textTheme.headline6.copyWith(
                              color: Theme.of(context).buttonColor,
                              fontWeight: FontWeight.bold),
                          children: [
                            TextSpan(
                                text: "${shoe.amount}",
                                style: TextStyle(
                                    color: ShopTheme.headingColor,
                                    fontWeight: FontWeight.bold))
                          ]),
                    ),
                    // Text("\$$amount"),
                    Spacer(),
                    IconButton(
                      onPressed: () {
                        shoe.toggleFavorite(auth.token, auth.userId);
                      },
                      icon: Icon(shoe.isFavorite
                          ? LineIcons.heartAlt
                          : LineIcons.heart),
                      color: shoe.isFavorite
                          ? Colors.red.shade900
                          : ShopTheme.iconColor,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Hero(
                  tag: shoe.id,
                  child: Image.network(
                    shoe.img,
                    fit: BoxFit.fitWidth,
                    width: double.infinity,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  shoe.title,
                  style: Theme.of(context).textTheme.subtitle1.copyWith(
                      color: ShopTheme.headingColor,
                      fontWeight: FontWeight.w600),
                  softWrap: true,
                  overflow: TextOverflow.clip,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
