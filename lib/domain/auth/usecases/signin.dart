import 'package:dartz/dartz.dart';
import '/../../core/usecase/usecase.dart';
import '/../../data/auth/models/user_signin_req.dart';
import '/../../domain/auth/repository/auth.dart';
import '/../../service_locator.dart';

class SigninUseCase implements UseCase<Either,UserSigninReq> {

  @override
  Future<Either> call({UserSigninReq ? params}) async {
    return sl<AuthRepository>().signin(params!);
  }

}