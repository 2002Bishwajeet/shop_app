import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class UserProdItem extends StatelessWidget {
  static const routename = "/UserProdItem";

  final String title;
  final String img;

  const UserProdItem({Key key, this.title, this.img}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(title);
    return ListTile(
      title: Text(
        title,
        softWrap: true,
      ),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(img),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(onPressed: () {}, icon: Icon(LineIcons.pen)),
            IconButton(onPressed: () {}, icon: Icon(LineIcons.trash)),
          ],
        ),
      ),
    );
  }
}
