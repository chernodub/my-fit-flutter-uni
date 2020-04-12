import 'package:http_interceptor/http_interceptor.dart';
import 'package:my_fit/models/user.dart';

class AuthInterceptor extends InterceptorContract {
  /// User.
  final User user;

  AuthInterceptor(this.user);

  @override
  Future<RequestData> interceptRequest({RequestData data}) async {
    data.headers['Authorization'] =
        user != null ? 'Token ${user.meta.token}' : null;
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({ResponseData data}) async {
    return data;
  }
}
