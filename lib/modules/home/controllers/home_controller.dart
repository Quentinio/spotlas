import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:spotlas/modules/services/api_service.dart';

import '../model/feed.dart';



class HomeController extends GetxController {

  final isLoading = true.obs;
  final feed = Rxn<List<Feed>>();
  RxList likedList = [].obs;
  RxList favouriteList = [].obs;
  RxBool liked = false.obs;
  int initialPage = 0;
  int activeIndex = 0;

  ///Pagination

  final controller = ScrollController();


  ///Pagination

  void addToLikedList(item) {
    likedList.add(item);
  }

  Future changeLiked() async {
    liked.toggle();
    Timer(const Duration(seconds: 2), () {
      liked.toggle();
    });

  }


  void changeIndex(index) {
    activeIndex = index;
}


  fetchEvents() async {
    try {
      isLoading(true);
      var response = await FeedApi.fetchEvents(initialPage);
      if (response != null) {
        feed.value = response.cast<Feed>();
      }
    } finally {
      isLoading(false);
    }
  }



  @override
  void onInit() async {
    await fetchEvents();
    pagination();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}

