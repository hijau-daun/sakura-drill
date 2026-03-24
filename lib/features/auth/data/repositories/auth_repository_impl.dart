import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import '../../../../core/error/failures.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, User>> login(String email, String password) async {
    try {
      final firebaseUser = await remoteDataSource.login(email, password);
      if (firebaseUser != null) {
        return Right(_mapToEntity(firebaseUser));
      }
      return const Left(AuthFailure('User not found after login'));
    } on firebase.FirebaseAuthException catch (e) {
      return Left(AuthFailure(e.message ?? 'Unknown authentication error'));
    } catch (e) {
      return Left(AuthFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> register(String email, String password) async {
    try {
      final firebaseUser = await remoteDataSource.register(email, password);
      if (firebaseUser != null) {
        return Right(_mapToEntity(firebaseUser));
      }
      return const Left(AuthFailure('Registration failed'));
    } on firebase.FirebaseAuthException catch (e) {
      return Left(AuthFailure(e.message ?? 'Unknown registration error'));
    } catch (e) {
      return Left(AuthFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> logout() async {
    try {
      await remoteDataSource.logout();
      return const Right(unit);
    } catch (e) {
      return Left(AuthFailure(e.toString()));
    }
  }

  @override
  Stream<Option<User>> get userStatus =>
      remoteDataSource.userStream.map((firebaseUser) {
        if (firebaseUser == null) return const None();
        return Some(_mapToEntity(firebaseUser));
      });

  User _mapToEntity(firebase.User firebaseUser) {
    return User(
      id: firebaseUser.uid,
      email: firebaseUser.email ?? '',
      displayName: firebaseUser.displayName,
      photoUrl: firebaseUser.photoURL,
    );
  }
}
