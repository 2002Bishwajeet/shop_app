import 'package:flutter/cupertino.dart';
import 'package:shop_app/Models/ShoesModel.dart';
import 'package:http/http.dart' as http; //to avoid name clashes
import 'dart:convert';

import 'auth.dart';

class Shoes with ChangeNotifier {
  List<ShoesDetails> _item = [
    // ShoesDetails(
    //     id: "1",
    //     amount: 180,
    //     img:
    //         "https://images-na.ssl-images-amazon.com/images/I/612CjsFEg-L._UL1500_.jpg",
    //     title: "CLYMB Outdoor Sports Running Shoes",
    //     isFavorite: false,
    //     brand: "CLYMB",
    //     description:
    //         "Murmured token napping said ever heart beak of and be this. Visiter perched pallas the soul at by, i bust.",
    //     subtitle: "Men's Shoe"),
    // ShoesDetails(
    //   id: "2",
    //   amount: 195,
    //   img:
    //       "https://images-na.ssl-images-amazon.com/images/I/71jF806zFdL._UL1500_.jpg",
    //   title: "Kraasa Men's Running Shoe",
    //   isFavorite: false,
    //   brand: "Kraasa",
    //   description:
    //       "Murmured token napping said ever heart beak of and be this. Visiter perched pallas the soul at by, i bust.",
    //   subtitle: "Men's Shoe",
    // ),
    // ShoesDetails(
    //     id: "3",
    //     brand: "Sparx",
    //     amount: 150,
    //     img:
    //         "https://images-na.ssl-images-amazon.com/images/I/81n7l8KAS6L._UL1500_.jpg",
    //     title: "Sparx Men's Running Shoes",
    //     isFavorite: false,
    //     description:
    //         "Murmured token napping said ever heart beak of and be this. Visiter perched pallas the soul at by, i bust.",
    //     subtitle: "Men's Shoe"),
    // ShoesDetails(
    //     id: "4",
    //     brand: "ASIAN",
    //     amount: 250,
    //     img:
    //         "https://images-na.ssl-images-amazon.com/images/I/61-A7XWdpCL._UL1100_.jpg",
    //     title: "ASIAN Men's Bouncer-01 Sports   ",
    //     isFavorite: false,
    //     description:
    //         "Murmured token napping said ever heart beak of and be this. Visiter perched pallas the soul at by, i bust.",
    //     subtitle: "Men's Shoe"),
    // ShoesDetails(
    //     id: "5",
    //     brand: "Campus",
    //     amount: 180,
    //     img:
    //         "https://images-na.ssl-images-amazon.com/images/I/81aTd1cmRBL._UL1500_.jpg",
    //     title: "Campus Ignite Men's Running Shoes",
    //     isFavorite: false,
    //     description:
    //         "Murmured token napping said ever heart beak of and be this. Visiter perched pallas the soul at by, i bust.",
    //     subtitle: "Men's Shoe"),
    // ShoesDetails(
    //     id: "6",
    //     amount: 199,
    //     brand: "Campus",
    //     img:
    //         "https://images-na.ssl-images-amazon.com/images/I/71ipdmCB6CL._UL1440_.jpg",
    //     title: "Campus Men's Running Shoes",
    //     isFavorite: false,
    //     description:
    //         "Murmured token napping said ever heart beak of and be this. Visiter perched pallas the soul at by, i bust.",
    //     subtitle: "Men's Shoe"),
    // ShoesDetails(
    //     id: "7",
    //     amount: 180,
    //     brand: "ASIAN",
    //     img:
    //         "https://images-na.ssl-images-amazon.com/images/I/61U-%2Bv%2BEuBL._UL1100_.jpg",
    //     title: "ASIAN Men's Airsocks-12 Black Red Knitted Sports Shoes",
    //     isFavorite: false,
    //     description:
    //         "Murmured token napping said ever heart beak of and be this. Visiter perched pallas the soul at by, i bust.",
    //     subtitle: "Men's Shoe"),
    // ShoesDetails(
    //     id: "8",
    //     amount: 289,
    //     brand: "Puma",
    //     img:
    //         "https://images-na.ssl-images-amazon.com/images/I/517EH0tjYZL._UL1200_.jpg",
    //     title: "Puma Unisex-Adult Flair Running Shoe",
    //     isFavorite: false,
    //     description:
    //         "Murmured token napping said ever heart beak of and be this. Visiter perched pallas the soul at by, i bust.",
    //     subtitle: "Men's Shoe"),
  ];

  String token;
  Auth _auth;
  String userId;
  set userID(String userIdValue) {
    userId = userIdValue;
  }

  set auth(Auth value) {
//   if (_auth != value) {
    _auth = value;
    token = _auth.token;
//   }
  }

  List<ShoesDetails> get items {
    return [..._item]; // ek copy pass hua hai call by value to be clear
  }

  List<ShoesDetails> get favorite {
    // A getter Function to get favorite items
    return _item.where((shoe) => shoe.isFavorite).toList();
  }

  ShoesDetails findbyId(String id) {
    return _item.firstWhere((shoe) => shoe.id == id);
  }

  bool isFavNow = false;

  Future<void> fetchShoes() async {
    final url = Uri.parse(
        "https://shoeapp-e1665-default-rtdb.asia-southeast1.firebasedatabase.app/Shoes.json?auth=$token");
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      final favoriteShoes = await http.get(Uri.parse(
          "https://shoeapp-e1665-default-rtdb.asia-southeast1.firebasedatabase.app/userFavorites/$userId.json?auth=$token"));
      final List<ShoesDetails> loadedShoes = [];
      final favData = json.decode(favoriteShoes.body);
      extractedData.forEach((id, shoedata) {
        loadedShoes.add(ShoesDetails(
            id: id,
            amount: shoedata['amount'],
            isFavorite: favData == null ? false : favData[id] ?? false,
            img: shoedata['img'],
            title: shoedata['title'],
            description: shoedata['description'],
            subtitle: shoedata['subtitle'],
            brand: shoedata['brand']));
      });
      _item = loadedShoes;
      notifyListeners();
      // print(json.decode(response.body));
    } catch (error) {
      throw error;
    }
  }

  Future<void> addShoe(ShoesDetails addShoe) async {
    final url = Uri.https(
        "shoeapp-e1665-default-rtdb.asia-southeast1.firebasedatabase.app",
        "Shoes.json?auth=$token");
    try {
      final response = await http.post(url,
          body: json.encode({
            //isme khaali object pass nhi kar sakte isko chaiye json toh map ke form mein bheja
            'title': addShoe.title,
            'amount': addShoe.amount,
            'img': addShoe.img,
            'description': addShoe.description,
            'subtitle': addShoe.subtitle,
            'brand': addShoe.brand,
            'isFavorite': addShoe.isFavorite
          }));
      final newShoe = ShoesDetails(
          id: jsonDecode(response.body)['name'],
          amount: addShoe.amount,
          isFavorite: addShoe.isFavorite,
          img: addShoe.img,
          title: addShoe.title,
          description: addShoe.description,
          subtitle: addShoe.subtitle,
          brand: addShoe.brand);
      _item.add(newShoe);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }

    // _items.add(value) isse karne se kaam toh ho jaata hai but usse pata nhi chlta _item ko
  }
}
