import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:tv/tv.dart';

class TopRatedTVPage extends StatefulWidget {
  @override
  _TopRatedTVPageState createState() => _TopRatedTVPageState();
}

class _TopRatedTVPageState extends State<TopRatedTVPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => BlocProvider.of<TopRatedBloc>(context, listen: false)
        .add(TopRatedFetch()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Rated TV'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedBloc, TopRatedState>(
          builder: (context, state) {
            if (state is TopRatedLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TopRatedLoaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final allTv = state.tv[index];
                  return TVCard(allTv);
                },
                itemCount: state.tv.length,
              );
            } else if (state is TopRatedError) {
              return Center(
                key: Key('error_message'),
                child: Text(state.message),
              );
            } else {
              return Center(
                key: Key('error_message'),
                child: Text('Something went wrong'),
              );
            }
          },
        ),
      ),
    );
  }
}
