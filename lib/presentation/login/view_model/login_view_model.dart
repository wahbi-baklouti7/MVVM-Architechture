import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:mvvm_architechture/domain/usecase/login_usecase.dart';
import 'package:mvvm_architechture/presentation/base/base_view_model.dart';
import 'package:mvvm_architechture/presentation/common/freezed/freezed_data_classes.dart';
import 'package:mvvm_architechture/presentation/common/state_render/state.render.impl.dart';
import 'package:mvvm_architechture/presentation/common/state_render/state_render.dart';

class LoginViewModel extends BaseViewModel
    with LoginViewModelInputs, LoginViewModelOutputs {
  final StreamController _userNameStreamController = StreamController<
      String>.broadcast(); //broadcast: stream can listen by many listeners
  final StreamController _passwordStreamController =
      StreamController<String>.broadcast();
  final StreamController _loginButtonStreamController =
      StreamController<void>.broadcast();
  final StreamController isUserLoginSuccessfullyStreamController =
      StreamController<bool>();

  var loginObject = LoginObject("", "");

  final LoginUseCase _loginUseCase;
  LoginViewModel(this._loginUseCase);

  @override
  void dispose() {
    super.dispose();
    _userNameStreamController.close();
    _passwordStreamController.close();
    _loginButtonStreamController.close();
    isUserLoginSuccessfullyStreamController.close();
  }

  @override
  void start() {
    inputState.add(ContentState());
  }

  // inputs
  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputUserName => _userNameStreamController.sink;

  @override
  Sink get inputIsAllInputsValid => _loginButtonStreamController.sink;

  @override
  setPassword(String password) {
    inputPassword.add(password);
    loginObject = loginObject.copyWith(password: password);
    inputIsAllInputsValid.add(null); // send event to listener
  }

  @override
  setUserName(String userName) {
    inputUserName.add(userName);
    loginObject = loginObject.copyWith(userName: userName);
    inputIsAllInputsValid.add(null); // send event to listener
  }

  @override
  Future<void> login() async {
    inputState.add(LoadingState(
      stateRenderType: StateRenderType.popupLoadingState,
    ));
    (await _loginUseCase.execute(
            LoginUseCaseInput(loginObject.userName, loginObject.password)))
        .fold((failure) {
      // either left -->  failure
      inputState.add(ErrorState(
        stateRenderType: StateRenderType.popupErrorState,
        message: failure.message,
      ));
    }, (data) {
      // either right --> success
      print("=============== ${data}===============");
      inputState.add(ContentState());

      // Notifying the listeners that the use is login successfully
      isUserLoginSuccessfullyStreamController.add(true);
    });
  }

  // outputs
  @override
  Stream<bool> get outputPassword => _passwordStreamController.stream
      .map((password) => _isPasswordValid(password));

  @override
  Stream<bool> get outputUserName => _userNameStreamController.stream
      .map((userName) => _isUserNameValid(userName));

  // this will get trigger every time we add (sink) an event
  @override
  Stream<bool> get outputIsAllInputsValid =>
      _loginButtonStreamController.stream.map((_) => _isAllInputsValid());

  bool _isPasswordValid(String password) {
    return password.isNotEmpty;
  }

  bool _isUserNameValid(String userName) {
    return userName.isNotEmpty;
  }

  bool _isAllInputsValid() {
    return _isPasswordValid(loginObject.password) &&
        _isUserNameValid(loginObject.userName);
  }
}

abstract class LoginViewModelInputs {
  // events and actions send from view
  setUserName(String userName);
  setPassword(String password);
  login();

  Sink get inputUserName;
  Sink get inputPassword;
  Sink get inputIsAllInputsValid;
}

abstract class LoginViewModelOutputs {
  Stream<bool> get outputUserName;
  Stream<bool> get outputPassword;
  Stream<bool> get outputIsAllInputsValid;
}
