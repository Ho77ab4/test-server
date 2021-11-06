import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import 'services/auth_service/auth_service.dart';
import 'services/todos_service/todo_service.dart';

class HomeController {
  Handler get handler {
    final router = Router();

    router.get('/', (Request request) {
      return Response.ok('Home controller');
    });

    router.mount('/todos', TodoService().router);
    router.mount('/auth', AuthService().router);

    router.all('/<ignored|.*>', (Request request) {
      return Response.notFound('Page is not found');
    });

    return router;
  }
}