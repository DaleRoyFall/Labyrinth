import 'package:flutter/material.dart';
import 'package:labyrinth/helper/size_config.dart';
import 'package:labyrinth/model/post.dart';
import 'package:styled_text/styled_text.dart';

class PostPage extends StatefulWidget {
  final Post post;

  PostPage({this.post});

  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white, body: _buildBody());
  }

  _buildBody() {
    return SingleChildScrollView(
      child: Stack(
        children: [
          FutureBuilder(
            future: widget.post.completer.future,
            builder: (context, snapshot) {
              return Container(
                height: SizeConfig.adaptHeight(60),
                decoration: snapshot.hasData
                    ? BoxDecoration(
                        color: Colors.blue[100],
                        image: DecorationImage(
                            image: widget.post.image.image, fit: BoxFit.cover),
                      )
                    : BoxDecoration(
                        color: Colors.blue[100],
                      ),
                child: snapshot.hasData
                    ? Container()
                    : Center(
                        child: CircularProgressIndicator(),
                      ),
              );
            },
          ),
          Container(
            margin: EdgeInsets.only(
                top: SizeConfig.adaptHeight(6),
                left: SizeConfig.adaptHeight(3)),
            child: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: SizeConfig.adaptHeight(50)),
            width: SizeConfig.adaptWidth(100),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50), topRight: Radius.circular(50)),
              color: Colors.white,
            ),
            child: IntrinsicHeight(
              child: Container(
                margin: EdgeInsets.symmetric(
                    vertical: SizeConfig.adaptHeight(6),
                    horizontal: SizeConfig.adaptWidth(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: SizeConfig.adaptHeight(0.5),
                    ),
                    Text(
                      widget.post.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: SizeConfig.adaptFontSize(6),
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.clip,
                    ),
                    SizedBox(
                      height: SizeConfig.adaptHeight(2),
                    ),
                    Flexible(
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: StyledText(
                          text: widget.post.content
                              .replaceAll('<nl>', '\n')
                              .replaceAll('<p>', '\n' + '     '),
                          styles: {
                            'bold': TextStyle(fontWeight: FontWeight.bold),
                          },
                          newLineAsBreaks: true,
                          style: TextStyle(
                            fontSize: SizeConfig.adaptFontSize(4),
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
