import 'package:mvvm_architechture/data/network/app_api.dart';
import 'package:mvvm_architechture/data/network/requests.dart';
import 'package:mvvm_architechture/data/response/responses.dart';

abstract class RemoteDataSource{

 Future<AuthenticationResponse>  login(LoginRequest loginRequest);
}



class RemoteDataSourceImpl implements RemoteDataSource{
  final AppServiceClient _appServiceClient;

  RemoteDataSourceImpl(this._appServiceClient);
  @override
  Future<AuthenticationResponse> login(LoginRequest loginRequest) async {
    return await _appServiceClient.login(loginRequest.email,loginRequest.password);
  }

}