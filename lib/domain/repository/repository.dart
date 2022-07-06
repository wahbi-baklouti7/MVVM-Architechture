import 'package:dartz/dartz.dart';
import 'package:mvvm_architechture/data/network/failure.dart';
import 'package:mvvm_architechture/data/network/requests.dart';
import 'package:mvvm_architechture/domain/models/forget_password_model.dart';
import 'package:mvvm_architechture/domain/models/login_model.dart';

abstract class Repository{

 Future<Either<Failure,Authentication>> login(LoginRequest loginRequest);
 Future<Either<Failure,ForgetPassword>> forgetPassword();
}