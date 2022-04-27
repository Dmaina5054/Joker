import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mpya/home/bloc/home_bloc.dart';
import 'package:mpya/services/connectivityService.dart';
import 'package:mpya/services/jokeService.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(RepositoryProvider.of<JokeService>(context),
          RepositoryProvider.of<ConnectivityService>(context))
        ..add(LoadApiEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Jokes for lame people'),
        ),
        body: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
          //evaluate state and show desired ui
          if (state is HomeLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          //loaded state
          if (state is HomeLoadedState) {
            return Column(
              children: [
                Text(state.jokeCategory),
                Text(state.jokeType),
                Text(state.jokeId.toString()),
                Text(state.delivery),
                Text(state.setup),
                ElevatedButton(
                    onPressed: () =>
                        BlocProvider.of<HomeBloc>(context).add(LoadApiEvent()),
                    child: const Text('Refresh Joke'))
              ],
            );
          }
          if (state is HomeNoInternetState) {
            return Text('NO internet');
          }
          return Container();
        }),
      ),
    );
  }
}
