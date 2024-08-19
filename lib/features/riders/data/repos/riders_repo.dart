import 'package:dartz/dartz.dart';
import 'package:tayar_admin_panel/core/networks/errors.dart';
import 'package:tayar_admin_panel/features/Hubs/data/models/rider_model.dart';
import 'package:tayar_admin_panel/features/Managers/data/models/manager_model/hub.dart';

abstract class RidersRepo {
  Future<Either<Failure,List<RiderModel>>> getRiders();
  Future<Either<Failure,RiderModel>> addRider(String name,String nationalId,String mobileNumber,String password);
  Future<Either<Failure,RiderModel>> deleteRider(int id);
  Future<Either<Failure,RiderModel>> updateRider(RiderModel rider);
  Future<Either<Failure,List<Hub>>> fetchHubs();
  Future<Either<Failure,RiderModel>> changeRiderHub(int riderId,int hubId);
  Future<Either<Failure,RiderModel>> changeRiderShiftTime(int riderId,DateTime startTime,Duration shiftDuration);
}