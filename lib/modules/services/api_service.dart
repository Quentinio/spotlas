import 'package:spotlas/modules/home/model/feed.dart';
import 'package:http/http.dart' as http;

class FeedApi {
  static var client = http.Client();
  static Future<List<Feed>?> fetchEvents(int page) async {
    final response = await client.get(Uri.parse(
        'https://dev.api.spotlas.com/interview/feed?page=$page'));
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return feedFromJson(jsonString);
    } else {
      return null;
    }
  }
}