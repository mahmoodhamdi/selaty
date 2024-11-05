import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selaty/core/helpers/logger_helper.dart'; // Import LoggerHelper
import 'package:selaty/features/home/data/models/cart.dart';
import 'package:selaty/features/home/domain/usecases/add_to_cart_usecase.dart';
import 'package:selaty/features/home/domain/usecases/clear_cart_usecase.dart';
import 'package:selaty/features/home/domain/usecases/get_cart_usecase.dart';
import 'package:selaty/features/home/domain/usecases/remove_from_cart_usecase.dart';
import 'package:selaty/features/home/domain/usecases/update_cart_quantity_usecase.dart';
import 'package:selaty/features/home/presentation/logic/cart/cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final AddToCartUseCase addToCart;
  final RemoveFromCartUseCase removeFromCart;
  final GetCartItemsUseCase getCartItems;
  final ClearCartUseCase clearCart;
  final UpdateQuantityUseCase updateQuantity;

  CartCubit({
    required this.addToCart,
    required this.removeFromCart,
    required this.getCartItems,
    required this.clearCart,
    required this.updateQuantity,
  }) : super(CartInitial());

  Future<void> loadCartItems() async {
    LoggerHelper.info("Loading cart items");
    emit(CartLoading());
    try {
      final items = await getCartItems();
      LoggerHelper.debug("Cart items loaded: $items");
      emit(CartLoaded(items));
    } catch (e) {
      LoggerHelper.error("Error loading cart items", e);
      emit(CartError(e.toString()));
    }
  }

  Future<void> addItem(CartItem item) async {
    LoggerHelper.info("Adding item to cart: ${item.name}");
    try {
      await addToCart.call(item);
      LoggerHelper.debug("Item added: ${item.name}");
      loadCartItems(); // Optionally load the items again if needed
    } catch (e) {
      LoggerHelper.error("Error adding item to cart: ${item.name}", e);
    }
  }

  Future<void> removeItem(String itemId) async {
    LoggerHelper.info("Removing item from cart: ID $itemId");
    try {
      await removeFromCart.call(itemId);
      LoggerHelper.debug("Item removed: ID $itemId");
      loadCartItems(); // Reload items after removal
    } catch (e) {
      LoggerHelper.error("Error removing item from cart: ID $itemId", e);
    }
  }

  Future<void> clear() async {
    LoggerHelper.info("Clearing all items in the cart");
    try {
      await clearCart.call();
      LoggerHelper.debug("Cart cleared");
      emit(CartLoaded([])); // Immediately update UI to show empty cart
    } catch (e) {
      LoggerHelper.error("Error clearing cart", e);
    }
  }

  Future<void> updateItemQuantity(String itemId, int quantity) async {
    LoggerHelper.info("Updating quantity for item: ID $itemId to $quantity");
    try {
      await updateQuantity.call(itemId, quantity);
      LoggerHelper.debug("Quantity updated for item: ID $itemId to $quantity");
      loadCartItems(); // Reload items after updating quantity
    } catch (e) {
      LoggerHelper.error("Error updating quantity for item: ID $itemId", e);
    }
  }
}
