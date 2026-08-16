import 'package:fonli_app/core/components/base_viewmodel.dart';

final class AuthViewModel extends FViewModel {
  final bool isLogin;
  final bool isLoading;

  AuthViewModel({this.isLogin = true, this.isLoading = false});

  AuthViewModel copyWith({bool? isLogin, bool? isLoading}) {
    return AuthViewModel(
      isLogin: isLogin ?? this.isLogin,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
