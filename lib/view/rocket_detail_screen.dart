
import 'package:assignment/model/Rocket.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RocketDetailsScreen extends StatefulWidget {
  final Rocket rocket;
  const RocketDetailsScreen({Key? key, required this.rocket}) : super(key: key);

  @override
  State<RocketDetailsScreen> createState() => _RocketDetailsScreenState();
}

class _RocketDetailsScreenState extends State<RocketDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height =MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("Details"),),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(widget.rocket.flickrImages![0], width: width*0.9,height: height*0.2, fit: BoxFit.fill,),
            const SizedBox(height: 10,),
            const Text("Rocket Name"),
            Text(widget.rocket.rocketName ?? ""),
            SizedBox(height: 10,),
            const Text("Company"),
            Text(widget.rocket.company ?? ""),
            SizedBox(height: 10,),
            const Text("Country"),
            Text(widget.rocket.country ?? ""),



          ],
        ),
      )
    );
  }
}
