
import 'package:dio/dio.dart';
import 'package:mvvm_architechture/app/constants.dart';
import 'package:mvvm_architechture/data/response/responses.dart';
import 'package:retrofit/http.dart';

part 'app_api.g.dart';


@RestApi(baseUrl:Constants.baseUrl )
abstract class AppServiceClient{

  factory AppServiceClient(Dio dio,{String baseUrl}) = _AppServiceClient;


  @POST("/customer/login")
  Future<AuthenticationResponse> login(
    @Field("email") String email,@Field("password") String password
  );
}