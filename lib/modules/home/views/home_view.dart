import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:spotlas/modules/home/views/widgets/feed_card.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  late double _deviceHeight;
  late double _deviceWidth;

  final HomeController homeController = Get.put(HomeController());





  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;



    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(15.0),
            child: Text(
              'Feed',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Obx(() {
            if (homeController.isLoading.value) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return SingleChildScrollView(
                child: ListView.builder(

                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemCount: homeController.feed.value!.length,
                    itemBuilder: (context, index) {
                      var feed = homeController.feed.value![index];
                      return Column(
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              postImages(feed),
                              postAuthor(feed),
                              postDots(),
                              likedHeart(feed),
                              postInfo(feed),
                              toFavourite(feed),

                            ],
                          ),
                          postOptions(feed),
                          postDescription(feed),
                          postTypes(feed),
                          postedAgo(feed),
                          SizedBox(height: 30),
                        ],
                      );
                    }),
              );
            }
          })),
        ],
      ),
    );
  }

  Widget postImages(feed) {
    return GestureDetector(
      onDoubleTap: () {
        if (homeController.likedList.contains(feed.id)) {
          homeController.likedList.remove(feed.id);
        } else {
          homeController.likedList.add(feed.id);
          homeController.changeLiked();
        }
      },
      child: CarouselSlider.builder(
        itemCount: feed.media?.length,
        options: CarouselOptions(
          onPageChanged: (index, reason) {
            homeController.changeIndex(index);
          },
          enableInfiniteScroll: false,
          initialPage: 0,
          reverse: false,
          viewportFraction: 1,
          height: _deviceHeight * 0.6,
          enlargeCenterPage: false,
        ),
        itemBuilder: (context, index, realIndex) {
          // final urlImage = feed.media![index];
          return Image.network(feed.media![index].url.toString());
        },
      ),
    );
  }

  Widget postAuthor(feed) {
    return Positioned(
      top: 5,
      left: 5,
      child: Align(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 32,
                backgroundColor: Colors.pink,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(feed.author!.photoUrl.toString()),
                  radius: 28,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      feed.author!.username.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 18,
                        shadows: <Shadow>[
                          Shadow(
                            offset: Offset(0.5, 0.5),
                            blurRadius: 6.0,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      feed.author!.fullName.toString(),
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        shadows: const <Shadow>[
                          Shadow(
                            offset: Offset(0.5, 0.5),
                            blurRadius: 6.0,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }


/// Moved this widget from postAuthor because I had some issues with positioning in Stack
  Widget postDots() {
    return Positioned(
      top: 25,
      right: 15,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Image.asset('assets/options.png',
            scale: 4, color: Colors.white),
      ),
    );
  }

  Widget likedHeart(feed) {
    return Obx(() {
      if (homeController.likedList.contains(feed.id)) {
        if (homeController.liked == true) {
          return Image.asset('assets/heart.png', color: Colors.pink);
        } else {
          return Container();
        }
      } else {
        return Container();
      }
    });
  }

  Widget postInfo(feed) {
    return Positioned(
      bottom: 5,
      left: 5,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 32,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                backgroundImage: NetworkImage(feed.spot!.logo!.url.toString()),
                radius: 28,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    feed.spot!.name.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 18,
                      shadows: <Shadow>[
                        Shadow(
                          offset: Offset(0.5, 0.5),
                          blurRadius: 6.0,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                  Text(feed.spot!.location!.display.toString(), style: const TextStyle(
                      color: Colors.white
                  ),),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Moved this widget from postInfo because I had some issues with positioning in Stack
  Widget toFavourite(feed) {
    return Positioned(
      bottom: 40,
      right: 15,
      child: GestureDetector(
          onTap: () {
            if (homeController.favouriteList.contains(feed.id)) {
              homeController.favouriteList.remove(feed.id);
            } else {
              homeController.favouriteList.add(feed.id);
            }
          },
          child: Obx(() {
            return Container(
                child: homeController.favouriteList.contains(feed.id)
                    ? Image.asset('assets/star.png', scale: 4, color: Colors.yellow)
                    : Image.asset('assets/star_border.png', scale: 4, color: Colors.white),
            );
          })
      ),
    );
  }

  Widget postOptions(feed) {
    return Padding(
      padding: const EdgeInsets.only(top: 18.0, bottom: 5, left: 50, right: 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset('assets/map_border.png', scale: 4),
          Image.asset('assets/speech_bubble_border.png', scale: 4),
          GestureDetector(
            onTap: () {
              if (homeController.likedList.contains(feed.id)) {
                homeController.likedList.remove(feed.id);
              } else {
                homeController.addToLikedList(feed.id);
              }
              print(feed.id);
              print(homeController.likedList);
            },
            child: Obx(
              () {
                return Container(
                    child: homeController.likedList.contains(feed.id)
                        ? (Image.asset('assets/heart.png',
                            scale: 4, color: Colors.red))
                        : Image.asset('assets/heart_border.png', scale: 4));
              },
            ),
          ),
          Image.asset('assets/paper_plane_border.png', scale: 4),
        ],
      ),
    );
  }

  Widget postDescription(feed) {
    return  Padding(
      padding: EdgeInsets.only(left: 15.0, right: 15, top: 15),
      child: Align(
        alignment: Alignment.centerLeft,
        child: ReadMoreText(
          feed.caption?.text,
          trimLength: 80,
          colorClickableText: Colors.grey,
          preDataText: feed.author?.username + ' ',
          preDataTextStyle: const TextStyle(
            fontWeight: FontWeight.bold
          ),
          trimMode: TrimMode.Length,
          trimCollapsedText: 'more...',
          trimExpandedText: 'less',
          moreStyle: const TextStyle(
            color: Colors.grey,

          ),
          lessStyle: const TextStyle(
            fontWeight: FontWeight.bold
          ),
        ),
        // child: RichText(
        //   overflow: TextOverflow.ellipsis,
        //   maxLines: 2,
        //   text: TextSpan(
        //     style: const TextStyle(
        //         color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        //     text: feed.author?.username,
        //     children: [
        //       const TextSpan(text: ' '),
        //       TextSpan(
        //           text: feed.caption?.text,
        //           style: const TextStyle(
        //               fontWeight: FontWeight.normal, color: Colors.black)),
        //     ],
        //   ),
        // ),
      ),
    );
  }

  Widget postTypes(feed) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: feed.spot!.types!.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(left: 25.0, top: 15, bottom: 10),
            child: Container(
              child: Container(
                child: Text(
                  feed.spot!.types![index].name.toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          );
        });
  }

  Widget postedAgo(feed) {
    final today = DateTime.now();
    final postDay = feed.createdAt;
    final dayDiff = today.difference(postDay).inDays;
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 18.0, top: 10),
        child: Text(
          dayDiff.toString() + ' days ago',
          style:
              TextStyle(color: Colors.grey[300], fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
