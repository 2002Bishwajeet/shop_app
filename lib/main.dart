import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/Models/CartModel.dart';
import 'package:shop_app/Models/OrderModel.dart';
import 'package:shop_app/Pages/Edit_Product_screen.dart';
import 'package:shop_app/Pages/ManageProducts.dart';
import 'package:shop_app/Pages/OrderDetailsScreen.dart';
import 'package:shop_app/Pages/Shoe_details_page.dart';
import 'package:shop_app/Pages/homepage.dart';
import 'package:shop_app/Pages/signIn.dart';
import 'package:shop_app/Screens/cart_screen.dart';
import 'package:shop_app/providers/auth.dart';
import 'package:shop_app/providers/shoes_provider.dart';
import 'package:shop_app/themes.dart';

void main() {
  runApp(ShopApp());
}

class ShopApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Shoes>(
          //It's an efficient method don't use .value one
          create: (ctx) => Shoes(),
          update: (_, auth, previousProduct) {
            previousProduct..auth = auth;
            previousProduct..userID = auth.userId;
            return previousProduct;
          },
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Order>(
          create: (ctx) => Order(),
          update: (ctx, auth, prevShoe) => prevShoe..auth = auth,
        )
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: "Shop App",
          theme: ShopTheme.lightTheme(context),
          darkTheme: ShopTheme.darkTheme(context),
          debugShowCheckedModeBanner: false,
          debugShowMaterialGrid: false,
          home: auth.isAuth ? HomePage() : SignIn(),
          themeMode: ThemeMode.light,
          routes: {
            ShoeDetailScreen.routname: (ctx) => ShoeDetailScreen(),
            CartScreen.routename: (ctx) => CartScreen(),
            OrderScreen.routename: (ctx) => OrderScreen(),
            ManageProducts.routename: (ctx) => ManageProducts(),
            EditProductScreen.routename: (ctx) => EditProductScreen(),
            SignIn.routename: (ctx) => SignIn(),
          },
        ),
      ),
    );
  }
}
