import 'package:mvvm_architechture/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:mvvm_architechture/data/network/requests.dart';
import 'package:mvvm_architechture/domain/models/login_model.dart';
import 'package:mvvm_architechture/domain/repository/repository.dart';
import 'package:mvvm_architechture/domain/usecase/base_usecase.dart';

class LoginUseCase implements BaseUseCase<LoginUseCaseInput,Authentication>{
  
  final Repository _repository;
  LoginUseCase(this._repository);
  @override
  Future<Either<Failure, Authentication>> execute(input)async {
    return _repository.login(LoginRequest(email: input.email, password: input.password));
  }
  
}


class LoginUseCaseInput{
  String email;
  String password;

  LoginUseCaseInput(this.email,this.password);
}