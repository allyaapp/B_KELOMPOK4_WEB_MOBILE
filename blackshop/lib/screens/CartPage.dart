import 'dart:convert';

import 'package:blackshop/providers/CartProvider.dart';
import 'package:flutter/material.dart';
import 'package:blackshop/utils/CustomTextStyle.dart';
import 'package:blackshop/utils/CustomUtils.dart';
import 'package:blackshop/models/CartModels.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// import 'package:badges/badges.dart';

import 'CheckOutPage.dart';

class CartPage extends StatefulWidget {
  // final CartModels cartModels;
  // CartPage(this.cartModels);
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // addCart() async {
  //   var url = Uri.parse("http://127.0.0.1:8000/api/cart?id_customer=9");
  //   final response = await http.get
  // }

  // counter() async{
  // CartProvider cartProvider = Provider.of<CartProvider>(context);
  // int _counter = cartProvider.;

  // }
  // bool showRaisedButtonBadge = true;
  late SharedPreferences sharedPreferences;

  String citie_id = "";
  int origin = 252;
  int id = 0;

  @override
  void initState() {
    getData();
    // TODO: implement initState
    super.initState();
  }

  getData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (mounted) {
      setState(() {
        citie_id = sharedPreferences.getString("citie_id")!;
        id = sharedPreferences.getInt("id")!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.black,
          iconSize: 22.0,
          onPressed: () {
            Navigator.pushNamed(context, '/home');
          },
        ),
        title: Text(
          "Shopping Cart",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
            fontFamily: 'sans-serif-light',
            color: Color.fromRGBO(1, 38, 0, 1),
          ),
        ),
      ),
      body: Builder(
        builder: (context) {
          return ListView(
            children: <Widget>[
              // createHeader(),
              createSubTitle(),
              createCartList(),
              footer(context)
            ],
          );
        },
      ),
    );
  }

  footer(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    int total = 0;
    for (int i = 0; i < cartProvider.carts.length; i++) {
      total += (cartProvider.carts[i].cartPrice! * cartProvider.carts[i].qty!);
    }
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(left: 30),
                child: Text(
                  "Total",
                  style: CustomTextStyle.textFormFieldBold
                      .copyWith(color: Colors.black, fontSize: 12),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 30),
                child: Text(
                  total.toString(),
                  // "Rp12000",
                  // cartProvider.carts[0].cartPrice.toString(),
                  style: CustomTextStyle.textFormFieldBlack
                      .copyWith(color: Colors.black, fontSize: 13),
                ),
              ),
            ],
          ),
          Utils.getSizedBox(height: 8, width: 0),
          cartProvider.carts.length > 0
              ? RaisedButton(
                  onPressed: () {
                    // ongkosKirim();
                    Navigator.pushNamed(context, '/checkout');
                  },
                  color: Colors.green,
                  padding: const EdgeInsets.only(
                      top: 12, left: 60, right: 60, bottom: 12),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(24))),
                  child: Text(
                    "Checkout",
                    style: CustomTextStyle.textFormFieldSemiBold
                        .copyWith(color: Colors.white),
                  ),
                )
              : Container(),
          Utils.getSizedBox(height: 8, width: 0),
        ],
      ),
      margin: const EdgeInsets.only(top: 16),
    );
  }

  createHeader() {
    return Column(
      children: <Widget>[
        Container(
          // padding: EdgeInsets.symmetric(vertical: 10),
          // height: 50.0,
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      color: Colors.black,
                      iconSize: 22.0,
                      onPressed: () {
                        Navigator.pushNamed(context, '/home');
                      },
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 5.0, top: 9.0),
                      child: Text(
                        "Shopping Cart",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          fontFamily: 'sans-serif-light',
                          color: Color.fromRGBO(1, 38, 0, 1),
                        ),
                      ),
                      // margin: const EdgeInsets.only(left: 12, top: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  createSubTitle() {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    return Container(
      alignment: Alignment.topLeft,
      child: Text(
        "Total (" + cartProvider.carts.length.toString() + ") Item",
        style: CustomTextStyle.textFormFieldBold
            .copyWith(fontSize: 12, color: Colors.black),
      ),
      margin: const EdgeInsets.only(left: 12, top: 4),
    );
  }

  createCartList() {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemBuilder: (context, position) {
        return createCartListItem(cartProvider.carts[position]);
      },
      itemCount: cartProvider.carts.length,
    );
  }

  createCartListItem(CartModels cart) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    return Stack(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
          decoration: const BoxDecoration(
              color: Color.fromRGBO(229, 229, 229, 1),
              borderRadius: BorderRadius.all(Radius.circular(16))),
          child: Row(
            children: <Widget>[
              Container(
                margin:
                    const EdgeInsets.only(right: 8, left: 8, top: 8, bottom: 8),
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(14)),
                    color: Colors.blue.shade200,
                    image: DecorationImage(
                        image: NetworkImage(
                          "https://blackshop.ws-tif.com/images/" +
                              cart.product!.image.toString(),
                        ),
                        fit: BoxFit.cover)),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.only(right: 8, top: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              // "Keripik Kaca",
                              cart.product!.name.toString(),
                              maxLines: 2,
                              softWrap: true,
                              style: CustomTextStyle.textFormFieldSemiBold
                                  .copyWith(fontSize: 14),
                            ),
                            Text(
                              // "Rp6000",
                              cart.product!.price.toString(),
                              style: CustomTextStyle.textFormFieldBlack
                                  .copyWith(color: Colors.black, fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                      Utils.getSizedBox(height: 6, width: 0),
                      // Text(
                      //   "Green M",
                      //   style: CustomTextStyle.textFormFieldRegular
                      //       .copyWith(color: Colors.grey, fontSize: 14),
                      // ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 2, horizontal: 5),
                              decoration: BoxDecoration(
                                  color: const Color.fromRGBO(196, 196, 196, 1),
                                  borderRadius: BorderRadius.circular(14)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  const Icon(
                                    Icons.remove,
                                    size: 20,
                                    color: Colors.black,
                                  ),
                                  Container(
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                    padding: const EdgeInsets.all(5),
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: Text(
                                      cart.qty.toString(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  const Icon(
                                    Icons.add,
                                    size: 20,
                                    color: Colors.black,
                                  )
                                ],
                              ),
                            ),
                            Text(
                              // "Rp12000",
                              (cart.cartPrice! * cart.qty!).toString(),
                              style: CustomTextStyle.textFormFieldBlack
                                  .copyWith(color: Colors.black, fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                flex: 100,
              )
            ],
          ),
        ),
        // Align(
        //   alignment: Alignment.topRight,
        //   child: Container(
        //     width: 24,
        //     height: 24,
        //     alignment: Alignment.center,
        //     margin: EdgeInsets.only(right: 10, top: 8),
        //     child: Icon(
        //       Icons.close,
        //       color: Colors.white,
        //       size: 20,
        //     ),
        //     decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(4)), color: Colors.green),
        //   ),
        // )
      ],
    );
  }
}
