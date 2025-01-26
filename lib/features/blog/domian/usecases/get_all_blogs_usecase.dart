import 'package:blogapp/core/error/failure.dart';
import 'package:blogapp/core/usecases/usecase.dart';
import 'package:blogapp/features/blog/domian/entitiy/blog_entity.dart';
import 'package:blogapp/features/blog/domian/repository/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetAllBlogsUsecase implements Usecase<List<Blog>, NOParam> {
  final BlogRepository blogRepository;

  GetAllBlogsUsecase(this.blogRepository);

  @override
  Future<Either<Failure, List<Blog>>> call(NOParam param) async {
    return await blogRepository.getAllBlogs();
  }
}

class NOParam {}
