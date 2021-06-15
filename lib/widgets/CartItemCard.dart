import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shop_app/Models/CartModel.dart';
import '../themes.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class CartItemCard extends StatelessWidget {
  final String id;
  final String prodId;
  final String title;
  final int amount;
  final String img;
  final int qty;
  const CartItemCard({
    Key key,
    @required this.prodId,
    @required this.id,
    @required this.title,
    @required this.amount,
    @required this.img,
    @required this.qty,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, left: 8, right: 8),
      child: Slidable(
        key: ValueKey(
            id), // Key is neccessary nhi toh pata kaise chlega konsa kon hai
        actionPane: SlidableScrollActionPane(),
        secondaryActions: [
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
            padding:
                const EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: IconSlideAction(
                color: ShopTheme.slidable.withOpacity(0.4),
                icon: LineIcons.trash,
                onTap: () {
                  Provider.of<Cart>(context, listen: false).removeItem(prodId);
                },
              ),
            ),
          ),
        ],
        child: Card(
          elevation: 3,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Text(
                        title,
                        softWrap: true,
                        overflow: TextOverflow.clip,
                        maxLines: 1,
                        style: Theme.of(context).textTheme.subtitle1.copyWith(
                            fontWeight: FontWeight.w600,
                            color: ShopTheme.headingColor),
                      ),
                    ),
                    SizedBox(height: 10),
                    RichText(
                      text: TextSpan(
                          text: "\$",
                          style: Theme.of(context).textTheme.headline6.copyWith(
                              color: Theme.of(context).buttonColor,
                              fontWeight: FontWeight.bold),
                          children: [
                            TextSpan(
                                text: amount.toString(),
                                style: TextStyle(
                                    color: ShopTheme.headingColor,
                                    fontWeight: FontWeight.bold))
                          ]),
                    ),
                    Container(
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              LineIcons.minus,
                              color: ShopTheme.formtextcolor,
                              size: 18,
                            ),
                            onPressed: () {
                              Provider.of<Cart>(context, listen: false)
                                  .removeSingleItem(prodId);
                            },
                            splashRadius: 5,
                          ),
                          Text(
                            qty.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1
                                .copyWith(
                                    color: ShopTheme.headingColor,
                                    fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                            onPressed: () {
                              Provider.of<Cart>(context, listen: false)
                                  .addSingleItem(prodId);
                            },
                            icon: Icon(
                              LineIcons.plus,
                              color: ShopTheme.formtextcolor,
                              size: 18,
                            ),
                            splashRadius: 5,
                          ),
                          SizedBox(width: 10),
                          /*   Text(
                            "|",
                            style: Theme.of(context)
                                .textTheme
                                .headline4!
                                .copyWith(
                                  color: ShopTheme.headingColor,
                                ),
                          ) */ // Not Needed Anymore Not Adding Size
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Image.network(
                    img,
                    fit: BoxFit.cover,
                    height: 100,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
