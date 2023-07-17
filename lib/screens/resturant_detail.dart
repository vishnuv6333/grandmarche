import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../model/model.dart';
import '../provider/resturant_provider.dart';

class ResturantScreen extends StatefulWidget {
  const ResturantScreen({super.key});

  @override
  State<ResturantScreen> createState() => _ResturantScreenState();
}

class _ResturantScreenState extends State<ResturantScreen> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final resurantProvider =
        Provider.of<ResurantProvider>(context, listen: false);
        late String lat;
        late String long;
    
    resurantProvider.getDetails();
    return SafeArea(
      child: Scaffold(
          body: Consumer<ResurantProvider>(
              builder: (context, lriverProvider, child) {
                lat=lriverProvider.latittude.toString();
                long=lriverProvider.logittude.toString();
             

            return lriverProvider.load
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Image.network(lriverProvider.Image.toString()),
                            const Positioned(
                                top: 12,
                                left: 12,
                                child: Icon(
                                  Icons.arrow_back_ios_new,
                                  size: 28,
                                )),
                            Positioned(
                                bottom: 9,
                                left: 12,
                                child: Text(
                                  lriverProvider.name.toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ))
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                lriverProvider.name.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 18,
                                decoration: const BoxDecoration(
                                    color: Colors.green,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8))),
                                child: const Row(
                                  children: [
                                    Text(
                                      " 1.5 ",
                                      style: TextStyle(color: Colors.white),
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
                              Text(lriverProvider.cuisine_type.toString())
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const Icon(Icons.location_on_outlined),
                              Text(lriverProvider.address.toString())
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Icon(Icons.access_time_filled),
                              Text(lriverProvider.operating_hours!['Monday']),
                              Icon(Icons.arrow_drop_down)
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Rating & Reviews",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 22),
                          ),
                        ),
                        ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: lriverProvider.review!.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              var review = lriverProvider.review![index];
                             
                              return Container(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            height: 18,
                                            decoration: const BoxDecoration(
                                                color: Colors.green,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(8))),
                                            child: Row(
                                              children: [
                                                Text(
                                                  " ${review['rating']} ",
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                ),
                                                const Icon(
                                                  Icons.star,
                                                  size: 13,
                                                  color: Colors.white,
                                                ),
                                                const SizedBox(
                                                  width: 3,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Text(review['name'])
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        review['comments'],
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.justify,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(review['date']),
                                        ),
                                        const Text("Read More")
                                      ],
                                    )
                                  ],
                                ),
                              );
                            })
                      ],
                    ),
                  );
          }),
          floatingActionButton: FloatingActionButton(
            backgroundColor: HexColor("#FF8C23"),
            foregroundColor: Colors.black,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                    28.0)), // Customize the shape if needed

            onPressed: () async{
             
            
              
                final url =
                    'https://www.google.com/maps?q=$lat,$long';
               
                  await launchUrlString(url);
               
              
            },
            child: const Column(
              children: [
                Icon(
                  Icons.directions_rounded,
                  color: Colors.white,
                ),
                Text(
                  "GO",
                  style: TextStyle(color: Colors.white, fontSize: 12),
                )
              ],
            ),
          )),
    );
  }
}
