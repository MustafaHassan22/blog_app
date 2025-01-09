import 'package:blogapp/core/error/exceptions.dart';
import 'package:blogapp/features/auth/data/model/user_modle.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSource {
  Future<UserModle> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });
  Future<UserModle> loginWithEmailPassword({
    required String email,
    required String password,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;

  AuthRemoteDataSourceImpl(this.supabaseClient);
  @override
  Future<UserModle> loginWithEmailPassword(
      {required String email, required String password}) async {
    try {
      final response = await supabaseClient.auth.signInWithPassword(
        password: password,
        email: email,
      );
      if (response.user == null) {
        throw ServerException('user not found');
      }
      return UserModle.fromJson(response.user!.toJson());
    } on Exception catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModle> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signUp(
        password: password,
        email: email,
        data: {
          'name': name,
        },
      );
      if (response.user == null) {
        throw ServerException('User is null');
      }
      return UserModle.fromJson(response.user!.toJson());
    } on Exception catch (e) {
      throw ServerException(e.toString());
    }
  }
}
