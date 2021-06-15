import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shop_app/Models/ShoesModel.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/shoes_provider.dart';
import '../themes.dart';

class EditProductScreen extends StatefulWidget {
  static const routename = "/editprodscreen";
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _textFocusNode = FocusNode();
  final _descFocusNode = FocusNode();
  final _imageController = TextEditingController();
  final _imageFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _editedProduct = ShoesDetails(
      id: null,
      amount: 0,
      isFavorite: false,
      img: "",
      title: "",
      description: "",
      subtitle: "",
      brand: "");
  bool _isloading = false;

  @override
  void initState() {
    _imageFocusNode.addListener(_updateImageurl);
    super.initState();
  }

  @override
  void dispose() {
    _imageFocusNode.removeListener(_updateImageurl);
    _priceFocusNode.dispose();
    _textFocusNode.dispose();
    _descFocusNode.dispose();
    _imageController.dispose();
    _imageFocusNode.dispose();
    // These are imp nhi toh apne aap dispose nhi honge which will cause memory leaks
    super.dispose();
  }

  void _updateImageurl() {
    if (!_imageFocusNode.hasFocus) {
      if (_imageController.text.isEmpty ||
          !_imageController.text.startsWith("http") &&
              !_imageController.text.startsWith("https") ||
          !_imageController.text.endsWith('.png') &&
              !_imageController.text.endsWith(".jpg") &&
              !_imageController.text.endsWith("jpeg")) return;
      setState(() {});
    }
  }

  void _saveForm() {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    setState(() {
      _isloading = true;
    });
    Provider.of<Shoes>(context, listen: false)
        .addShoe(_editedProduct)
        .catchError((error) {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: Text("Error Ocurred"),
                content: Text(
                  error.toString(),
                ),
                actions: [
                  // ignore: deprecated_member_use
                  FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("Band Kar"))
                ],
              ));
    }).then((_) {
      setState(() {
        _isloading = false;
      });
      Navigator.pop(context);
    });
    // Navigator.pop(context);
    // print(_editedProduct.title);
    // print(_editedProduct.amount);
    // print(_editedProduct.description);
    // print(_editedProduct.img);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _priceFocusNode.unfocus();
        _textFocusNode.unfocus();
        _descFocusNode.unfocus();
        _imageFocusNode.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).backgroundColor,
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
                padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
                child: CircleAvatar(
                  backgroundColor: Theme.of(context).buttonColor,
                  backgroundImage: NetworkImage(
                      "https://images.pexels.com/photos/4016173/pexels-photo-4016173.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940"),
                  radius: 20,
                )),
          ],
        ),
        body: _isloading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      "Edit Shoe",
                      style: Theme.of(context).textTheme.headline4.copyWith(
                          color: ShopTheme.headingColor,
                          fontWeight: FontWeight.bold),
                    ),
                    Form(
                      key: _form,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            TextFormField(
                                focusNode: _textFocusNode,
                                decoration: InputDecoration(labelText: 'Title'),
                                textInputAction: TextInputAction.next,
                                validator: (value) {
                                  if (value.isEmpty)
                                    return "Pls Provide a Value";

                                  return null;
                                },
                                onFieldSubmitted: (_) {
                                  FocusScope.of(context).requestFocus(
                                      _priceFocusNode); //iske bina bhi chl rha tha but this is best practice
                                },
                                onSaved: (value) {
                                  _editedProduct = ShoesDetails(
                                      id: _editedProduct.brand,
                                      amount: _editedProduct.amount,
                                      isFavorite: _editedProduct.isFavorite,
                                      img: _editedProduct.img,
                                      title: value,
                                      description: _editedProduct.description,
                                      subtitle: _editedProduct.subtitle,
                                      brand: _editedProduct.brand);
                                }),
                            TextFormField(
                                decoration: InputDecoration(labelText: 'Price'),
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.number,
                                focusNode: _priceFocusNode,
                                validator: (value) {
                                  if (value.isEmpty) return "Pls Enter a Price";

                                  if (double.tryParse(value) == null) {
                                    return "Pls enter Correct Price";
                                  }
                                  if (double.parse(value) <= 0)
                                    return "Price can't be Negative";
                                  return null;
                                },
                                onFieldSubmitted: (_) {
                                  FocusScope.of(context)
                                      .requestFocus(_descFocusNode);
                                },
                                onSaved: (value) {
                                  _editedProduct = ShoesDetails(
                                      id: _editedProduct.brand,
                                      amount: int.parse(value),
                                      isFavorite: _editedProduct.isFavorite,
                                      img: _editedProduct.img,
                                      title: _editedProduct.title,
                                      description: _editedProduct.description,
                                      subtitle: _editedProduct.subtitle,
                                      brand: _editedProduct.brand);
                                }),
                            TextFormField(
                                decoration:
                                    InputDecoration(labelText: 'Description'),
                                maxLines: 3,
                                keyboardType: TextInputType.multiline,
                                focusNode: _descFocusNode,
                                validator: (value) {
                                  if (value.isEmpty)
                                    return "Pls Provide a Description";

                                  return null;
                                },
                                onSaved: (value) {
                                  _editedProduct = ShoesDetails(
                                      id: _editedProduct.brand,
                                      amount: _editedProduct.amount,
                                      isFavorite: _editedProduct.isFavorite,
                                      img: _editedProduct.img,
                                      title: _editedProduct.title,
                                      description: value,
                                      subtitle: _editedProduct.subtitle,
                                      brand: _editedProduct.brand);
                                }),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  width: 100,
                                  height: 100,
                                  margin:
                                      const EdgeInsets.only(top: 10, right: 10),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1, color: Colors.blueGrey),
                                  ),
                                  child: _imageController.text.isEmpty
                                      ? Text("Enter the url")
                                      : FittedBox(
                                          child: Image.network(
                                              _imageController.text),
                                          fit: BoxFit.cover,
                                        ),
                                ),
                                Expanded(
                                  child: TextFormField(
                                      decoration: InputDecoration(
                                        labelText: "Image Url",
                                      ),
                                      keyboardType: TextInputType.url,
                                      textInputAction: TextInputAction.done,
                                      controller: _imageController,
                                      focusNode: _imageFocusNode,
                                      validator: (value) {
                                        if (value.isEmpty)
                                          return "Pls Provide a Value";
                                        if (!value.startsWith("http") &&
                                            !value.startsWith("https"))
                                          return "Enter a Valid URl";
                                        if (!value.endsWith('.png') &&
                                            !value.endsWith(".jpg") &&
                                            !value.endsWith("jpeg"))
                                          return "Enter a valid image url";
                                        return null;
                                      },
                                      onFieldSubmitted: (_) {
                                        _saveForm();
                                      },
                                      onSaved: (value) {
                                        _editedProduct = ShoesDetails(
                                            id: _editedProduct.brand,
                                            amount: _editedProduct.amount,
                                            isFavorite:
                                                _editedProduct.isFavorite,
                                            img: value,
                                            title: _editedProduct.title,
                                            description:
                                                _editedProduct.description,
                                            subtitle: _editedProduct.subtitle,
                                            brand: _editedProduct.brand);
                                      }),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Theme.of(context).buttonColor),
                                padding: MaterialStateProperty.all(
                                    EdgeInsets.all(16))),
                            onPressed: () {
                              _saveForm();
                            },
                            child: Center(
                              child: Text(
                                "Add Shoe",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    .copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                              ),
                            )),
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
