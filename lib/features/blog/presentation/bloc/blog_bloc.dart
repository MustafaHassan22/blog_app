import 'dart:io';

import 'package:blogapp/features/blog/domian/entitiy/blog_entity.dart';
import 'package:blogapp/features/blog/domian/usecases/get_all_blogs_usecase.dart';
import 'package:blogapp/features/blog/domian/usecases/upload_blog_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlogUsecase _uploadBlogUsecase;
  final GetAllBlogsUsecase _getAllBlogsUsecase;

  BlogBloc({
    required UploadBlogUsecase uploadBlogUsecase,
    required GetAllBlogsUsecase getAllBlogsUsecase,
  })  : _uploadBlogUsecase = uploadBlogUsecase,
        _getAllBlogsUsecase = getAllBlogsUsecase,
        super(BlogInitial()) {
    on<BlogEvent>((event, emit) => emit(BlogLoading()));
    on<BlogUploadEvent>(_uploadBlog);
    on<GetAllBlogsEvent>(_getAllBlogs);
  }

  void _uploadBlog(BlogUploadEvent event, Emitter<BlogState> emit) async {
    final res = await _uploadBlogUsecase(BlogParam(
      event.image,
      event.title,
      event.content,
      event.posterId,
      event.topics,
    ));

    res.fold(
      (l) => left(emit(BlogFailure(l.message))),
      (r) => emit(BlogUploadSuccess()),
    );
  }

  void _getAllBlogs(GetAllBlogsEvent event, Emitter<BlogState> emit) async {
    final res = await _getAllBlogsUsecase(NOParam());
    res.fold(
      (l) => left(emit(BlogFailure(l.message))),
      (r) => emit(BlogDisplaySuccess(r)),
    );
  }
}
