import 'package:shelf/shelf_io.dart' as io;

import 'home_controller.dart';

void startServer() async {
  final homeController = HomeController();

  final server = await io.serve(homeController.handler, 'localhost', 8083);
  print('The server is running on ${server.port}...');
}
