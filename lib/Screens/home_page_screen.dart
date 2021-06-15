import 'package:flutter/material.dart';
import 'package:shop_app/Models/ShoesModel.dart';
import 'package:shop_app/providers/shoes_provider.dart';
import 'package:shop_app/themes.dart';
import 'package:line_icons/line_icons.dart';
import 'dart:math' as math;
import 'package:shop_app/widgets/BrandNameType.dart';
import 'package:shop_app/widgets/ItemCard.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomePageScreen extends StatelessWidget {
  Widget searchBar(String text, BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: ShopTheme.creamcolor,
      ),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              autocorrect: true,
              autofocus: false,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: "Find Shoes",
                hintStyle: TextStyle(color: ShopTheme.formtextcolor),
                contentPadding: const EdgeInsets.all(8),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
            ),
          ),
          CircleAvatar(
            backgroundColor: Theme.of(context).buttonColor,
            child: IconButton(
              onPressed: () {},
              icon: Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationY(math.pi),
                child: Icon(
                  LineIcons.search,
                  color: ShopTheme.creamcolor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        searchBar("Find Shoes", context),
        SizedBox(height: 20),
        Padding(
            padding: const EdgeInsets.only(left: 24),
            child: Text(
              "Categories",
              style: Theme.of(context).primaryTextTheme.headline3,
            )),
        Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.09,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView.builder(
              itemBuilder: (context, index) => BrandTypeWidget(
                text: company[index],
              ),
              itemCount: company.length,
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
            ),
          ),
        ),
        GridShoesWidget()
      ],
    ));
  }
}

class GridShoesWidget extends StatefulWidget {
  @override
  _GridShoesWidgetState createState() => _GridShoesWidgetState();
}

class _GridShoesWidgetState extends State<GridShoesWidget> {
  RefreshController _refreshController = RefreshController();

  Future _refreshShoeList(BuildContext context) async {
    await Provider.of<Shoes>(context, listen: false).fetchShoes();
   // setState(() {});
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    final shoeData = Provider.of<Shoes>(context);
    final shoes = shoeData.items;
    return Expanded(
      child: SmartRefresher(
        onRefresh: () {
          _refreshShoeList(context);
        },
        physics: BouncingScrollPhysics(),
        controller: _refreshController,
        header: WaterDropMaterialHeader(
          backgroundColor: Colors.blue[100],
          color: ShopTheme.headingColor,
        ),
        enablePullDown: true,
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisExtent: 260,
          ),
          shrinkWrap: true,
          itemCount: shoes.length,
          physics: BouncingScrollPhysics(),
          itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
            // yaha pe value use kario kyonki pichla waala jo khaali tha which take create
            // usme widget recycle hote hai mtlb data changes but widget ka structure does not
            // isme data sticked to widget so everything rebuilds without disposing it
            // recomendded for list and grid view jisme scrolling ho
            value: shoes[i],
            //create: (c) => shoes[i] ,
            child: ItemCard(
                // id: shoes[i].id,
                // amount: shoes[i].amount,
                // img: shoes[i].img,
                // title: shoes[i].title
                ),
          ),
        ),
      ),
    );
  }
}
