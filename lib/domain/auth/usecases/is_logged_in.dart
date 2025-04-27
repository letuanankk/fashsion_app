import '/../../core/usecase/usecase.dart';
import '/../../domain/auth/repository/auth.dart';
import '/../../service_locator.dart';

class IsLoggedInUseCase implements UseCase<bool,dynamic> {

  @override
  Future<bool> call({params}) async {
    return await sl<AuthRepository>().isLoggedIn();
  }

}