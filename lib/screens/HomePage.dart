import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:grandmarche/model/model.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../provider/resturant_provider.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final resurantProvider =
        Provider.of<ResurantProvider>(context, listen: false);
    resurantProvider.getResturantList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor("#FF8C23"),
        title: const Text(
          "RASTAURANT",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          Material(
            color: const Color.fromARGB(0, 196, 185, 185),
            child: InkWell(
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(
                      Icons.logout_outlined,
                      color: Colors.white,
                    ),
                    Text(
                      "Log out",
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
              onTap: () async {
               _showAlertDialog(context);
              },
            ),
          ),
        ],
      ),
      body:
          Consumer<ResurantProvider>(builder: (context, lriverProvider, child) {
        return lriverProvider.isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: lriverProvider.resturant.restaurants.length,
                        itemBuilder: (context, index) {
                          var res = lriverProvider.resturant.restaurants[index];
                          return InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, "/restarunt");
                              selectResturant(res);
                            },
                            child: Container(
                              color: Colors.white,
                              padding: const EdgeInsets.all(6),
                              child: Column(
                                children: [
                                  Image.network(res.photograph),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          res.name,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          height: 18,
                                          decoration: const BoxDecoration(
                                              color: Colors.green,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8))),
                                          child: const Row(
                                            children: [
                                              Text(
                                                " 1.5 ",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              Icon(
                                                Icons.star,
                                                size: 13,
                                                color: Colors.white,
                                              ),
                                              SizedBox(
                                                width: 3,
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        const Icon(Icons.dining_rounded),
                                        const SizedBox(
                                          width: 2,
                                        ),
                                        Text(res.cuisineType)
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        const Icon(Icons.location_on_outlined),
                                        Text(res.address)
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        })
                  ],
                ),
              );
      }),
    );
  }

  Future<void> _showAlertDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          // <-- SEE HERE
          
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Are you sure want to Log out?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.remove('email');
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/login',
                  (route) => false,
                );
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> selectResturant(Restaurant res) async {
    final prefs = await SharedPreferences.getInstance();
    var rest = jsonEncode(res);

    prefs.setString("resturant", rest);
  }
}
