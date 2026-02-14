import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/models/user_model.dart';

final searchUsersProvider =
    FutureProvider.family<List<UserModel>, ({String query, String role})>((
      ref,
      params,
    ) async {
      final client = Supabase.instance.client;

      var request = client
          .from('users')
          .select()
          .ilike('name', '%${params.query}%');

      if (params.role != "All") {
        request = request.eq('role', params.role);
      }

      final response = await request;

      return (response as List).map((e) => UserModel.fromMap(e)).toList();
    });
