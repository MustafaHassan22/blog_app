import 'package:blogapp/core/error/exceptions.dart';
import 'package:blogapp/features/auth/data/model/user_modle.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSource {
  //to get the user id to check if it logedin or not
  Session? get currentUserSession;
  Future<UserModle> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });
  Future<UserModle> loginWithEmailPassword({
    required String email,
    required String password,
  });

  Future<UserModle?> getUserCurrentData();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;

  AuthRemoteDataSourceImpl(this.supabaseClient);

  @override
  Session? get currentUserSession => supabaseClient.auth.currentSession;

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
      return UserModle.fromJson(response.user!.toJson())
          .copyWith(email: currentUserSession!.user.email);
    } on AuthException catch (e) {
      throw ServerException(e.message);
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
      return UserModle.fromJson(response.user!.toJson())
          .copyWith(email: currentUserSession!.user.email);
    } on AuthException catch (e) {
      throw ServerException(e.message);
    } on Exception catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModle?> getUserCurrentData() async {
    try {
      // Check if a session exists
      if (currentUserSession != null) {
        final userData = await supabaseClient
            .from('profiles')
            .select() // Select all columns
            .eq('id', currentUserSession!.user.id);
        // Convert the first row of the result into a UserModle object
        return UserModle.fromJson(userData.first)
            .copyWith(email: currentUserSession!.user.email);
      }
      return null;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
