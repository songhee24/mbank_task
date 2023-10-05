import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mbank_task/manufacturers/bloc/mfr_bloc.dart';

// 'Manufacturer details screen'
class MfrDetailsView extends StatefulWidget {
  static const routeName = 'details_page';
  const MfrDetailsView({
    super.key,
    required this.id,
  });

  final int id;

  @override
  State<MfrDetailsView> createState() => _MfrDetailsViewState();
}

class _MfrDetailsViewState extends State<MfrDetailsView> {

      
  @override
  Widget build(BuildContext context) {
      final mfrBloc = BlocProvider.of<MfrBloc>(context)
      ..add(MfrFetchedById(manufacturerId: widget.id));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manufacturer details screen'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
      ),
      body: BlocBuilder(
        bloc: mfrBloc,
        builder: (context, state) {
          if (state is MfrDetailsState) {
            switch (state.status) {
              case RequestStatus.failure:
                return const Center(
                    child: Text('failed to fetch manufacturers'));
              case RequestStatus.success:
                return Column(
                  children: [Text(state.mfrDetailsModel!.mfrName)],
                );
              case RequestStatus.initial:
                return const Center(child: CircularProgressIndicator());
            }
          }
          return const Text('Nihao');
        },
      ),
    );
  }

  @override
  void initState() {
    context.read<MfrBloc>().add(MfrFetchedById(manufacturerId: widget.id));
    super.initState();
  }
}
