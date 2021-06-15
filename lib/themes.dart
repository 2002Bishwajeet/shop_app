import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:google_fonts/google_fonts.dart';

class ShopTheme {
  static ThemeData lightTheme(BuildContext context) => ThemeData(
      backgroundColor: HexColor("#DAEEF9"),
      fontFamily: GoogleFonts.lato().fontFamily,
      appBarTheme: AppBarTheme(
        elevation: 0,
        iconTheme: IconThemeData(color: HexColor("#332E38")),
      ),
      cardColor: creamcolor,
      buttonColor: HexColor("#0DD8E0"),
      iconTheme: IconThemeData(color: HexColor("#9EABBB")),
      primaryTextTheme: TextTheme(
        headline3:
            TextStyle(color: HexColor("#373B64"), fontWeight: FontWeight.bold),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: creamcolor,
        unselectedIconTheme: IconThemeData(color: HexColor("#9EABBB")),
        selectedIconTheme: IconThemeData(color: HexColor("#48BCD1")),
      ));

  static ThemeData darkTheme(BuildContext context) => ThemeData(
        backgroundColor: Color.fromRGBO(50, 46, 57, 1),
      );
  static Color creamcolor = Color(0xfff5f5f5);
  static Color formtextcolor = HexColor("#9EABBB");
  static Color headingColor = HexColor("#373B64");
  static Color titleColor = HexColor("#343C60");
  static Color iconColor = HexColor("#9EABBB");
  static Color glassColor = HexColor("#EFF8FC");
  static Color slidable = HexColor("#48BCD1");
  static LinearGradient bgcolor = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        HexColor("#ADDAEB"),
        HexColor("#55A9D9"),
      ]);
}
