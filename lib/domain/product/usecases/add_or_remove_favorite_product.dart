import 'package:dartz/dartz.dart';
import '/../../core/usecase/usecase.dart';
import '/../../domain/product/entities/product.dart';
import '/../../domain/product/repository/product.dart';
import '/../../service_locator.dart';

class AddOrRemoveFavoriteProductUseCase implements UseCase<Either,ProductEntity> {

  @override
  Future<Either> call({ProductEntity? params}) async {
    return await sl<ProductRepository>().addOrRemoveFavoriteProduct(params!);
  }

}