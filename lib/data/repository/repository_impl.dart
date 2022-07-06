import 'package:mvvm_architechture/data/data_source/remote_data_source.dart';
import 'package:mvvm_architechture/data/mapper/mapper.dart';
import 'package:mvvm_architechture/data/network/errors_handler.dart';
import 'package:mvvm_architechture/data/network/network_info.dart';
import 'package:mvvm_architechture/data/response/responses.dart';
import 'package:mvvm_architechture/domain/models/forget_password_model.dart';
import 'package:mvvm_architechture/domain/models/login_model.dart';
import 'package:mvvm_architechture/data/network/requests.dart';
import 'package:mvvm_architechture/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:mvvm_architechture/domain/repository/repository.dart';

class RepositoryImpl implements Repository {
  final RemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;
  RepositoryImpl(this._remoteDataSource, this._networkInfo);

  @override
  Future<Either<Failure, Authentication>> login(
      LoginRequest loginRequest) async {
    if (await _networkInfo.isConnected) {
      // device is connected to internet

      try {
        final AuthenticationResponse response =
            await _remoteDataSource.login(loginRequest);

        if (response.status == 0) {
          // success return either right
          return Right(response
              .toDomain()); // convert from AuthenticationResponse to Authentication object
        } else {
          // failure return either left
          return left(Failure(
              code: ApiInternalStatus.failure,
              message: ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // device is not connect to internet
      return left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, ForgetPassword>> forgetPassword() {
    // TODO: implement forgetPassword
    throw UnimplementedError();
  }
}
