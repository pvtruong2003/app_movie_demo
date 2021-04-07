import 'package:app_movie/app_container.dart';
import 'package:app_movie/bloc/search_bloc.dart';
import 'package:app_movie/common/style/color.dart';
import 'package:app_movie/common/style/fonts.dart';
import 'package:app_movie/model/movie.dart';
import 'package:app_movie/screens/home/search/item_popular.dart';
import 'package:app_movie/screens/home/search/item_recent.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchMovieScreen extends StatefulWidget {
  @override
  _SearchMovieScreenState createState() => _SearchMovieScreenState();
}

class _SearchMovieScreenState extends State<SearchMovieScreen> {
  SearchBloc searchBloc;
  List<Movie> moviesRecent = [
    Movie(
        id: 9738,
        title: 'Fantastic Four',
        posterPath: '/8HLQLILZLhDQWO6JDpvY6XJLH75.jpg'),
    Movie(
        id: 246655,
        title: 'X-Men: Apocalypse',
        posterPath: '/2mtQwJKVKQrZgTz49Dizb25eOQQ.jpg'),
    Movie(
        id: 527774,
        title: 'Raya and the Last Dragon',
        posterPath: '/lPsD10PP4rgUGiGR4CCXA6iY0QQ.jpg'),
    Movie(
        id: 4247,
        title: 'Blade',
        posterPath: '/e6ErRnIgKmoBtcKpht3amsMfo52.jpg'),
    Movie(
        id: 464052,
        title: 'Wonder Woman 1984',
        posterPath: '/8UlWHLMpgZm9bx6QYh0NFoq67TZ.jpg'),
  ];

  List<Movie> moviesPopular = [
    Movie(
        id: 399566,
        title: 'Godzilla vs. Kong',
        overview:
            '"During a space voyage, four scientists are altered by cosmic rays: Reed Richards gains the ability to stretch his body; Sue Storm can become invisible; Johnny Storm controls fire; and Ben Grimm is turned into a super-strong … thing. Together, these \"Fantastic Four\" must now thwart the evil plans of Dr. Doom and save the world from certain destruction.',
        posterPath: '/pgqgaUx1cJb5oZQQ5v0tNARCeBp.jpg'),
    Movie(
        id: 791373,
        title: 'Zack Snyder Justice League',
        overview:
            'After the re-emergence of the world first mutant, world-destroyer Apocalypse, the X-Men must unite to defeat his extinction level plan.',
        posterPath: '/tnAuB8q5vv7Ax9UAEje5Xi4BXik.jpg'),
    Movie(
        id: 527774,
        title: 'Raya and the Last Dragon',
        overview:
            'The Daywalker known as \"Blade\" - a half-vampire, half-mortal man - becomes the protector of humanity against an underground army of vampires.',
        posterPath: '/lPsD10PP4rgUGiGR4CCXA6iY0QQ.jpg'),
    Movie(
        id: 587807,
        title: 'Tom & Jerry',
        overview:
            'A rare mutation has occurred within the vampire community - The Reaper. A vampire so consumed with an insatiable bloodlust that they prey on vampires as well as humans, transforming victims who are unlucky enough to survive into Reapers themselves. Blade is asked by the Vampire Nation for his help in preventing a nightmare plague that would wipe out both humans and vampires.',
        posterPath: '/6KErczPBROQty7QoIsaa6wJYXZi.jpg'),
    Movie(
        id: 464052,
        title: 'Wonder Woman 1984',
        overview:
            'Mild-mannered Clark Kent works as a reporter at the Daily Planet alongside his crush, Lois Lane. Clark must summon his superhero alter-ego when the nefarious Lex Luthor launches a plan to take over the world.',
        posterPath: '/8UlWHLMpgZm9bx6QYh0NFoq67TZ.jpg'),
  ];

  @override
  void initState() {
    searchBloc = SearchBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppContainer(
       hidePadding: true,
        contentBackgroundColor: AppColor.black,
        containerBackgroundColor: AppColor.black,
        child: SingleChildScrollView(
          padding: EdgeInsets.only(top: 20, left: 16, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Text(
              'Search',
              style: TextStyle(
                  fontSize: AppFontSize.text,
                  fontWeight: AppFontWeight.normal,
                  color: AppColor.grayA6),
            ),
            TextField(
              onSubmitted: (String value) {
                searchBloc.onSearchMovies(text: value);
              },
              style: TextStyle(
                  fontSize: AppFontSize.label,
                  fontWeight: AppFontWeight.normal,
                  color: AppColor.white),
              decoration: InputDecoration(
                hintText: 'Movie, Actor, Directors...',
                hintStyle: TextStyle(
                    fontSize: AppFontSize.large,
                    fontWeight: AppFontWeight.medium,
                    color: AppColor.grayA6),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 12, horizontal: 0),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey)),
                disabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey)),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey)),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Recent',
                    style: TextStyle(
                        fontSize: AppFontSize.medium,
                        fontWeight: AppFontWeight.medium,
                        color: AppColor.white)),
                Text('SEE ALL',
                    style: TextStyle(
                        fontSize: AppFontSize.text,
                        fontWeight: AppFontWeight.normal,
                        color: AppColor.white)),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.37,
              child: ListView.builder(
                  itemCount: moviesRecent.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (ctx, index) {
                    return ItemRecent(
                      movie: moviesRecent[index],
                    );
                  }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Popular',
                    style: TextStyle(
                        fontSize: AppFontSize.medium,
                        fontWeight: AppFontWeight.medium,
                        color: AppColor.white)),
                Text('SEE ALL',
                    style: TextStyle(
                        fontSize: AppFontSize.text,
                        fontWeight: AppFontWeight.normal,
                        color: AppColor.white)),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                    itemCount: moviesPopular.length,
                    padding: EdgeInsets.only(bottom: 400),
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (ctx, index) {
                      return ItemPopular(movie: moviesPopular[index],);
                    }))
          ],
        )));
  }
}
