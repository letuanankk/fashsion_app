import 'package:dartz/dartz.dart';
import '/../../core/usecase/usecase.dart';
import '/../../domain/category/repository/category.dart';
import '/../../service_locator.dart';

class GetCategoriesUseCase implements UseCase<Either,dynamic> {

  @override
  Future<Either> call({dynamic params}) async {
    return await sl<CategoryRepository>().getCategories();
  }

}