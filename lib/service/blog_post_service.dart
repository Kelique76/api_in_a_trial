import 'package:blog_app_api/repository/reposit.dart';

class BlogPostService{
  Repository _repo;

  BlogPostService(){
    _repo = Repository();
  }

  getAllBlogPost()async{
   return await _repo.ambilData('get-all-posts',);
  }
}