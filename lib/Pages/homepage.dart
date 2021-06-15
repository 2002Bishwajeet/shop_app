import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shop_app/Models/CartModel.dart';
import 'package:shop_app/Screens/cart_screen.dart';
import 'package:shop_app/Screens/favorite_screen.dart';
import 'package:shop_app/Screens/home_page_screen.dart';
import 'package:shop_app/Screens/profile_screen.dart';
import 'package:badges/badges.dart';
import 'package:shop_app/providers/shoes_provider.dart';
import 'package:shop_app/themes.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  bool _isLoading = true;
  final List<Widget> screen = [
    HomePageScreen(),
    FavoriteScreen(),
    CartScreen(),
    ProfileScreen()
  ];
  bool isInit = true;
  @override
  void initState() {
    // Provider.of<Shoes>(context).fetchShoes(); THIS WON't WORK IN INIT STATE BUT listen false ho toh kaam kar jae
    // Future.delayed(Duration.zero).then((_) {
    //   Provider.of<Shoes>(context).fetchShoes();
    // });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (isInit) {
      setState(() {
        _isLoading = true;
      });

      Provider.of<Shoes>(context).fetchShoes().then((value) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      // backgroundColor: Colors.transparent,
      appBar: _currentIndex != 3
          ? AppBar(
              elevation: 0,
              backgroundColor: Theme.of(context).backgroundColor,
              // backgroundColor: Colors.transparent,
              leading: IconButton(
                onPressed: () {},
                icon: Icon(Icons.sort),
                splashRadius: 5,
                iconSize: 32,
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 4, 16, 0),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _currentIndex = 3;
                      });
                    },
                    child: Hero(
                      tag: 'DP',
                      child: CircleAvatar(
                        backgroundColor: Theme.of(context).buttonColor,
                        radius: 20,
                        backgroundImage: NetworkImage(
                            "https://images.pexels.com/photos/4016173/pexels-photo-4016173.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940"),
                      ),
                    ),
                  ),
                ),
              ],
            )
          : null,
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : screen[_currentIndex],
      bottomNavigationBar: Container(
        height: MediaQuery.of(context).size.height * 0.09,
        child: ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25)),
          child: BottomNavigationBar(
            showSelectedLabels: false,
            showUnselectedLabels: false,
            elevation: 16,
            currentIndex: _currentIndex,
            type: BottomNavigationBarType.fixed,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
              // BottomNavigationBarItem(
              //     icon: Icon(LineIcons.comment), label: ""),
              BottomNavigationBarItem(icon: Icon(LineIcons.heart), label: ""),
              BottomNavigationBarItem(
                  icon: Consumer<Cart>(
                    builder: (_, ca, i) => Badge(
                      child: Icon(LineIcons.shoppingBag),
                      badgeColor: Theme.of(context).buttonColor,
                      showBadge: ca.itemCount == 0 || _currentIndex == 2
                          ? false
                          : true,
                      badgeContent: Text(
                        ca.qtyCount.toString(),
                        style: TextStyle(color: ShopTheme.headingColor),
                      ),
                    ),
                    //child:
                  ),
                  label: ""),
              BottomNavigationBarItem(icon: Icon(LineIcons.user), label: ""),
            ],
          ),
        ),
      ),
    );
  }
}
