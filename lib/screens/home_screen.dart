import 'package:crypto_tutorial/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Top Coins'),
      // ),
      body: BlocBuilder<CryptoBloc, CryptoState>(
        builder: (BuildContext context, CryptoState state) {
          return Container(
          decoration:BoxDecoration(
            color: Theme.of(context).primaryColor
          ),
          child: _buildBody(state)
          );
        },
        ),
      );
  }

  _buildBody(CryptoState state) {
    if (state is CryptoLoading) {
      return Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor),
        ),
      );
    } else if (state is CryptoLoaded) {
      return RefreshIndicator(
            color: Colors.teal,
            onRefresh: () async {
              context.bloc<CryptoBloc>().add(RefreshCoins());
            },
              child: NotificationListener<ScrollNotification>(
                onNotification: (notification) => _onScroll(notification, state),
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: state.coins.length,
                    itemBuilder: (BuildContext context, int index) {
                      final coin = state.coins[index];
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ListTile(
                            leading: Text('${++index}', 
                            style: TextStyle(
                              color: Theme.of(context).accentColor,
                              fontWeight: FontWeight.w400,
                              )
                            ),
                            title: Text(
                              coin.name,
                              style: TextStyle(color: Colors.white),
                              ),
                            subtitle: Text(
                              coin.fullName,
                              style: TextStyle(color: Colors.white70),
                            ),
                            trailing: Text(
                              'Rp${coin.price.toStringAsFixed(2)}',
                              style: TextStyle(
                                color: Theme.of(context).accentColor,
                                fontWeight: FontWeight.w600,
                                ),
                              ),
                          ),
                        ],
                      );
                    }
                  ),
              )
              );
    } else if (state is CryptoError) {
      return Center(child: Text('Error loading coins!',
      style: TextStyle(
        color: Theme.of(context).accentColor,
        fontSize: 18,
      ),
      textAlign: TextAlign.center,
      ),
      );
    }
  }

  bool _onScroll(ScrollNotification notification, CryptoLoaded state) {
    if (notification is ScrollEndNotification && _scrollController.position.extentAfter == 0) {
      context.bloc<CryptoBloc>().add(FetchMoreCoins(coins: state.coins));
    }
    return false;
  }
}
