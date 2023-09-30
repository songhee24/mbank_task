import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mbank_task/manufacturers/bloc/mfr_bloc.dart';
import 'package:mbank_task/manufacturers/presentation/widgets/bottom_loader.dart';
import 'package:mbank_task/manufacturers/presentation/widgets/mfr_list_item.dart';

class MfrInfinityList extends StatefulWidget {
  const MfrInfinityList({super.key});

  @override
  State<MfrInfinityList> createState() => _MfrInfinityListState();
}

class _MfrInfinityListState extends State<MfrInfinityList> {
  final _scrollController = ScrollController();
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MfrBloc, MfrState>(
      builder: (context, state) {
        switch (state.status) {
          case RequestStatus.failure:
            return const Center(child: Text('failed to fetch manufacturers'));
          case RequestStatus.success:
            if (state.manufacturers.isEmpty) {
              return const Center(child: Text('no manufacturers'));
            }
            return ListView.builder(
              itemBuilder: (
                BuildContext context,
                int index,
              ) {
                return index >= state.manufacturers.length
                    ? const BottomLoader()
                    : MfrListItem(manufacturer: state.manufacturers[index]);
              },
              itemCount: state.hasReachedMax
                  ? state.manufacturers.length
                  : state.manufacturers.length + 1,
              controller: _scrollController,
            );
          case RequestStatus.initial:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }

  void _onScroll() {
    if (_debounceTimer != null && _debounceTimer!.isActive) {
      _debounceTimer!.cancel();
    }

    _debounceTimer = Timer(const Duration(milliseconds: 300), () {
      if (_isBottom) {
        context.read<MfrBloc>().add(MfrFetched());
      }
    });
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    const tolerance = 50.0;
    return maxScroll - currentScroll <= tolerance;
  }
}
