import 'package:demogetx/binding/HomeBinding.dart';
import 'package:demogetx/route/RouteConstant.dart';
import 'package:demogetx/screens/home/HomeScreen.dart';
import 'package:get/get.dart';

List<GetPage> getPages = [
  GetPage(
      name: RouteConstant.homeScreen,
      page: () => HomeScreen(),
      middlewares: [
        // Add here
        // AuthGuard(),
      ],
      binding: HomeBinding()),
];
