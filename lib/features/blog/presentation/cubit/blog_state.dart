part of 'blog_cubit.dart';

@immutable
sealed class BlogState {}

final class BlogInitial extends BlogState {}

final class BlogLoadig extends BlogState {}

final class BlogFailure extends BlogState {
  final String message;
  BlogFailure(this.message);
}

final class BlogUploadSucces extends BlogState {}

final class BlogDisplaySucces extends BlogState {
  final List<Blog> blogs;

  BlogDisplaySucces(this.blogs);
}
