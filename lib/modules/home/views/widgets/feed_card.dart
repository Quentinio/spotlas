// import 'package:flutter/cupertino.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:get/get_state_manager/src/simple/get_view.dart';
// import 'package:spotlas/modules/home/controllers/home_controller.dart';
// import 'package:spotlas/modules/home/model/feed.dart';
//
// class FeedCard extends GetView<HomeController> {
//   final Feed feed;
//
//   const FeedCard(this.feed);
//
//
//   @override
//   Widget build(BuildContext context) {
//
//     late double _deviceHeight;
//     late double _deviceWidth;
//
//     _deviceHeight = MediaQuery.of(context).size.height;
//     _deviceWidth = MediaQuery.of(context).size.width;
//
//     return Container(
//       height: _deviceHeight * 0.7,
//       width: _deviceWidth * 1,
//       child: Image.network(feed.f),
//     );
//   }
//
// }