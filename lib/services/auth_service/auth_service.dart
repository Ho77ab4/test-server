import 'dart:convert';
import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../../entities/user_entity.dart';
import '../../models/user.dart';

part 'auth_service.g.dart';

class AuthService {
  final List<UserEntity> _users = [];

  Router get router => _$AuthServiceRouter(this);

  @Route.post('/')
  Future<Response> createUser(Request request) async {
    try {
      final jsonUser = jsonDecode(await request.readAsString());
      final user = User.fromJson(jsonUser);

      if (_users.any((u) => u.email == user.email)) {
        return Response(HttpStatus.badRequest, body: jsonEncode({'error': 'That user already registred'}));
      }

      if (user.password != user.confirmPassword) {
        return Response(HttpStatus.badRequest, body: jsonEncode({'error': 'Your passwords doesn`t match'}));
      }

      final token = 'asdaksda,';
      final userEntity = UserEntity(
        id: _users.length.toString(),
        email: user.email,
        password: user.password,
        jwtToken: token,
      );
      _users.add(userEntity);

      return Response(HttpStatus.created, body: jsonEncode({'token': token}));
    } on Exception catch(e) {
      return Response(HttpStatus.badRequest, body: jsonEncode({'error': 'There are no such an object'}));
    }
  }

}