import 'package:crypto_tutorial/repositories/crypto_repository.dart';
import 'package:crypto_tutorial/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/bloc.dart';


// debugging bloc
class SimpleBlocDelegate extends BlocDelegate {
  @override
  onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }
}

// void main() => runApp(MyApp());
void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();

  // final CryptoRepository _cryptoRepositor = CryptoRepository();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Crypto Cuan',
        theme: ThemeData(
            primaryColor: Colors.grey[900],
            // accentColor: Colors.greenAccent,
            accentColor: Colors.indigoAccent[100]),
        home: MultiBlocProvider(providers: [
          BlocProvider<CryptoBloc>(
            create: (BuildContext context) => CryptoBloc(
              cryptoRepository: CryptoRepository()
              )..add(AppStart()),
          )
        ], child: HomeScreen()),
      );
  }
}
