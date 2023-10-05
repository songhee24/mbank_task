import 'package:go_router/go_router.dart';
import 'package:mbank_task/manufacturers/presentation/view/manufacturers_view.dart';
import 'package:mbank_task/manufacturers/presentation/view/mfr_details_view.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const ManufacturersView(),
    ),
    GoRoute(
        path: '/${MfrDetailsView.routeName}/:id',
        name: MfrDetailsView.routeName,
        builder: (context, state) {
          int id = int.parse(state.pathParameters['id']!);
          return MfrDetailsView(id: id);
        }),
  ],
);
