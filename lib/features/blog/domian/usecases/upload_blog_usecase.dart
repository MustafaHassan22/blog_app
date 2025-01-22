import 'dart:io';

import 'package:blogapp/core/error/failure.dart';
import 'package:blogapp/core/usecases/usecase.dart';
import 'package:blogapp/features/blog/domian/entitiy/blog_entity.dart';
import 'package:blogapp/features/blog/domian/repository/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class UploadBlogUsecase implements Usecase<Blog, BlogParam> {
  final BlogRepository blogRepository;
  UploadBlogUsecase(this.blogRepository);
  @override
  Future<Either<Failure, Blog>> call(BlogParam param) async {
    return await blogRepository.uploadBlog(
      image: param.image,
      title: param.title,
      content: param.content,
      posterId: param.posterId,
      topics: param.topics,
    );
  }
}

class BlogParam {
  final File image;
  final String title;
  final String content;
  final String posterId;
  final List<String> topics;

  BlogParam(
    this.image,
    this.title,
    this.content,
    this.posterId,
    this.topics,
  );
}
