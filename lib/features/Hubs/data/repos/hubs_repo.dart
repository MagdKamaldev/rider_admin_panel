import 'package:dartz/dartz.dart';
import 'package:tayar_admin_panel/core/networks/errors.dart';
import 'package:tayar_admin_panel/features/Managers/data/models/manager_model/hub.dart';
import 'package:tayar_admin_panel/features/Managers/data/models/manager_model/manager_model.dart';

abstract class HubsRepo {
  Future<Either<Failure, List<ManagerModel>>> getManagers();
  Future<Either<Failure, List<Hub>>> getHubs();
  Future<Either<Failure, Hub>> getHub(int id);
  Future<Either<Failure, dynamic>> createHub(String name, int managerId);
  Future<Either<Failure, dynamic>> updateHub(Hub hub);
  Future<Either<Failure, dynamic>> deleteHub(int id);
}
