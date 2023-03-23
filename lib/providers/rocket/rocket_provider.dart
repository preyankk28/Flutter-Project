import 'package:flutter/cupertino.dart';

import '../../model/Rocket.dart';
import '../../network/api_service_call.dart';
import '../../network/api_urls.dart';
import '../db/db_provider.dart';

List<Rocket> rocketsList(List<dynamic> list) => list.map((e) => Rocket.fromJson(e)).toList();

class RocketProvider with ChangeNotifier {
  List<Rocket> _rockets = [];

  List<Rocket> get rockets => List.from(_rockets);

  init(BuildContext context) async {
    fetchRockets();
  }

  Future<List<Rocket>> fetchRockets() async {
    try {
      const url = ApiUrls.getRockets;
      final response = await ApiServiceCall().getRequest(url: url);
      List<Rocket> rocketList = [];
      rocketList = response.length > 0 ? rocketsList(response) : [];
      _rockets = rocketList;
      for(int i =0 ; i<_rockets.length; i++){
        DBProvider.db.createRocket(_rockets[i]);
      }
      notifyListeners();
      return _rockets;
    } catch (e) {
      throw e;
    }
  }

}