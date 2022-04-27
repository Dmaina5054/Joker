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
              child: CircularProgressIndicator(
                color: Colors.orangeAccent,
                backgroundColor: Colors.green,
              ),
            );
          }

          //loaded state
          if (state is HomeLoadedState) {
            return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                        shadowColor: Colors.green,
                        elevation: 5.2,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 30.0, right: 30),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                'Category ${state.jokeCategory}',
                                style: const TextStyle(
                                    fontSize: 30.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(state.delivery),
                              Text(
                                state.setup,
                                style: TextStyle(color: Colors.green),
                              ),
                              ElevatedButton(
                                  onPressed: () =>
                                      BlocProvider.of<HomeBloc>(context)
                                          .add(LoadApiEvent()),
                                  child: const Icon(
                                    Icons.refresh,
                                  ))
                            ],
                          ),
                        )),
                  ),
                ]);
          }
          if (state is HomeNoInternetState) {
            return Text('NO internet');
          }
          return Text('Something went wrong');
        }),
      ),
    );
  }
}
