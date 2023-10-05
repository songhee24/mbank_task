import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mbank_task/manufacturers/bloc/mfr_bloc.dart';
import 'package:mbank_task/manufacturers/presentation/widgets/mfr_details_list_item.dart';

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
    final mfrBloc = BlocProvider.of<MfrBloc>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Manufacturer details screen'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            mfrBloc.add(MfrFetched());
            context.pop();
          },
        ),
      ),
      body: BlocBuilder(
        bloc: mfrBloc,
        builder: (context, state) {
          if (state is MfrDetailsState) {
            final vehicleTypes = state.mfrDetailsModel?.vehicleTypes;
            switch (state.status) {
              case RequestStatus.failure:
                return const Center(
                    child: Text('failed to fetch manufacturers'));
              case RequestStatus.success:
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      state.mfrDetailsModel!.mfrName,
                      style: const TextStyle(
                        fontSize: 24,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(top: 36),
                        child: Material(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          child: ListView.builder(
                            itemCount: vehicleTypes?.length,
                            itemBuilder: ((context, index) {
                              if (vehicleTypes?[index] == null) {
                                return null;
                              }
                              return MfrDetailsListItem(
                                vehicleTypeModel: vehicleTypes![index],
                              );
                            }),
                          ),
                        ),
                      ),
                    )
                  ],
                );
              case RequestStatus.initial:
                return const Center(child: CircularProgressIndicator());
            }
          }
          if (state is MfrListState) {
            return const Text('List!!!');
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
