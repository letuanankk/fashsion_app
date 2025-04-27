import 'package:dartz/dartz.dart';
import '/../../core/usecase/usecase.dart';
import '/../../data/order/models/order_registration_req.dart';
import '/../../domain/order/repository/order.dart';
import '/../../service_locator.dart';

class OrderRegistrationUseCase implements UseCase<Either,OrderRegistrationReq> {
  @override
  Future<Either> call({OrderRegistrationReq ? params}) async {
    return sl<OrderRepository>().orderRegistration(params!);
  }

}