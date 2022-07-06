import 'package:dartz/dartz.dart';
import 'package:mvvm_architechture/data/network/failure.dart';

abstract class BaseUseCase<Input,Output>{
  // Input: data will come from presentation layer (View Model) to use case
  // Output: data will come from data layer (API) to send to usecase and finally send to view model
  Future<Either<Failure,Output>> execute(Input input);
}