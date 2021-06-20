import 'package:flutter/material.dart';
import 'package:labyrinth/helper/size_config.dart';
import 'package:labyrinth/model/post.dart';

import 'post_page.dart';

class VerticalPostsScroll extends StatefulWidget {
  final List<Post> posts;

  VerticalPostsScroll({
    this.posts,
  });

  @override
  _VerticalPostsScrollState createState() => _VerticalPostsScrollState();
}

class _VerticalPostsScrollState extends State<VerticalPostsScroll> {
  @override
  Widget build(BuildContext context) {
    return SliverList(delegate: SliverChildListDelegate(_buildPostList()));
  }

  _buildPostList() {
    List<Widget> listItems = [];

    for (int i = 0; i < widget.posts.length; i++) {
      Post post = widget.posts[i];
      listItems.add(GestureDetector(
        child: Container(
          margin: EdgeInsets.symmetric(
              horizontal: SizeConfig.adaptWidth(5),
              vertical: SizeConfig.adaptHeight(1)),
          padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.adaptWidth(5),
              vertical: SizeConfig.adaptHeight(2)),
          alignment: Alignment.center,
          height: SizeConfig.adaptHeight(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                  color: Colors.black54,
                  offset: Offset(0.0, 3.0),
                  blurRadius: 3.0),
            ],
          ),
          child: Stack(
            children: [
              Row(
                children: [
                  FutureBuilder(
                    future: post.completer.future,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Container(
                          margin: EdgeInsets.only(
                            right: SizeConfig.adaptWidth(5),
                          ),
                          alignment: Alignment.center,
                          height: SizeConfig.adaptHeight(12),
                          width: SizeConfig.adaptWidth(20),
                          decoration: BoxDecoration(
                            color: Colors.grey[50],
                            borderRadius: BorderRadius.circular(10.0),
                            image: DecorationImage(
                                image: post.image.image, fit: BoxFit.cover),
                          ),
                        );
                      } else {
                        return Container(
                          margin: EdgeInsets.only(
                            right: SizeConfig.adaptWidth(5),
                          ),
                          alignment: Alignment.center,
                          height: SizeConfig.adaptHeight(12),
                          width: SizeConfig.adaptWidth(20),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }
                    },
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          post.subject,
                          style: TextStyle(color: Colors.indigo),
                        ),
                        SizedBox(
                          height: SizeConfig.adaptHeight(0.5),
                        ),
                        Text(
                          post.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: SizeConfig.adaptFontSize(6),
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.clip,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                    child: Icon(
                      Icons.bookmark_outline,
                    ),
                    onTap: () {
                      print("bookmark");
                    }),
              ),
            ],
          ),
        ),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PostPage(
                    post: post,
                  )),
        ),
      ));
    }
    return listItems;
  }
}
