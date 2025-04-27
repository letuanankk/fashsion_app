import 'package:dartz/dartz.dart';
import '/../../core/usecase/usecase.dart';
import '/../../domain/product/repository/product.dart';
import '/../../service_locator.dart';

class GetProductsByTitleUseCase implements UseCase<Either,String> {

  @override
  Future<Either> call({String? params}) async {
    return await sl<ProductRepository>().getProductsByTitle(params!);
  }

}