import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:labyrinth/firebase/firebase_cloud_firestore.dart';
import 'package:labyrinth/helper/app_localizations.dart';
import 'package:labyrinth/helper/size_config.dart';
import 'package:labyrinth/model/post.dart';

import 'bloc_list/post_list_cubit.dart';
import 'horizontal_posts_scroll.dart';
import 'vertical_posts_scroll.dart';

class HomeWallPage extends StatefulWidget {
  HomeWallPage({this.backgroundColor});

  final Color backgroundColor;

  @override
  _HomeWallPageState createState() => _HomeWallPageState();
}

class _HomeWallPageState extends State<HomeWallPage> {
  @override
  void initState() {
    super.initState();
  }

  List<Widget> addInitialItems(PostListState state) {
    List<Widget> initialItems = [];
    initialItems.addAll([
      SizedBox(
        height: SizeConfig.adaptHeight(8),
      ),
      Container(
        margin: EdgeInsets.only(left: SizeConfig.adaptWidth(6)),
        child: Text(
          AppLocalizations.of(context).translate("posts"),
          style: TextStyle(
              color: Colors.black54,
              fontSize: SizeConfig.adaptFontSize(6),
              fontWeight: FontWeight.bold),
        ),
      ),
      SizedBox(
        height: SizeConfig.adaptHeight(6),
      ),
      HorizontalPostsScroll(
        posts: state.posts.length >= 3
            ? state.posts.getRange(0, 3).toList()
            : state.posts,
        imageHeight: SizeConfig.adaptHeight(60),
        imageWidth: SizeConfig.adaptWidth(70),
      ),
      SizedBox(
        height: SizeConfig.adaptHeight(6),
      ),
      Container(
        margin: EdgeInsets.only(left: SizeConfig.adaptWidth(6)),
        child: Text(
          AppLocalizations.of(context).translate("interesting"),
          style: TextStyle(
              color: Colors.black54,
              fontSize: SizeConfig.adaptFontSize(6),
              fontWeight: FontWeight.bold),
        ),
      ),
      SizedBox(
        height: SizeConfig.adaptHeight(4),
      ),
    ]);

    return initialItems;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: BlocBuilder<PostListCubit, PostListState>(
        builder: (context, state) {
          // _listCubit = BlocProvider.of<ListCubit>(context);
          return CustomScrollView(
            slivers: <Widget>[
              SliverList(
                  delegate: SliverChildListDelegate(addInitialItems(state))),
              VerticalPostsScroll(
                posts: state.posts.length >= 3
                    ? state.posts.getRange(3, state.posts.length).toList()
                    : state.posts,
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  SizedBox(
                    height: SizeConfig.adaptHeight(3),
                  ),
                ]),
              )
            ],
          );
        },
      ),
    );
  }
}
