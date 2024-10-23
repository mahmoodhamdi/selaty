import 'package:dartz/dartz.dart';
import 'package:selaty/features/auth/data/models/login_req_body.dart';
import 'package:selaty/features/auth/data/models/register_req_body.dart';

abstract class AuthRepo {
  Future<Either> register({required RegisterReqBody registerReqBody});
  Future<Either> login({required LoginReqBody loginReqBody});
}
