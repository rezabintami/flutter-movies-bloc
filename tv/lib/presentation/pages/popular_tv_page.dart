import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/presentation/blocs/popular/popular_bloc.dart';
import 'package:tv/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';

class PopularTVPage extends StatefulWidget {
  @override
  _PopularTVPageState createState() => _PopularTVPageState();
}

class _PopularTVPageState extends State<PopularTVPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => BlocProvider.of<PopularBloc>(context, listen: false)
        .add(PopularFetch()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular TV'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child:
            BlocBuilder<PopularBloc, PopularState>(builder: (context, state) {
          if (state is PopularLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is PopularLoaded) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final allTv = state.tv[index];
                return TVCard(allTv);
              },
              itemCount: state.tv.length,
            );
          } else if (state is PopularError) {
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
        }),
      ),
    );
  }
}
