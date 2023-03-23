import 'dart:convert';
import 'package:assignment/view/widgets/rocket_list_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/Rocket.dart';
import '../providers/db/db_provider.dart';
import '../providers/rocket/rocket_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  late RocketProvider rocketProvider;
  bool _loading = false;
  @override
  void initState() {
    super.initState();
    rocketProvider = Provider.of<RocketProvider>(context, listen: false);
    _getRockets();
  }
  _getRockets(){
    setState(() {
      _loading = true;
    });
    rocketProvider.init(context);
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Rockets"),),
      backgroundColor: Colors.white,
      body:_loading ?
      const Center(
        child: CircularProgressIndicator(),
      )
          : _buildRocketListView(context),
    );
  }

  _buildRocketListView(context) {
    return FutureBuilder(
      future: DBProvider.db.getAllRockets(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ListView.separated(
            separatorBuilder: (context, index) => const Divider(
              color: Colors.grey,
            ),
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              var rocket = snapshot.data[index];
              return RocketListItem(rocket: rocket,);
            },
          );
        }
      },
    );
  }
}
