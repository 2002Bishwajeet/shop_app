import 'package:flutter/material.dart';
import 'package:shop_app/Pages/ManageProducts.dart';
import 'package:shop_app/Pages/OrderDetailsScreen.dart';
import 'package:shop_app/themes.dart';
import 'package:line_icons/line_icons.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
            margin: const EdgeInsets.only(top: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Hero(
                    tag: "DP",
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: NetworkImage(
                          "https://images.pexels.com/photos/4016173/pexels-photo-4016173.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940"),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Center(
                  child: Text(
                    "Helen Keler",
                    softWrap: true,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.headline3.copyWith(
                        color: ShopTheme.headingColor,
                        fontWeight: FontWeight.w900),
                  ),
                ),
                SizedBox(height: 10),
                Card(
                  margin: const EdgeInsets.all(12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  elevation: 5,
                  child: Column(
                    children: [
                      ListTile(
                        title: Text("Account Setting",
                            style: TextStyle(color: Colors.blueGrey)),
                        trailing: Icon(
                          LineIcons.angleRight,
                          color: Theme.of(context).buttonColor,
                        ),
                      ),
                      ListTile(
                        title: Text("Your Orders",
                            style: TextStyle(color: Colors.blueGrey)),
                        trailing: Icon(
                          LineIcons.angleRight,
                          color: Theme.of(context).buttonColor,
                        ),
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(OrderScreen.routename);
                        },
                      ),
                      ListTile(
                        title: Text("Language",
                            style: TextStyle(color: Colors.blueGrey)),
                        trailing: Icon(
                          LineIcons.angleRight,
                          color: Theme.of(context).buttonColor,
                        ),
                      ),
                      ListTile(
                        title: Text("Manage Products",
                            style: TextStyle(color: Colors.blueGrey)),
                        trailing: Icon(
                          LineIcons.angleRight,
                          color: Theme.of(context).buttonColor,
                        ),
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(ManageProducts.routename);
                        },
                      ),
                      ListTile(
                        title: Text("See What's Trending",
                            style: TextStyle(color: Colors.blueGrey)),
                        trailing: Icon(
                          LineIcons.angleRight,
                          color: Theme.of(context).buttonColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Card(
                  margin: const EdgeInsets.all(12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  elevation: 5,
                  child: Column(
                    children: [
                      ListTile(
                        title: Text("Customer Care",
                            style: TextStyle(color: Colors.blueGrey)),
                        trailing: Icon(
                          LineIcons.angleRight,
                          color: Theme.of(context).buttonColor,
                        ),
                      ),
                      ListTile(
                        title: Text("Privacy Policy",
                            style: TextStyle(color: Colors.blueGrey)),
                        trailing: Icon(
                          LineIcons.angleRight,
                          color: Theme.of(context).buttonColor,
                        ),
                      ),
                      ListTile(
                        title: Text("Terms and Conditions",
                            style: TextStyle(color: Colors.blueGrey)),
                        trailing: Icon(
                          LineIcons.angleRight,
                          color: Theme.of(context).buttonColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
