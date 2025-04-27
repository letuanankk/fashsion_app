import 'package:dartz/dartz.dart';
import '/../../core/usecase/usecase.dart';
import '/../../data/auth/models/user_creation_req.dart';
import '/../../domain/auth/repository/auth.dart';
import '/../../service_locator.dart';

class SignupUseCase implements UseCase<Either,UserCreationReq> {


  @override
  Future<Either> call({UserCreationReq ? params}) async {
    return await sl<AuthRepository>().signup(params!);
  }

  
}