import 'package:dartz/dartz.dart';
import 'package:tayar_admin_panel/core/networks/errors.dart';
import 'package:tayar_admin_panel/features/Branches/data/models/franchise_model/franchise_model.dart';

abstract class FranchiseRepo {
  Future<Either<Failure, List<FranchiseModel>>> getFranchises();
  Future<Either<Failure, dynamic>> addFranchise(String name);
  Future<Either<Failure, dynamic>> updateFranchise(FranchiseModel franchise);
  Future<Either<Failure, dynamic>> deleteFranchise(int id);
}
