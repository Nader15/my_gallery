import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_gallery/Logic/Controllers/home_controller.dart';
import 'package:my_gallery/Utils/app_alerts.dart';
import '../../../Utils/app_colors.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      body: WillPopScope(
        onWillPop: () => AppAlerts().onWillPop()!,
        child: SafeArea(
          child: EasyRefresh.custom(
            onRefresh: homeController.onRefresh,
            header: BallPulseHeader(
              color: AppColors.MAIN_COLOR,
            ),
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return Obx(
                      () {
                        return SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Welcome",
                                          style: TextStyle(
                                            fontSize: 25,
                                            color: AppColors.WHITE_COLOR,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          "${GetStorage().read<String>('UserName')}",
                                          style: const TextStyle(
                                            fontSize: 20,
                                            color: AppColors.WHITE_COLOR,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const CircleAvatar(
                                      child: Icon(Icons.person_outline),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 30),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        AppAlerts().onLogOutPop();
                                      },
                                      style: ButtonStyle(
                                          shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                          ),
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  AppColors.WHITE_COLOR),
                                          foregroundColor:
                                              MaterialStateProperty.all(
                                                  AppColors.RED_COLOR)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: const [
                                          Icon(Icons.arrow_back),
                                          SizedBox(width: 10),
                                          Text("Logout")
                                        ],
                                      ),
                                    ),
                                    homeController.isLoadingImage.value
                                        ? Column(
                                            children: const [
                                              CircularProgressIndicator(),
                                              SizedBox(height: 10),
                                              Text("Uploading image ..",
                                                style: TextStyle(
                                                    color: AppColors.WHITE_COLOR),
                                              ),
                                            ],
                                          )
                                        : ElevatedButton(
                                            onPressed: () {
                                              AppAlerts().getImagePop(context);
                                            },
                                            style: ButtonStyle(
                                                shape: MaterialStateProperty.all(
                                                  RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(15),
                                                  ),
                                                ),
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        AppColors.WHITE_COLOR),
                                                foregroundColor:
                                                    MaterialStateProperty.all(
                                                        AppColors.BLUE_COLOR)),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: const [
                                                Icon(Icons.upload),
                                                SizedBox(width: 10),
                                                Text("Upload")
                                              ],
                                            ),
                                          ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                homeController.isLoading.value
                                    ? const CircularProgressIndicator()
                                    : homeController.myGalleryList.isEmpty
                                        ? const Center(
                                            child: Text(
                                              "Your gallery is empty",
                                            ),
                                          )
                                        : GridView.builder(
                                            padding: const EdgeInsets.all(2),
                                            itemCount: homeController
                                                .myGalleryList.length,
                                            gridDelegate:
                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 3,
                                              // childAspectRatio: 1.3,
                                              mainAxisSpacing: 20,
                                              crossAxisSpacing: 20,
                                              // mainAxisExtent: 80
                                            ),
                                            physics:
                                                const BouncingScrollPhysics(),
                                            shrinkWrap: true,
                                            itemBuilder:
                                                (BuildContext context, index) {
                                              return ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                child: CachedNetworkImage(
                                                  imageUrl: homeController
                                                      .myGalleryList[index],
                                                  fit: BoxFit.fill,
                                                  placeholder: (context, url) =>
                                                      Image.asset(
                                                    "assets/images/placeholder.jpg",
                                                    height: double.infinity,
                                                    fit: BoxFit.fill,
                                                  ),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Stack(
                                                    children: [
                                                      Image.asset(
                                                        "assets/images/placeholder.jpg",
                                                        fit: BoxFit.fill,
                                                        height: double.infinity,
                                                      ),
                                                      Center(
                                                          child: Text(
                                                              "No_Image".tr)),
                                                    ],
                                                  ),
                                                ),
                                              );
                                              // return Container(
                                              //   decoration: BoxDecoration(
                                              //     borderRadius: BorderRadius.circular(20),
                                              //     image: DecorationImage(
                                              //         image: NetworkImage(
                                              //           homeController.myGalleryList[index],
                                              //         ),
                                              //         fit: BoxFit.fill),
                                              //   ),
                                              // );
                                            },
                                          ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  childCount: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
