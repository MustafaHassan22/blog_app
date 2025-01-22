import 'dart:io';

import 'package:blogapp/features/blog/domian/usecases/upload_blog_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlogUsecase uploadBlogUsecase;

  BlogBloc({required this.uploadBlogUsecase}) : super(BlogInitial()) {
    on<BlogEvent>((event, emit) => emit(BlogLoading()));
    on<BlogUploadEvent>(_uploadBlog);
  }

  void _uploadBlog(BlogUploadEvent event, Emitter<BlogState> emit) async {
    final res = await uploadBlogUsecase(BlogParam(
      event.image,
      event.title,
      event.content,
      event.posterId,
      event.topics,
    ));

    res.fold(
      (l) => left(emit(BlogFailure(l.message))),
      (r) => emit(BlogSuccess()),
    );
  }
}
