import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../model/Rocket.dart';
import '../rocket_detail_screen.dart';

class RocketListItem extends StatelessWidget {
  final Rocket rocket;
  const RocketListItem({Key? key, required this.rocket}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RocketDetailsScreen(rocket: rocket)),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(20),
        child:Row(
          children: [
            Image.network(rocket.flickrImages![0], width: width*0.2,height: width*0.2,),
            const SizedBox(width: 10,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Rocket Name"),
                Text(rocket.rocketName ?? ""),
                const SizedBox(height: 10,),
                const Text("Company"),
                Text(rocket.company ?? ""),
                const SizedBox(height: 10,),
                const Text("Country"),
                Text(rocket.country ?? "")
              ],
            ),
          ],
        )
      )
    );
  }
}

