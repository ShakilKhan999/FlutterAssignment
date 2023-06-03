import 'dart:convert';

import 'package:demo_stripe/pages/details_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/post_provider.dart';

class Api_intregation extends StatefulWidget {
  static const String routeName = '/api_intregation';

  const Api_intregation({Key? key}) : super(key: key);

  @override
  State<Api_intregation> createState() => _Api_intregationState();
}

class _Api_intregationState extends State<Api_intregation> {
  late PostProvider postProvider;

  @override
  void initState() {
    postProvider = Provider.of<PostProvider>(context, listen: false);
    postProvider.getAllUser();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.yellow[200],
        appBar: AppBar(
          title: Text(
            'Api_Intregation',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.yellow,
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              child: Consumer<PostProvider>(
                  builder: (context, provider, _) => ListView.builder(
                      itemCount: provider.postprovider.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 80,
                            margin: EdgeInsets.symmetric(horizontal: 15),
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, DetailsPage.routeName,
                                    arguments: provider.postprovider[index]);
                              },
                              child: Card(
                                color: Colors.yellow,
                                elevation: 5,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Title: ",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Expanded(
                                              child: Text(
                                            provider.postprovider[index].title
                                                .toString(),
                                            style: TextStyle(fontSize: 18),
                                            maxLines: 4,
                                            overflow: TextOverflow.ellipsis,
                                          )),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                        // ListTile(
                        //     title: Text(provider.userModel[index].name.toString()),
                        //   );
                      })),
            )
          ],
        ));
  }
}
