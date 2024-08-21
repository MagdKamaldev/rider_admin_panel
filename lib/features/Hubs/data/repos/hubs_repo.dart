import 'package:dartz/dartz.dart';
import 'package:tayar_admin_panel/core/networks/errors.dart';
import 'package:tayar_admin_panel/features/Managers/data/models/manager_model/hub.dart';
import 'package:tayar_admin_panel/features/Managers/data/models/manager_model/manager_model.dart';

abstract class HubsRepo {
  Future<Either<Failure, List<ManagerModel>>> getManagers();
  Future<Either<Failure, List<Hub>>> getHubs();
  Future<Either<Failure, Hub>> getHub(int id);
  Future<Either<Failure, dynamic>> createHub(
      String name, int managerId, double lat, double lng);
  Future<Either<Failure, dynamic>> updateHub(
      String name, int managerId, int id, double lat, double lng);
  Future<Either<Failure, dynamic>> deleteHub(int id);
}
