import 'package:assignment/features/post/model/data_model.dart';
import 'package:http/http.dart' as http;

class PostsRepo{
  static Future<List<DataModel>> fetchPostData()async{
    List<DataModel> posts = [];
   try {

      var client = http.Client();
      var response = await client
          .get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));

      posts = dataModelFromJson(response.body);
      print("posts ==  $posts");
      return posts;
    }catch(e){
     print("error +++   ${e.toString()}");
     return posts;
   }
  }
}