import 'package:dartz/dartz.dart';
import 'package:tayar_admin_panel/core/networks/errors.dart';
import 'package:tayar_admin_panel/features/Managers/data/models/manager_model/manager_model.dart';

abstract class ManagersRepo {
  Future<Either<Failure, List<ManagerModel>>> getManagers();
  Future<Either<Failure, dynamic>> addManager(String name, String password);
  Future<Either<Failure, dynamic>> updateManager(String name, String password,int id);
  Future<Either<Failure, dynamic>> deleteManager(int id);
}
