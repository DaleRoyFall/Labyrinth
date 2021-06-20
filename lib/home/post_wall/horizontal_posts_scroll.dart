import 'package:flutter/material.dart';
import 'package:labyrinth/helper/size_config.dart';
import 'package:labyrinth/home/post_wall/post_page.dart';
import 'package:labyrinth/model/post.dart';

class HorizontalPostsScroll extends StatefulWidget {
  final List<Post> posts;
  final double imageHeight;
  final double imageWidth;

  HorizontalPostsScroll({
    this.posts,
    this.imageHeight,
    this.imageWidth,
  });

  @override
  _HorizontalPostsScrollState createState() => _HorizontalPostsScrollState();
}

class _HorizontalPostsScrollState extends State<HorizontalPostsScroll> {
  @override
  Widget build(BuildContext context) {
    print(widget.posts);
    return _buildPostList();
  }

  Widget _buildPostList() {
    return Container(
      height: widget.imageHeight,
      child: ListView.builder(
        padding: EdgeInsets.only(left: SizeConfig.adaptWidth(6)),
        scrollDirection: Axis.horizontal,
        itemCount: widget.posts != null ? widget.posts.length : 0,
        itemBuilder: (BuildContext context, int index) {
          Post post = widget.posts[index];
          return Container(
              width: widget.imageWidth + SizeConfig.adaptWidth(6),
              child: Stack(
                children: [
                  FutureBuilder(
                    future: post.completer.future,
                    builder: (context, snapshot) {
                      return GestureDetector(
                        child: Container(
                          alignment: Alignment.center,
                          width: widget.imageWidth,
                          height:
                              widget.imageHeight - SizeConfig.adaptHeight(4),
                          decoration: snapshot.hasData
                              ? BoxDecoration(
                                  color: Colors.blue[100],
                                  borderRadius: BorderRadius.circular(10.0),
                                  image: DecorationImage(
                                      image: post.image.image,
                                      fit: BoxFit.cover),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black54,
                                        offset: Offset(10.0, 10.0),
                                        blurRadius: 6.0,
                                        spreadRadius: 1),
                                  ],
                                )
                              : BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(10.0),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black54,
                                        offset: Offset(10.0, 10.0),
                                        blurRadius: 6.0,
                                        spreadRadius: 1),
                                  ],
                                ),
                          child: snapshot.hasData
                              ? Container()
                              : Center(child: CircularProgressIndicator()),
                        ),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PostPage(
                                    post: post,
                                  )),
                        ),
                      );
                    },
                  ),
                  Container(
                    margin: EdgeInsets.all(SizeConfig.adaptWidth(3)),
                    height: SizeConfig.adaptWidth(3),
                    width: SizeConfig.adaptWidth(3),
                    decoration: BoxDecoration(
                      color: Colors.blue[100],
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      width: widget.imageWidth,
                      margin: EdgeInsets.only(
                        left: SizeConfig.adaptWidth(3),
                        bottom: SizeConfig.adaptHeight(6),
                      ),
                      padding: EdgeInsets.only(
                        right: SizeConfig.adaptWidth(6),
                      ),
                      child: Text(
                        post.title,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: SizeConfig.adaptFontSize(6)),
                        maxLines: 2,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      margin: EdgeInsets.only(
                          right: SizeConfig.adaptWidth(10),
                          top: SizeConfig.adaptHeight(2.5)),
                      child: GestureDetector(
                          child: Icon(
                            Icons.bookmark_border,
                            // accesoryBookmarks[index]
                            //     ? Icons.bookmark
                            //     : Icons.bookmark_border,
                            color: Colors.white,
                          ),
                          onTap: () {
                            // setState(() {
                            //   accesoryBookmarks[index] =
                            //       !accesoryBookmarks[index];
                            // });
                            print("Bookmark");
                          }),
                    ),
                  ),
                ],
              ));
          // return FutureBuilder(
          //     future: reference.getDownloadURL(),
          //     builder: (context, snapshot) {
          //       Image image;
          //       if (snapshot.hasData) {
          //         image = Image.network(snapshot.data.toString());
          //       }
          //       return Container(
          //         padding: EdgeInsets.symmetric(
          //           horizontal: 10.0,
          //           vertical: 10.0,
          //         ),
          //         margin: EdgeInsets.symmetric(
          //           horizontal: 10.0,
          //           vertical: 20.0,
          //         ),
          //         width: imageWidth,
          //         decoration: BoxDecoration(
          //           borderRadius: BorderRadius.circular(10.0),
          //           color: Colors.white,
          //           boxShadow: [
          //             BoxShadow(
          //               color: Colors.black54,
          //               offset: Offset(0.0, 4.0),
          //               blurRadius: 6.0,
          //             ),
          //           ],
          //         ),
          //         child: GestureDetector(
          //           onTap: () => print("Image"),
          //           // Navigator.push(
          //           //   context,
          //           //   MaterialPageRoute(
          //           //     builder: (_) =>
          //           //     AccesoriesScreen(
          //           //       accesories: accesories[index],
          //           //       image: image,
          //           //     ),
          //           //   ),
          //           // ),
          //           child: snapshot.hasData || image != null
          //               ? ClipRRect(
          //                   borderRadius: BorderRadius.circular(10.0),
          //                   child: image,
          //                 )
          //               : CircularProgressIndicator(
          //                   strokeWidth: 4,
          //                 ),
          //         ),
          //       );
          //     });
        },
      ),
    );
  }
}
