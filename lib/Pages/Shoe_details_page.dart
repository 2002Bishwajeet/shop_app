import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/Models/CartModel.dart';
import 'package:shop_app/Screens/profile_screen.dart';
import 'package:shop_app/providers/auth.dart';
import 'package:shop_app/providers/shoes_provider.dart';
import 'package:shop_app/themes.dart';

class ShoeDetailScreen extends StatefulWidget {
  static const routname = '/Details';

  @override
  _ShoeDetailScreenState createState() => _ShoeDetailScreenState();
}

class _ShoeDetailScreenState extends State<ShoeDetailScreen> {
  Widget price(String text, String price, BuildContext context) {
    return Container(
      child: Row(
        children: [
          Icon(
            LineIcons.angleRight,
            color: Theme.of(context).buttonColor,
            size: 20,
          ),
          SizedBox(width: 5),
          RichText(
            text: TextSpan(
                text: text,
                style: Theme.of(context).textTheme.subtitle2.copyWith(
                    color: ShopTheme.headingColor, fontWeight: FontWeight.w600),
                children: [
                  TextSpan(
                    text: "\$ ",
                    style: Theme.of(context).textTheme.headline6.copyWith(
                        color: Theme.of(context).buttonColor,
                        fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                      text: price,
                      style: TextStyle(
                          color: ShopTheme.headingColor,
                          fontWeight: FontWeight.bold))
                ]),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String;
    final loadedProduct = Provider.of<Shoes>(context, listen: false).findbyId(
        productId); //Listen false isliye kiya kyonki mereko widget rebuild nhi karwana
    final cart = Provider.of<Cart>(context, listen: false);
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).backgroundColor,
          leading: InkWell(
            onTap: () {
              Navigator.of(context).pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Theme.of(context).buttonColor,
                child: Icon(
                  LineIcons.angleLeft,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          actions: [
            Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
                child: InkWell(
                  onTap: () {
                    //TODO: Need To Implement Better Routing
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Scaffold(body: ProfileScreen())));
                  },
                  child: Hero(
                    tag: "DP",
                    child: CircleAvatar(
                      backgroundColor: Theme.of(context).buttonColor,
                      backgroundImage: NetworkImage(
                          "https://images.pexels.com/photos/4016173/pexels-photo-4016173.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940"),
                      radius: 20,
                    ),
                  ),
                )),
          ],
        ),
        body: Container(
            child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    loadedProduct.brand,
                    softWrap: true,
                    style: Theme.of(context).textTheme.headline6.copyWith(
                        color: ShopTheme.titleColor,
                        fontWeight: FontWeight.w500),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 8, top: 8),
                    child: Text(
                      loadedProduct.title,
                      softWrap: true,
                      maxLines: 2,
                      overflow: TextOverflow.clip,
                      style: Theme.of(context).textTheme.headline4.copyWith(
                          color: ShopTheme.titleColor,
                          fontWeight: FontWeight.w900),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                    child: Text(
                      loadedProduct.subtitle,
                      softWrap: true,
                      overflow: TextOverflow.clip,
                      style: Theme.of(context).textTheme.subtitle1.copyWith(
                          color: Colors.blueGrey, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        Text(
                          " 1 / 7",
                          style: Theme.of(context).textTheme.headline5.copyWith(
                              color: ShopTheme.headingColor,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 20),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                loadedProduct.toggleFavorite(
                                    Provider.of<Auth>(context, listen: false)
                                        .token,
                                    Provider.of<Auth>(context, listen: false)
                                        .userId);
                              });
                            },
                            icon: Icon(loadedProduct.isFavorite
                                ? LineIcons.heartAlt
                                : LineIcons.heart),
                            color: loadedProduct.isFavorite
                                ? Colors.red.shade900
                                : ShopTheme.iconColor),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.22,
                    width: double.infinity,
                    child: Hero(
                      tag: loadedProduct.id,
                      child: Image.network(
                        loadedProduct.img,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(35),
                        topLeft: Radius.circular(35))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Description",
                      style: Theme.of(context).textTheme.headline6.copyWith(
                          color: ShopTheme.titleColor,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      loadedProduct.description,
                      softWrap: true,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1
                          .copyWith(color: Colors.blueGrey),
                    ),
                    SizedBox(height: 10),
                    price("Retail Price  ", "${loadedProduct.amount}", context),
                    SizedBox(height: 10),
                    price(
                        "Est. Resell Price   ",
                        "${loadedProduct.amount + 25} - ${loadedProduct.amount + 100} ",
                        context),
                    SizedBox(height: 10),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Theme.of(context).buttonColor),
                                padding: MaterialStateProperty.all(
                                    EdgeInsets.all(16))),
                            onPressed: () {
                              print(loadedProduct.id);
                              cart.addItem(
                                  loadedProduct.id,
                                  loadedProduct.amount,
                                  loadedProduct.title,
                                  loadedProduct.img);
                              //khaali Scaffold.showsnacbbar kaam nhi karta
                              // That's depreceated and does not work anymore
                              ScaffoldMessenger.of(context)
                                  .hideCurrentSnackBar();
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text("Added to Bag"),
                                action: SnackBarAction(
                                  onPressed: () {
                                    cart.removeSingleItem(productId);
                                  },
                                  label: "Undo",
                                ),
                              ));
                            },
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Add To Bag",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        .copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(width: 20),
                                  Icon(
                                    LineIcons.shoppingBag,
                                    size: 28,
                                  )
                                ],
                              ),
                            )),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        )));
  }
}
