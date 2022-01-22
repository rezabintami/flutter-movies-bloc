import 'package:core/core.dart';
import 'package:ditonton/presentation/blocs/watchlist/watchlist_bloc.dart';
import 'package:ditonton/presentation/widgets/watchlist_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class WatchlistMoviesPage extends StatefulWidget {
  @override
  _WatchlistMoviesPageState createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        BlocProvider.of<WatchlistBloc>(context, listen: false)
            .add(WatchlistFetch()));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    BlocProvider.of<WatchlistBloc>(context, listen: false)
        .add(WatchlistFetch());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<WatchlistBloc, WatchlistState>(
            builder: (context, state) {
          if (state is WatchlistLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is WatchlistLoaded) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final watchlist = state.watchlist[index];
                return WatchlistCard(watchlist);
              },
              itemCount: state.watchlist.length,
            );
          } else if (state is WatchlistError) {
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

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
