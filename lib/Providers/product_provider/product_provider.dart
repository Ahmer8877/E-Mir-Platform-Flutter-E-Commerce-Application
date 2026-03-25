import 'dart:async';
import 'package:flutter/material.dart';
import '../../models/Product_Model.dart';

class ProductProvider extends ChangeNotifier {
  List<ProductModel> _allProducts = [];
  List<ProductModel> _filteredProducts = [];
  bool _isLoading = false;
  String _errorMessage = '';
  Timer? _debounce;

  List<ProductModel> get products => _filteredProducts;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  final List<ProductModel> _fakeProducts = [
    ProductModel(id: 1, title: 'Nike Air Max 270', price: 129.99, originalPrice: 179.99, image: 'https://picsum.photos/seed/shoe1/300/300', category: 'Shoes', rating: 4.8, reviews: 2341),
    ProductModel(id: 2, title: 'Apple Watch Series 9', price: 399.99, originalPrice: 449.99, image: 'https://picsum.photos/seed/watch1/300/300', category: 'Electronics', rating: 4.9, reviews: 5621),
    ProductModel(id: 3, title: 'Samsung Galaxy Buds', price: 89.99, originalPrice: 129.99, image: 'https://picsum.photos/seed/buds1/300/300', category: 'Electronics', rating: 4.5, reviews: 1203),
    ProductModel(id: 4, title: 'Levi\'s Slim Fit Jeans', price: 59.99, originalPrice: 89.99, image: 'https://picsum.photos/seed/jeans1/300/300', category: 'Clothing', rating: 4.3, reviews: 876),
    ProductModel(id: 5, title: 'Sony Headphones WH-1000', price: 279.99, originalPrice: 349.99, image: 'https://picsum.photos/seed/headphone1/300/300', category: 'Electronics', rating: 4.7, reviews: 3210),
    ProductModel(id: 6, title: 'Adidas Running Jacket', price: 74.99, originalPrice: 99.99, image: 'https://picsum.photos/seed/jacket1/300/300', category: 'Clothing', rating: 4.4, reviews: 654),
    ProductModel(id: 7, title: 'iPad Pro 11 inch', price: 799.99, originalPrice: 899.99, image: 'https://picsum.photos/seed/ipad1/300/300', category: 'Electronics', rating: 4.9, reviews: 4532),
    ProductModel(id: 8, title: 'Puma Sports Shoes', price: 64.99, originalPrice: 84.99, image: 'https://picsum.photos/seed/shoe2/300/300', category: 'Shoes', rating: 4.2, reviews: 432),
    ProductModel(id: 9, title: 'Wireless Keyboard', price: 49.99, originalPrice: 69.99, image: 'https://picsum.photos/seed/keyboard1/300/300', category: 'Electronics', rating: 4.1, reviews: 321),
    ProductModel(id: 10, title: 'Men\'s Casual T-Shirt', price: 24.99, originalPrice: 39.99, image: 'https://picsum.photos/seed/tshirt1/300/300', category: 'Clothing', rating: 4.0, reviews: 234),
    ProductModel(id: 11, title: 'Gaming Mouse RGB', price: 44.99, originalPrice: 59.99, image: 'https://picsum.photos/seed/mouse1/300/300', category: 'Electronics', rating: 4.6, reviews: 1876),
    ProductModel(id: 12, title: 'Leather Wallet Brown', price: 34.99, originalPrice: 49.99, image: 'https://picsum.photos/seed/wallet1/300/300', category: 'Accessories', rating: 4.3, reviews: 543),
  ];

  //  Products load with try-catch
  Future<void> fetchAllProducts() async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      await Future.delayed(const Duration(seconds: 1));
      _allProducts = _fakeProducts;
      _filteredProducts = _fakeProducts;
    }
    catch (e) {
      _errorMessage = 'Products are not load : ${e.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Search with try-catch
  void searchProducts(String query) {
    try {
      _debounce?.cancel();

      if (query.isEmpty) {
        _filteredProducts = _allProducts;
        notifyListeners();
        return;
      }

      _debounce = Timer(const Duration(milliseconds: 400), () {
        try {
          _filteredProducts = _allProducts.where((p) {
            return p.title.toLowerCase().contains(query.toLowerCase()) ||
                p.category.toLowerCase().contains(query.toLowerCase());
          }).toList();
          notifyListeners();
        } catch (e) {
          _errorMessage = 'Searching problem: ${e.toString()}';
          notifyListeners();
        }
      });
    } catch (e) {
      _errorMessage = 'Search failing: ${e.toString()}';
      notifyListeners();
    }
  }

  //  Wishlist toggle with try-catch
  void toggleWishlist(int id) {
    try {
      final index = _allProducts.indexWhere((p) => p.id == id);
      if (index != -1) {
        _allProducts[index].isWishlisted = !_allProducts[index].isWishlisted;
        searchProducts('');
        notifyListeners();
      }
    } catch (e) {
      _errorMessage = 'Wishlist update nahi hua: ${e.toString()}';
      notifyListeners();
    }
  }

  void cancelDebounce() {
    _debounce?.cancel();
  }
}