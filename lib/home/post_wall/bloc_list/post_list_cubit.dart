import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:labyrinth/firebase/firebase_cloud_firestore.dart';
import 'package:labyrinth/model/post.dart';

part 'post_list_state.dart';

class PostListCubit extends Cubit<PostListState> {
  PostListCubit() : super(const PostListState.loading());

  Future<void> fetchPostList() async {
    try {
      final QuerySnapshot queryPosts =
          await FirebaseCloudFirestore().getPosts();
      List<Post> posts = [];
      queryPosts.docs.forEach((post) {
        Post fromJsonPost = Post.fromJson(post.data());
        fromJsonPost.getImage();
        posts.add(fromJsonPost);
      });

      emit(PostListState.success(posts));
    } on Exception {
      emit(const PostListState.failure());
    }
  }

  // Future<void> setProductFavorite(int id) async {
  //   Product product = state.products.firstWhere((product) => product.id == id);
  //   if (product.favorite) {
  //     dbProvider.deleteFavoriteProduct(product.id);
  //   } else {
  //     dbProvider.insertFavoriteProduct(
  //         new FavoriteProductDTO(favoriteProductId: product.id));
  //   }

  //   final favoriteInProgress = state.products.map((product) {
  //     return product.id == id
  //         ? product.copyWith(favorite: !product.favorite)
  //         : product;
  //   }).toList();

  //   emit(ListState.success(state.favorite, favoriteInProgress));
  // }

  void setStatus(PostListStatus status) {
    PostListState.setStatus(status, state.posts);
  }
}
