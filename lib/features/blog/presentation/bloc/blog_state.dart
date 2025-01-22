part of 'blog_bloc.dart';

@immutable
sealed class BlogState {}

final class BlogInitial extends BlogState {}

final class BlogLoading extends BlogState {}

final class BlogSuccess extends BlogState {
  // final Blog blog;
  // BlogSuccess(this.blog);
}

final class BlogFailure extends BlogState {
  final String error;
  BlogFailure(this.error);
}
