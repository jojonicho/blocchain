part of 'crypto_bloc.dart';

abstract class CryptoEvent extends Equatable {
  const CryptoEvent();

  @override
  List<Object> get props => [];
}

class AppStart extends CryptoEvent {}

class RefreshCoins extends CryptoEvent {}

class FetchMoreCoins extends CryptoEvent {
  final List<Coin> coins;

  const FetchMoreCoins({this.coins});

  @override
  List<Object> get props => [coins];

  @override
  String toString() => 'FetchCoins { coins : $coins }';
}