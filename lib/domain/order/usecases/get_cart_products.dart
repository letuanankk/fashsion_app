import 'package:dartz/dartz.dart';
import '/../../core/usecase/usecase.dart';
import '/../../domain/order/repository/order.dart';
import '/../../service_locator.dart';

class GetCartProductsUseCase implements UseCase<Either,dynamic> {

  @override
  Future<Either> call({dynamic params}) async {
    return sl<OrderRepository>().getCartProducts();
  }

}