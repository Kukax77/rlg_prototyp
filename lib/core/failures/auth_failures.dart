
abstract class AuthFailure{}

class ServerFailure extends AuthFailure{}

class EmailAlredyInUseFailure extends AuthFailure{}

class InvalidEmailAndPasswordCombinationFailure extends AuthFailure{}