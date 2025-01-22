import 'dart:io';

import 'package:blogapp/core/error/exceptions.dart';
import 'package:blogapp/core/error/failure.dart';
import 'package:blogapp/features/blog/data/data_source/blog_remote_data_source.dart';
import 'package:blogapp/features/blog/data/model/blog_model.dart';
import 'package:blogapp/features/blog/domian/entitiy/blog_entity.dart';
import 'package:blogapp/features/blog/domian/repository/blog_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogRemoteDataSource blogRemoteDataSource;

  BlogRepositoryImpl(this.blogRemoteDataSource);

  @override
  Future<Either<Failure, Blog>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required String posterId,
    required List<String> topics,
  }) async {
    try {
      BlogModel blogModel = BlogModel(
        id: const Uuid().v1(),
        posterId: posterId,
        title: title,
        content: content,
        imageUrl: '',
        topics: topics,
        updatedAt: DateTime.now(),
      );

      final imgeUrl =
          await blogRemoteDataSource.uploadImage(image: image, blog: blogModel);

      blogModel = blogModel.copyWith(
        imageUrl: imgeUrl,
      );
      final uploadedBlog = await blogRemoteDataSource.uploadBlog(blogModel);
      return right(uploadedBlog);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
