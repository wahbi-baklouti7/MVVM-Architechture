import 'package:flutter/material.dart';
import 'package:mvvm_architechture/app/app_prefs.dart';
import 'package:mvvm_architechture/app/di.dart';
import 'package:mvvm_architechture/presentation/common/state_render/state.render.impl.dart';
import 'package:mvvm_architechture/presentation/login/view_model/login_view_model.dart';
import 'package:mvvm_architechture/presentation/resources/assets_manager.dart';
import 'package:mvvm_architechture/presentation/resources/color_manager.dart';
import 'package:mvvm_architechture/presentation/resources/routes_manager.dart';
import 'package:mvvm_architechture/presentation/resources/string_manager.dart';
import 'package:mvvm_architechture/presentation/resources/values_manager.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final LoginViewModel _loginViewModel = instance<LoginViewModel>();
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _userNameTextController = TextEditingController();
  final AppPreferences _appPreferences = instance<AppPreferences>();
  final GlobalKey _formKey = GlobalKey<FormState>();
  void _bind() {
    _loginViewModel.start();
    _passwordTextController.addListener(
        () => _loginViewModel.setPassword(_passwordTextController.text));
    _userNameTextController.addListener(
        () => _loginViewModel.setUserName(_userNameTextController.text));

        _loginViewModel.isUserLoginSuccessfullyStreamController.stream.listen((isUserLogin) {

            if(isUserLogin){
              _appPreferences.setIsLoggedIn();
              Navigator.pushReplacementNamed(context, Routes.mainRoute);
            }
         });
  }

  @override
  void initState() {
    super.initState();
    _bind();
  }

  @override
  void dispose() {
    _loginViewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: StreamBuilder<FlowState>(
          stream: _loginViewModel.outputState,
          builder: (context, snapshot) {
            return snapshot.data?.getScreenWidget(context,
                    contentScreenWidget: LoginScreenContent(
                        formKey: _formKey,
                        loginViewModel: _loginViewModel,
                        userNameTextController: _userNameTextController,
                        passwordTextController: _passwordTextController),
                    retryActionFunction: () {}) ??
                LoginScreenContent(
                    formKey: _formKey,
                    loginViewModel: _loginViewModel,
                    userNameTextController: _userNameTextController,
                    passwordTextController: _passwordTextController);
          }),
    );
  }
}

class LoginScreenContent extends StatelessWidget {
  const LoginScreenContent({
    Key? key,
    required GlobalKey<State<StatefulWidget>> formKey,
    required LoginViewModel loginViewModel,
    required TextEditingController userNameTextController,
    required TextEditingController passwordTextController,
  })  : _formKey = formKey,
        _loginViewModel = loginViewModel,
        _userNameTextController = userNameTextController,
        _passwordTextController = passwordTextController,
        super(key: key);

  final GlobalKey<State<StatefulWidget>> _formKey;
  final LoginViewModel _loginViewModel;
  final TextEditingController _userNameTextController;
  final TextEditingController _passwordTextController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: AppPadding.p100),
      color: ColorManager.white,
      child: SingleChildScrollView(
          child: Form(
        key: _formKey,
        child: Column(
          children: [
            const Center(
                child: Image(
              image: AssetImage(ImagesAsset.splashLogo),
            )),
            const SizedBox(
              height: AppSize.s40,
            ),
            // user name
            Padding(
              padding: const EdgeInsets.only(
                  left: AppPadding.p40, right: AppPadding.p40),
              child: StreamBuilder<bool>(
                  stream: _loginViewModel.outputUserName,
                  builder: (context, snapshot) {
                    return TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: _userNameTextController,
                      decoration: InputDecoration(
                          hintText: AppString.userName,
                          labelText: AppString.userName,
                          errorText: (snapshot.data ?? true)
                              ? null
                              : AppString.userNameError),
                    );
                  }),
            ),
            const SizedBox(
              height: AppSize.s20,
            ),
            // password
            Padding(
              padding: const EdgeInsets.only(
                  left: AppPadding.p40, right: AppPadding.p40),
              child: StreamBuilder<bool>(
                  stream: _loginViewModel.outputPassword,
                  builder: (context, snapshot) {
                    return TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: _passwordTextController,
                      decoration: InputDecoration(
                          hintText: AppString.password,
                          labelText: AppString.password,
                          errorText: (snapshot.data ?? true)
                              ? null
                              : AppString.passwordError),
                    );
                  }),
            ),
            const SizedBox(
              height: AppSize.s20,
            ),
            // login button
            Padding(
              padding: const EdgeInsets.only(
                  left: AppPadding.p40, right: AppPadding.p40),
              child: StreamBuilder<bool>(
                  stream: _loginViewModel.outputIsAllInputsValid,
                  builder: (context, snapshot) {
                    return SizedBox(
                      width: double.infinity,
                      height: AppSize.s40,
                      child: ElevatedButton(
                        onPressed: (snapshot.data ?? false)
                            ? () {
                                _loginViewModel.login();
                              }
                            : null,
                        child: const Text(AppString.login),
                      ),
                    );
                  }),
            ),
            const SizedBox(
              height: AppSize.s20,
            ),
            // forget password
            Padding(
                padding: const EdgeInsets.only(
                    left: AppPadding.p40, right: AppPadding.p40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: () => Navigator.pushNamed(
                            context, Routes.forgotPasswordRoute),
                        child: Text(
                          AppString.forgetPassword,
                          style: Theme.of(context).textTheme.titleMedium,
                        )),
                    TextButton(
                        onPressed: () =>
                            Navigator.pushNamed(context, Routes.registerRoute),
                        child: Text(
                          AppString.signUp,
                          style: Theme.of(context).textTheme.titleMedium,
                        )),
                  ],
                )),
          ],
        ),
      )),
    );
  }
}
