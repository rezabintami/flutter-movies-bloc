import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/presentation/blocs/now_playing/now_playing_bloc.dart';
import 'package:tv/presentation/blocs/popular/popular_bloc.dart';
import 'package:tv/presentation/blocs/top_rated/top_rated_bloc.dart';

class TVPage extends StatefulWidget {
  @override
  _TVPageState createState() => _TVPageState();
}

class _TVPageState extends State<TVPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      BlocProvider.of<NowPlayingBloc>(context, listen: false)
          .add(GetNowPlayingFetch());
      BlocProvider.of<PopularBloc>(context, listen: false).add(PopularFetch());
      BlocProvider.of<TopRatedBloc>(context, listen: false)
          .add(TopRatedFetch());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(isMovie: false),
      appBar: AppBar(
        title: Text('Ditonton'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SEARCH_TV_PAGE);
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Now Playing',
                style: kHeading6,
              ),
              BlocBuilder<NowPlayingBloc, NowPlayingState>(
                  builder: (context, state) {
                if (state is NowPlayingLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is NowPlayingLoaded) {
                  return TVList(state.tv);
                } else if (state is NowPlayingError) {
                  return Center(
                    key: Key('error_message'),
                    child: Text(state.message),
                  );
                } else {
                  return Container();
                }
              }),
              _buildSubHeading(
                title: 'Popular',
                onTap: () => Navigator.pushNamed(context, POPULAR_TV_PAGE),
              ),
              BlocBuilder<PopularBloc, PopularState>(builder: (context, state) {
                if (state is PopularLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is PopularLoaded) {
                  return TVList(state.tv);
                } else if (state is PopularError) {
                  return Center(
                    key: Key('error_message'),
                    child: Text(state.message),
                  );
                } else {
                  return Container();
                }
              }),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () => Navigator.pushNamed(context, TOP_RATED_TV_PAGE),
              ),
              BlocBuilder<TopRatedBloc, TopRatedState>(
                  builder: (context, state) {
                if (state is TopRatedLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TopRatedLoaded) {
                  return TVList(state.tv);
                } else if (state is TopRatedError) {
                  return Center(
                    key: Key('error_message'),
                    child: Text(state.message),
                  );
                } else {
                  return Container();
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class TVList extends StatelessWidget {
  final List<TV> tv;

  TVList(this.tv);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final allTv = tv[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  DETAIL_TV_PAGE,
                  arguments: allTv.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${allTv.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tv.length,
      ),
    );
  }
}
