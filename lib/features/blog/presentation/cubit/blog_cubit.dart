import 'dart:io';

import 'package:blogapp/features/blog/domian/usecases/upload_blog_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blog_state.dart';

class BlogCubit extends Cubit<BlogState> {
  final UploadBlogUsecase uploadBlogUsecase;
  BlogCubit({required this.uploadBlogUsecase}) : super(BlogInitial());

  Future<void> uploadBlog({
    required File image,
    required String title,
    required String content,
    required String posterId,
    required List<String> topics,
  }) async {
    emit(BlogLoadig());
    final res = await uploadBlogUsecase(
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
      (_) => emit(BlogSucces()),
    );
  }
}
