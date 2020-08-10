import 'package:flutter_html/flutter_html.dart';
import 'package:blog_app_api/models/blog_post.dart';
import 'package:flutter/material.dart';

class BlogDetailScreen extends StatefulWidget {
  final BlogPost bpost;

  const BlogDetailScreen({Key key, this.bpost}) : super(key: key);
  @override
  _BlogDetailScreenState createState() => _BlogDetailScreenState();
}

class _BlogDetailScreenState extends State<BlogDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.bpost.title),),
      body: ListView(
        children: [
          Card(child: Column(
            children: [
               Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: widget.bpost.featuredImgUrl != null?Image.network(widget.bpost.featuredImgUrl):Container(child: Center(
                          child: Text('Gambar tidak tersedia'),
                        ),),
                      ),
                      Padding(padding: EdgeInsets.all(4), child: Text(widget.bpost.title),),

            ],
          ),),
           Padding(padding: EdgeInsets.all(4), child: Html(data:widget.bpost.details),)
        ],
      ),
      
    );
  }
}