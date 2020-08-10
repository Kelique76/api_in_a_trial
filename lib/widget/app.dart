
import 'dart:convert';

import 'package:blog_app_api/models/blog_post.dart';
import 'package:blog_app_api/service/blog_post_service.dart';
import 'package:blog_app_api/widget/detaol_blog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class AppHome extends StatefulWidget {
 
  @override
  _AppHomePageState createState() => _AppHomePageState();
}

class _AppHomePageState extends State<AppHome> {

  BlogPostService bps = BlogPostService();

 Future<List<BlogPost>> _getAllDataBlog()async{
    
   var hasil = await  bps.getAllBlogPost();
   List<BlogPost> _listBlog = List<BlogPost>();

   if(hasil !=null){
   var hslUbah =  json.decode(hasil.body);
  
   hslUbah.forEach((datablog){
     var modelnya = BlogPost();
     modelnya.title = datablog['title'];
     modelnya.details = datablog['details'];
     modelnya.featuredImgUrl = datablog['featured_image_url'];
     modelnya.category = datablog['category']['name'];
     modelnya.createdDate = datablog['created_at'];
    setState(() {
       _listBlog.add(modelnya);
    });
   });
   }
   return _listBlog;


  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
      
       
      ),
      body: FutureBuilder<List<BlogPost>>(
        future: _getAllDataBlog(),
        builder: (ctx, snap){
          if(snap.hasData){
            return ListView.builder(
              itemCount: snap.data.length,
              itemBuilder: (ctx, idx){
                var data = snap.data[idx];
                return Card(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: data.featuredImgUrl != null?Image.network(data.featuredImgUrl):Container(child: Center(
                          child: Text('Gambar tidak tersedia'),
                        ),),
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (b)=>BlogDetailScreen(
                            bpost: data,
                          )));
                        },
                                              child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(data.title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),textAlign: TextAlign.left,),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(data.category, style: TextStyle(backgroundColor: Colors.black12, fontSize: 15)),
                          Text("Terbit:"+DateFormat("dd-MMM-yyyy").format(DateTime.parse(data.createdDate)), style: TextStyle(backgroundColor: Colors.black12, fontSize: 15)),
                        ],
                      )
                    ],
                  ) ,
                );
              });
          }else{
            return Center(child: CircularProgressIndicator(),);
          }
          
        },
       
        
      ),
      
    );
  }
}
