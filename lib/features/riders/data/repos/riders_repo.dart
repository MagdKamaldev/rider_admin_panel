import 'package:dartz/dartz.dart';
import 'package:tayar_admin_panel/core/networks/errors.dart';
import 'package:tayar_admin_panel/features/Hubs/data/models/rider_model.dart';

abstract class RidersRepo {
  Future<Either<Failure,List<RiderModel>>> getRiders();
  Future<Either<Failure,RiderModel>> addRider(RiderModel rider);
  Future<Either<Failure,RiderModel>> deleteRider(int id);
  Future<Either<Failure,RiderModel>> updateRider(RiderModel rider);
}