import 'package:flutter/cupertino.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../views/login.dart';

class AppRoutes {

  static const String LoginA ="/Login";


  static List<GetPage> routes = [

    GetPage(name: LoginA, page: () => Login()),


  ];





}