import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/Pages/Edit_Product_screen.dart';
import 'package:shop_app/providers/shoes_provider.dart';
import 'package:shop_app/themes.dart';
import 'package:shop_app/widgets/user_prod_item.dart';

class ManageProducts extends StatelessWidget {
  static const routename = "/manageproducts";
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Shoes>(context);
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
              child: CircleAvatar(
                backgroundColor: Theme.of(context).buttonColor,
                backgroundImage: NetworkImage(
                    "https://images.pexels.com/photos/4016173/pexels-photo-4016173.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940"),
                radius: 20,
              )),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Manage Products",
                style: Theme.of(context).textTheme.headline3.copyWith(
                    color: ShopTheme.headingColor, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: productsData.items.length,
                itemBuilder: (ctx, i) => UserProdItem(
                  title: productsData.items[i].title,
                  img: productsData.items[i].img,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(EditProductScreen.routename);
                  },
                  child: Text(
                    "Add New Product",
                    softWrap: true,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        .copyWith(color: Colors.white),
                  ),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).buttonColor),
                      //   elevation: MaterialStateProperty.all(5),
                      padding: MaterialStateProperty.all(EdgeInsets.all(24)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)))),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
