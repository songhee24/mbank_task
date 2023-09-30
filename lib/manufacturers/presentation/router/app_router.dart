import 'package:flutter/material.dart';
import 'package:mbank_task/manufacturers/presentation/view/mfr_details_view.dart';
import 'package:mbank_task/manufacturers/presentation/view/manufacturers_view.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MfrDetailsView.routeName:
        return MaterialPageRoute(
          builder: (_) =>
              const MfrDetailsView(title: 'Manufacturer details screen'),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const ManufacturersView(title: 'Manufacturer List'),
        );
    }
  }
}
