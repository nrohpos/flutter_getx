import 'package:demogetx/controller/HomeController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController homeController = Get.put(HomeController());
  var scrollController = ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    scrollController.addListener(pagination);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("GetX Demo")),
      body: Obx(() => homeController.isDataLoading.value
          ? const Center(child: CircularProgressIndicator())
          : _builScreen()),
    );
  }

  Widget _builScreen() {
    var count = homeController.user?.data?.length;

    return ListView.builder(
      key: PageStorageKey("homeKey"),
      itemCount: count ?? 0,
      itemBuilder: (context, index) {
        return Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                padding: const EdgeInsets.only(left: 20),
                height: 80,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 35,
                      backgroundImage: NetworkImage(
                          homeController.user!.data![index].picture!),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          homeController.user!.data![index].title!
                              .toUpperCase(),
                          style: const TextStyle(
                              color: Colors.black, fontSize: 18),
                        ),
                        Text(homeController.user!.data![index].firstName!,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 18)),
                        Text(homeController.user!.data![index].lastName!,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 18)),
                      ],
                    ),
                  ],
                )),
            const SizedBox(
              height: 10,
            )
          ],
        );
      },
      controller: scrollController,
    );
  }

  void pagination() {
    if ((scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) &&
        ((homeController.user?.data?.length ?? 0) <
            (homeController.user?.total ?? 0))) {
      homeController.page += 1;
      homeController.getApi();
    }
  }
}
