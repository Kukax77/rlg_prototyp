

import 'package:firebase_auth/firebase_auth.dart';
import 'package:rlg/domain/entities/id.dart';
import 'package:rlg/domain/entities/user.dart';

extension FirebaseUserMapper on User{

  CustomUser toDomain(){
    return CustomUser(id: UniqueId.fromUniqueString(uid));
  }
}