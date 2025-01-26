import 'dart:io';

import 'package:blogapp/features/blog/domian/entitiy/blog_entity.dart';
import 'package:blogapp/features/blog/domian/usecases/get_all_blogs_usecase.dart';
import 'package:blogapp/features/blog/domian/usecases/upload_blog_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blog_state.dart';

class BlogCubit extends Cubit<BlogState> {
  final UploadBlogUsecase _uploadBlogUsecase;
  final GetAllBlogsUsecase _getAllBlogsUsecase;
  BlogCubit({
    required UploadBlogUsecase uploadBlogUsecase,
    required GetAllBlogsUsecase getAllBlogsUsecase,
  })  : _uploadBlogUsecase = uploadBlogUsecase,
        _getAllBlogsUsecase = getAllBlogsUsecase,
        super(BlogInitial());

  Future<void> uploadBlog({
    required File image,
    required String title,
    required String content,
    required String posterId,
    required List<String> topics,
  }) async {
    emit(BlogLoadig());
    final res = await _uploadBlogUsecase(
      BlogParam(
        image,
        title,
        content,
        posterId,
        topics,
      ),
    );
    res.fold(
      (l) => emit(BlogFailure(l.message)),
      (_) => emit(BlogUploadSucces()),
    );
  }

  Future<void> getAllBlogs() async {
    emit(BlogLoadig());
    final res = await _getAllBlogsUsecase(NOParam());
    res.fold(
      (l) => emit(BlogFailure(l.message)),
      (r) => emit(BlogDisplaySucces(r)),
    );
  }
}
