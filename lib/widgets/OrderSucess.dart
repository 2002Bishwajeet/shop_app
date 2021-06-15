import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../themes.dart';

class OrderSucess extends StatefulWidget {
  const OrderSucess({
    Key key,
  }) : super(key: key);

  @override
  _OrderSucessState createState() => _OrderSucessState();
}

class _OrderSucessState extends State<OrderSucess> {
  bool _isLoading = true;

  @override
  void initState() {
    fakeLoad();
    super.initState();
  }

  void fakeLoad() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(
            child: CircularProgressIndicator.adaptive(),
          )
        : Container(
            padding: const EdgeInsets.only(top: 28),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    margin: const EdgeInsets.all(24),
                    child: FittedBox(
                        child: SvgPicture.asset("assets/images/success.svg"))),
                SizedBox(height: 20),
                Container(
                  child: Text(
                    "Your Order is Confirmed",
                    style: Theme.of(context).textTheme.headline5.copyWith(
                        color: ShopTheme.headingColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  ),
                ),
                Spacer(),
              ],
            ));
  }
}
