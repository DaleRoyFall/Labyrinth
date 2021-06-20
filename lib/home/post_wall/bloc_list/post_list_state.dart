part of 'post_list_cubit.dart';

enum PostListStatus { loading, success, failure }

class PostListState extends Equatable {
  const PostListState._({
    this.status = PostListStatus.loading,
    this.posts = const <Post>[],
  });

  const PostListState.loading() : this._();

  const PostListState.success(List<Post> posts)
      : this._(status: PostListStatus.success, posts: posts);

  const PostListState.setStatus(PostListStatus status, List<Post> posts)
      : this._(status: status, posts: posts);

  const PostListState.failure() : this._(status: PostListStatus.failure);

  final PostListStatus status;
  final List<Post> posts;

  @override
  List<Object> get props => [status, posts];
}
