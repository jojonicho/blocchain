part of 'crypto_bloc.dart';

abstract class CryptoState extends Equatable {
  const CryptoState();
  @override
  List<Object> get props => [];
}

class CryptoInitial extends CryptoState {

}

class CryptoEmpty extends CryptoState {

}

class CryptoLoading extends CryptoState {

}

class CryptoLoaded extends CryptoState {
  final List<Coin> coins;

  const CryptoLoaded( {this.coins} );

  @override
  List<Object> get props => [coins];

  @override
  String toString() => 'CryptoLoaded { coins: $coins }';

}

class CryptoError extends CryptoState {

}