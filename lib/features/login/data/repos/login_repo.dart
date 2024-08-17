import 'package:dartz/dartz.dart';
import 'package:tayar_admin_panel/core/networks/errors.dart';

abstract class LoginRepo {
  Future<Either<Failure, String>> login(String name, String password);
}
