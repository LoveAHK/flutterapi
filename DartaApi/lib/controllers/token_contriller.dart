import 'dart:async';
import 'dart:io';

import 'package:conduit_core/conduit_core.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';
import '../utils/app_responce.dart';
class AppTokenContoller extends Controller {
  @override
  FutureOr<RequestOrResponse?> handle(Request request) {
    try {
      // Получаем header из запроса
      final header = request.raw.headers.value(HttpHeaders.authorizationHeader);
      // Из header получаем token
      final token = const AuthorizationBearerParser().parse(header);

      // Получаем jwtClaim для проверки token
      final jwtClaim = verifyJwtHS256Signature(token ?? "", "SECRET_KEY");
      // Валидируем наш token
      jwtClaim.validate();
      return request;
    } on JwtException catch (e) {
      return AppResponse.serverError(e.message);
    }
  }
}

