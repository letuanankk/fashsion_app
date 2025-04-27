import 'package:dartz/dartz.dart';
import '/../../core/usecase/usecase.dart';
import '/../../domain/auth/repository/auth.dart';
import '/../../service_locator.dart';

class GetUserUseCase implements UseCase<Either,dynamic> {

  @override
  Future<Either> call({dynamic params}) async {
    return await sl<AuthRepository>().getUser();
  }

}