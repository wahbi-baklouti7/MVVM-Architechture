import 'package:mvvm_architechture/app/constants.dart';
import 'package:mvvm_architechture/data/response/responses.dart';
import 'package:mvvm_architechture/domain/models/login_model.dart';
import 'package:mvvm_architechture/app/extensions.dart';

extension CustomerResponseMapper on CustomerResponse? {
  Customer toDomain() {
    return Customer(this!.id.orEmpty(), this?.name.orEmpty() ?? Constants.empty,
        this?.numOfNotification.orZero() ?? Constants.zero);
  }
}

extension ContactsResponseMapper on ContactResponse? {
  Contacts toDomain() {
    return Contacts(
        this!.phone.orEmpty(),
        this?.email.orEmpty() ?? Constants.empty,
        this?.link.orEmpty() ?? Constants.empty);
  }
}

extension AuthenticationResponseMapper on AuthenticationResponse? {

   // convert from AuthenticationResponse to Authentication object in domain layer
  Authentication toDomain() {
    return Authentication(this?.contact.toDomain(), this?.customer.toDomain());
  }
}
