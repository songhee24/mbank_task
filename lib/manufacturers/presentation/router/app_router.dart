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
        path: MfrDetailsView.routeName,
        builder: (context, state) {
          // final id = state.params['id']!;
          return const MfrDetailsView();
        }),
  ],
);
