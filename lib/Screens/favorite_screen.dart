import 'package:flutter/material.dart';
import 'package:shop_app/Models/ShoesModel.dart';
import 'package:shop_app/providers/shoes_provider.dart';
import 'package:shop_app/themes.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/widgets/EmptyFavouriteWidget.dart';
import 'package:shop_app/widgets/FavoriteCard.dart';


class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final shoeData = Provider.of<Shoes>(context);
    final shoes = shoeData.favorite;
    return shoes.isEmpty
        ? EmptyFavWidget()
        : Container(
            height: MediaQuery.of(context).size.height -
                AppBar().preferredSize.height,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text("Favourites",
                      style: Theme.of(context).textTheme.headline3.copyWith(
                          color: ShopTheme.headingColor,
                          fontWeight: FontWeight.bold)),
                ),
                FavGridWidget(shoes: shoes)
              ],
            ));
  }
}



class FavGridWidget extends StatelessWidget {
  const FavGridWidget({
    Key key,
    @required this.shoes,
  }) : super(key: key);

  final List<ShoesDetails> shoes;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            mainAxisExtent: 260,
          ),
          itemCount: shoes.length,
          physics: BouncingScrollPhysics(),
          itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                value: shoes[i],
                child: FavCard(),
              )),
    );
  }
}
