import 'dart:io';

import 'package:blogapp/core/error/failure.dart';
import 'package:blogapp/features/blog/domian/entitiy/blog_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class BlogRepository {
  Future<Either<Failure, Blog>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required String posterId,
    required List<String> topics,
  });

  Future<Either<Failure, List<Blog>>> getAllBlogs();
  // Future<String> uploadImage({
  //   required File image,
  //   required Blog blog,
  // });
}
