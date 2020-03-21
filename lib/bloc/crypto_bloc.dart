import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:crypto_tutorial/models/coin_model.dart';
import 'package:crypto_tutorial/repositories/crypto_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'crypto_event.dart';
part 'crypto_state.dart';

class CryptoBloc extends Bloc<CryptoEvent, CryptoState> {
  final CryptoRepository _cryptoRepository;

  CryptoBloc({@required CryptoRepository cryptoRepository})
  : assert(cryptoRepository != null), _cryptoRepository = cryptoRepository;

  @override
  CryptoState get initialState => CryptoInitial();

  @override
  Stream<CryptoState> mapEventToState(
    CryptoEvent event,
  ) async* {
    if (event is AppStart ) {
      yield* _mapAppStartToState();
    } else if ( event is RefreshCoins ) {
      yield* _fetchCoins(coins: []);
    } else if (event is FetchMoreCoins ) {
      yield* _mapFetchMoreCoinsToState(event);
    }
    else yield CryptoError();
  }

  Stream<CryptoState> _fetchCoins({List<Coin> coins, int page = 0}) async* {
    try {
      List<Coin> newCoins = coins + await _cryptoRepository.getTopCoins(page: page);
      yield CryptoLoaded(coins: newCoins);
    } catch (err) {
      yield CryptoError();
    }
  }

  Stream<CryptoState> _mapAppStartToState() async* {
    yield CryptoLoading();
    yield* _fetchCoins(coins: []);
  }

  Stream<CryptoState> _mapFetchMoreCoinsToState(FetchMoreCoins event) async* {
    final int nextPage = event.coins.length ~/ CryptoRepository.perPage;
    yield* _fetchCoins(coins: event.coins, page: nextPage);
  }
}


