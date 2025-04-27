import 'package:dartz/dartz.dart';
import '/../../core/usecase/usecase.dart';
import '/../../domain/product/repository/product.dart';
import '/../../service_locator.dart';

class GetTopSellingUseCase implements UseCase<Either,dynamic> {

  @override
  Future<Either> call({dynamic params}) async {
    return await sl<ProductRepository>().getTopSelling();
  }

}