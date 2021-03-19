import 'package:app_movie/app_container.dart';
import 'package:app_movie/bloc/search_bloc.dart';
import 'package:app_movie/display_connect_internet.dart';
import 'package:app_movie/model/movie.dart';
import 'package:app_movie/screens/movie/widgets/item_movie.dart';
import 'package:app_movie/wigets/list_item_builder.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String text = '';
  SearchBloc _searchBloc;
  ValueNotifier<String> textSearch;

  @override
  void initState() {
    _searchBloc = SearchBloc();
    textSearch = ValueNotifier('');
    super.initState();
  }

  @override
  void didChangeDependencies() {
    print('----------------> didChangeDependencies');
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      hidePadding: true,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                onSubmitted: (String value) {
                  textSearch.value = value;
                  _searchBloc.onSearchMovies(text: value);
                },
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search, color: Colors.grey,),
                    hintText: 'Enter movie',
                    fillColor: Colors.white,
                    filled: true),
              ),
              StreamBuilder<List<Movie>>(
                initialData: [],
                stream: _searchBloc.searchMovies,
                builder:
                    (BuildContext ctx, AsyncSnapshot<List<Movie>> snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data.isEmpty) {
                      return ValueListenableBuilder<String>(valueListenable: textSearch, builder: (BuildContext ctx, String text, Widget child){
                        if (text.isNotEmpty) {
                          return Container(
                            height: MediaQuery.of(context).size.height,
                            alignment: Alignment.center,
                            child: const Text('Not found movie you searching'),
                          );
                        } else {
                          return Container();
                        }
                      });
                    }
                    if (snapshot.data[0].error != null) {
                      return DisplayConnectInternet(
                        message: snapshot.data[0].error,
                        showAppBar: false,
                      );
                    }
                    return Container(
                      height: MediaQuery.of(context).size.height,
                      padding: const EdgeInsets.only(top: 20.0),
                      child: ListItemBuilder<Movie>(
                        items: snapshot.data,
                        itemBuilder: (BuildContext ctx, Movie movie) {
                          return ItemMovie(
                            movie: movie,
                          );
                        },
                      ),
                    );
                  }
                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchBloc.onDispose();
    textSearch.dispose();
    print('----------------> dispose SearchBloc');
    super.dispose();
  }
}
