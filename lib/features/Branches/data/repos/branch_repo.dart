import 'package:dartz/dartz.dart';
import 'package:tayar_admin_panel/core/networks/errors.dart';
import 'package:tayar_admin_panel/features/Branches/data/models/branch_model.dart';
import 'package:tayar_admin_panel/features/Branches/data/models/franchise_model/franchise_model.dart';
import 'package:tayar_admin_panel/features/Managers/data/models/manager_model/hub.dart';

abstract class BranchRepo {
  Future<Either<Failure, BranchResponse>> getBranchData();
  Future<Either<Failure, void>> addShopBranch(
      String name, String address, int hubId, int franchiseId);
  Future<Either<Failure, List<BranchModel>>> getBranches();
  Future<Either<Failure, void>> deleteBranch(int id);
}

class BranchResponse {
  final List<FranchiseModel> franchises;
  final List<Hub> hubs;

  BranchResponse({
    required this.franchises,
    required this.hubs,
  });
}
