import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rlg/core/errors/errors.dart';
import 'package:rlg/domain/repositories/auth_repository.dart';
import 'package:rlg/injection.dart';

extension FireStoreExt on FirebaseFirestore {
  Future<DocumentReference> userDocument() async {
    final userOption = sl<AuthRepository>().getSignedInUser();

    final user = userOption.getOrElse(() => throw NotAuthenticatedError());

    return FirebaseFirestore.instance.collection("users").doc(user.id.value);
  }

  Future<DocumentReference> pointsDocument() async {
    final userOption = sl<AuthRepository>().getSignedInUser();

    final user = userOption.getOrElse(() => throw NotAuthenticatedError());

    return FirebaseFirestore.instance.collection("points").doc(user.id.value);
  }
}

extension DocumentReferenceExt on DocumentReference {
  CollectionReference<Map<String, dynamic>> get tomorrowQuestCollection =>
      collection("tomorrowQuest");

  CollectionReference<Map<String, dynamic>> get questCollection =>
      collection("quests");

  CollectionReference<Map<String, dynamic>> get pointsCollection =>
      collection("points");

  CollectionReference<Map<String, dynamic>> get activityCollection =>
      collection("activity");
}
