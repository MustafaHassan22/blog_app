part of 'blog_bloc.dart';

@immutable
sealed class BlogState {}

final class BlogInitial extends BlogState {}

final class BlogLoading extends BlogState {}

final class BlogUploadSuccess extends BlogState {
  // final Blog blog;
  // BlogSuccess(this.blog);
}

final class BlogDisplaySuccess extends BlogState {
  final List<Blog> blogs;
  BlogDisplaySuccess(this.blogs);
}

final class BlogFailure extends BlogState {
  final String error;
  BlogFailure(this.error);
}
