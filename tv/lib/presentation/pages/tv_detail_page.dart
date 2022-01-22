import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:tv/domain/entities/entities.dart';
import 'package:tv/presentation/blocs/detail/detail_bloc.dart';

class TVDetailPage extends StatefulWidget {
  final int id;
  TVDetailPage({required this.id});

  @override
  _TVDetailPageState createState() => _TVDetailPageState();
}

class _TVDetailPageState extends State<TVDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      BlocProvider.of<DetailBloc>(context, listen: false)
        ..add(RequestDetail(widget.id))
        ..add(LoadStatusWatchlist(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<DetailBloc, DetailState>(
          listenWhen: (previous, current) =>
              previous.watchlistMessage != current.watchlistMessage &&
              current.watchlistMessage != '',
          listener: (context, state) {
            final message = state.watchlistMessage;
            if (message == watchlistAddSuccessMessage ||
                message == watchlistRemoveSuccessMessage) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(message)));
            } else {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Text(message),
                    );
                  });
            }
          },
          builder: (context, state) {
            if (state.tvDetailState == RequestState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.tvDetailState == RequestState.Loaded) {
              final movie = state.tvDetail;
              return SafeArea(
                child: DetailContent(
                  movie,
                  state.tvRecommendations,
                  state.isAddedToWatchlist,
                ),
              );
            } else {
              return Text(state.message);
            }
          }),
    );
  }
}

class DetailContent extends StatelessWidget {
  final TVDetail tv;
  final List<TV> recommendations;
  final bool isAddedWatchlist;

  DetailContent(this.tv, this.recommendations, this.isAddedWatchlist);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${tv.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tv.name,
                              style: kHeading5,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                if (!isAddedWatchlist) {
                                  context
                                      .read<DetailBloc>()
                                      .add(AddToWatchlist(tv));
                                } else {
                                  context
                                      .read<DetailBloc>()
                                      .add(RemoveFromWatchlist(tv));
                                }
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  isAddedWatchlist
                                      ? Icon(Icons.check)
                                      : Icon(Icons.add),
                                  Text('Watchlist'),
                                ],
                              ),
                            ),
                            Text(
                              _showGenres(tv.genres),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: tv.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${tv.voteAverage}')
                              ],
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              tv.overview,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Season',
                              style: kHeading6,
                            ),
                            tv.lastEpisode != null
                                ? ShowSeason(tv.season)
                                : Text(
                                    'No season',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                            SizedBox(height: 16),
                            Text(
                              'Last Episode',
                              style: kHeading6,
                            ),
                            tv.lastEpisode != null
                                ? ShowEpisode(tv.lastEpisode)
                                : Text(
                                    'No episode',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                            SizedBox(height: 16),
                            Text(
                              'Next Episode',
                              style: kHeading6,
                            ),
                            tv.nextEpisode != null
                                ? ShowEpisode(tv.nextEpisode)
                                : Text(
                                    'No episode',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                            SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            BlocBuilder<DetailBloc, DetailState>(
                                builder: (context, state) {
                              if (state.tvRecommendationsState ==
                                  RequestState.Loading) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (state.tvRecommendationsState ==
                                  RequestState.Error) {
                                return Text(state.message);
                              } else if (state.tvRecommendationsState ==
                                  RequestState.Loaded) {
                                return Container(
                                  height: 150,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      final tv = recommendations[index];
                                      return Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.pushReplacementNamed(
                                              context,
                                              DETAIL_MOVIE_PAGE,
                                              arguments: tv.id,
                                            );
                                          },
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(8),
                                            ),
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  'https://image.tmdb.org/t/p/w500${tv.posterPath}',
                                              placeholder: (context, url) =>
                                                  Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Icon(Icons.error),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    itemCount: recommendations.length,
                                  ),
                                );
                              } else {
                                return Container();
                              }
                            }),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += genre.name + ', ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }
}

class ShowEpisode extends StatelessWidget {
  final Episode? episode;

  ShowEpisode(this.episode);

  @override
  Widget build(BuildContext context) {
    print("path : ${episode?.stillPath}");

    return Container(
        height: 200,
        width: 200,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: InkWell(
            onTap: () {},
            child: ClipRRect(
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
              child: CachedNetworkImage(
                imageUrl:
                    'https://image.tmdb.org/t/p/w500${episode?.stillPath}',
                placeholder: (context, url) => Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
          ),
        ));
  }
}

class ShowSeason extends StatelessWidget {
  final List<Season> season;

  ShowSeason(this.season);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tv = season[index];
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: InkWell(
              onTap: () {
                Navigator.pushReplacementNamed(
                  context,
                  DETAIL_TV_PAGE,
                  arguments: tv.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
                child: CachedNetworkImage(
                  imageUrl: 'https://image.tmdb.org/t/p/w500${tv.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: season.length,
      ),
    );
  }
}
