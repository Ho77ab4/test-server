// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_service.dart';

// **************************************************************************
// ShelfRouterGenerator
// **************************************************************************

Router _$TodoServiceRouter(TodoService service) {
  final router = Router();
  router.add('GET', r'/', service.getTodos);
  router.add('GET', r'/<id>', service.getTodoById);
  router.add('POST', r'/', service.postTodo);
  router.add('PUT', r'/<id>', service.putTodo);
  return router;
}
