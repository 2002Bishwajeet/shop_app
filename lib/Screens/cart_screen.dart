import 'dart:ui';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/Models/CartModel.dart';
import 'package:shop_app/Models/OrderModel.dart';
import 'package:shop_app/themes.dart';
import 'package:shop_app/widgets/CartItemCard.dart';
import 'package:shop_app/widgets/Empty_cart_widget.dart';
import 'package:shop_app/widgets/OrderSucess.dart';

class CartScreen extends StatefulWidget {
  static const routename = "/cart";

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool _isPurchased = false;

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return _isPurchased
        ? OrderSucess()
        : Container(
            padding: const EdgeInsets.only(top: 16, bottom: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text("My Bag",
                      softWrap: true,
                      style: Theme.of(context).textTheme.headline3.copyWith(
                          color: ShopTheme.headingColor,
                          fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 16),
                  child: Text("Check and Pay Your Shoes",
                      softWrap: true,
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          .copyWith(color: Colors.blueGrey)),
                ),
                // CartItemCard(),
                cart.items.values.isEmpty
                    ? EmptyCartWidget()
                    : Expanded(
                        child: Column(
                          children: [
                            Expanded(
                                child: ListView.builder(
                              physics: BouncingScrollPhysics(),
                              itemCount: cart.itemCount,
                              itemBuilder: (context, i) => CartItemCard(
                                  prodId: cart.items.keys.toList()[i],
                                  id: cart.items.values.toList()[i].id,
                                  title: cart.items.values.toList()[i].title,
                                  amount: cart.items.values.toList()[i].price,
                                  img: cart.items.values.toList()[i].img,
                                  qty: cart.items.values.toList()[i].quantity),
                            )),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 14.0, left: 8, right: 8),
                              child: ClipRRect(
                                child: Card(
                                  color: ShopTheme.glassColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${cart.itemCount} Item",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6
                                              .copyWith(color: Colors.blueGrey),
                                        ),
                                        RichText(
                                          text: TextSpan(
                                              text: "\$",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline6
                                                  .copyWith(
                                                      color: Theme.of(context)
                                                          .buttonColor,
                                                      fontWeight:
                                                          FontWeight.bold),
                                              children: [
                                                TextSpan(
                                                    text:
                                                        "${cart.totalAmount.toStringAsFixed(2)}",
                                                    style: TextStyle(
                                                        color: ShopTheme
                                                            .headingColor,
                                                        fontWeight:
                                                            FontWeight.bold))
                                              ]),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 8.0, top: 16.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(25),
                                  child: ElevatedButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Theme.of(context)
                                                      .buttonColor),
                                          fixedSize: MaterialStateProperty.all(
                                              Size.fromWidth(
                                                  MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.5)),
                                          padding: MaterialStateProperty.all(
                                              EdgeInsets.all(16))),
                                      onPressed: () {
                                        Provider.of<Order>(context,
                                                listen: false)
                                            .addOrder(
                                                cart.items.values.toList(),
                                                cart.totalAmount);
                                        cart.clearCart();
                                        setState(() {
                                          _isPurchased = true;
                                        });
                                      },
                                      child: Center(
                                        child: Text(
                                          "Checkout",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5
                                              .copyWith(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w900),
                                        ),
                                      )),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
              ],
            ),
          );
  }
}
