import 'package:dartz/dartz.dart';
import '/../../core/usecase/usecase.dart';
import '/../../domain/auth/repository/auth.dart';
import '/../../service_locator.dart';

class SendPasswordResetEmailUseCase implements UseCase<Either,String> {

  @override
  Future<Either> call({String ? params}) async {
    return sl<AuthRepository>().sendPasswordResetEmail(params!);
  }

}