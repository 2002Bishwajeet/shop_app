import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/Models/OrderModel.dart';
import 'package:shop_app/widgets/OrderItemCard.dart';
import '../themes.dart';
import 'package:line_icons/line_icons.dart';

class OrderScreen extends StatelessWidget {
  static const routename = "/Yourorders";

 
  // bool _isLoading = false;
  // @override
  // void initState() {
  //   // Future.delayed(Duration.zero).then((_) {
  //   // });
  //   // _isLoading = true;
  //   // Provider.of<Order>(context, listen: false).fetchOrder().then((value) {
  //   //   setState(() {
  //   //     _isLoading = false;
  //   //   });
  //   // });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    // final orderdata = Provider.of<Order>(context);
    print("Building Method");
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).backgroundColor,
          // backgroundColor: Colors.transparent,
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
              padding: const EdgeInsets.fromLTRB(0, 4, 16, 0),
              child: CircleAvatar(
                backgroundColor: Theme.of(context).buttonColor,
                radius: 20,
                backgroundImage: NetworkImage(
                    "https://images.pexels.com/photos/4016173/pexels-photo-4016173.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940"),
              ),
            ),
          ],
        ),
        body: FutureBuilder(
          future: Provider.of<Order>(context, listen: false).fetchOrder(),
          builder: (ctx, datasnapshot) {
            if (datasnapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (datasnapshot.error != null) {
              //Do Error Handling Stuff
              return Center(
                child: Text("Error Occured"),
              );
            } else
              return Container(
                height: MediaQuery.of(context).size.height -
                    AppBar().preferredSize.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text("Your Orders",
                          style: Theme.of(context).textTheme.headline3.copyWith(
                              color: ShopTheme.headingColor,
                              fontWeight: FontWeight.bold)),
                    ),
                    Expanded(
                      child: Consumer<Order>(
                        builder: (ctxx, orderdata, child) => ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount: orderdata.orders.length,
                          itemBuilder: (ctx, i) =>
                              OrderItemCard(order: orderdata.orders[i]),
                        ),
                      ),
                    ),
                  ],
                ),
              );
          },
        ));
  }
}
