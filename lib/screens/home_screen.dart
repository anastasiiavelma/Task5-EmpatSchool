import 'package:flutter/material.dart';
import 'package:projects/providers/cart_provider.dart';
import 'package:projects/screens/shopping_cart_screen.dart';
import 'package:projects/utlis/constants.dart';
import 'package:projects/widgets/cards/greeting_card_widget.dart';
import 'package:projects/widgets/icons/cart_icon_widget.dart';
import 'package:projects/widgets/slivers/silver_bar_widget.dart';
import 'package:projects/widgets/list/items_list_widget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late CartProvider _cart;

  int? _cartTotalPrice;

  @override
  void initState() {
    super.initState();
    _cart = Provider.of<CartProvider>(context, listen: false);
    Provider.of<CartProvider>(context, listen: false).loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          CustomSliverAppBar(
            title: 'Will you \nhave some \nmore cakes?',
            clipper: CustomClipPath(),
            actions: [
              const CircleAvatar(
                radius: 40,
                backgroundImage: AssetImage('assets/images/item6.jpg'),
              ),
              IconButton(
                icon: Icon(Icons.settings,
                    color: Theme.of(context).colorScheme.secondary),
                onPressed: () {
                  Navigator.pushNamed(context, '/settings');
                },
              ),
            ],
          ),
          // SliverToBoxAdapter(
          //   child: GreetingCard(
          //     cartTotalPrice: _cartTotalPrice,
          //   ),
          // ),
          SliverPadding(
            padding: largePadding,
            sliver: ItemsList(
              onAddToCart: _cart.addToCart,
            ),
          ),
        ],
      ),
      floatingActionButton: Stack(
        alignment: Alignment.topRight,
        children: [
          _shoppingCartIcon(context),
          const CounterItemsIcon(),
        ],
      ),
    );
  }

  Widget _shoppingCartIcon(context) {
    return FloatingActionButton(
      onPressed: () async {
        final result = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CartScreen(
              items: _cart.itemsInCart,
              onRemoveItem: _cart.removeFromCart,
            ),
          ),
        );
        if (result != null) {
          setState(() {
            _cartTotalPrice = result;
          });
        }
      },
      backgroundColor: Theme.of(context).colorScheme.onBackground,
      shape: const CircleBorder(),
      child: SizedBox(
        width: 60.0,
        height: 60.0,
        child: Icon(
          Icons.shopping_cart,
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
    );
  }
}
