import 'package:demo_stripe/model/post_model.dart';
import 'package:demo_stripe/model/user_model.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatefulWidget {
  static const String routeName = '/details';

  const DetailsPage({Key? key}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  late PostModel postModel;

  @override
  void didChangeDependencies() {
    postModel = ModalRoute.of(context)!.settings.arguments as PostModel;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.yellow[200],
        body: Container(
          margin: EdgeInsets.all(20),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Card(
              color: Colors.yellow,
              elevation: 10,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    // Text(
                    //   "Description: ",
                    //   style:
                    //       TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    // ),
                    Expanded(
                        child: Text("Description:\n\n${postModel.body!}",
                      style: TextStyle(fontSize: 24),
                      maxLines: 100,
                      textAlign: TextAlign.justify,
                      overflow: TextOverflow.ellipsis,
                    )),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
