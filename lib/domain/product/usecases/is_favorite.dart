import '/../../core/usecase/usecase.dart';
import '/../../domain/product/repository/product.dart';
import '/../../service_locator.dart';

class IsFavoriteUseCase implements UseCase<bool,String> {

  @override
  Future<bool> call({String ? params}) async {
    return await sl<ProductRepository>().isFavorite(params!);
  }

}