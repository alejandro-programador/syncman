import 'package:flutter/material.dart';
import 'package:syncman_new/models/category_model.dart';
import 'package:syncman_new/services/sync/category_service.dart';
import 'package:syncman_new/utils/network_utils.dart';
import 'package:syncman_new/config/pagination_config.dart';

class CategoryProvider extends ChangeNotifier {
  final CategoryService _categoryService;
  List<Category> _categories = [];
  bool _isLoading = false;

  List<Category> get categories => _categories;
  bool get isLoading => _isLoading;

  CategoryProvider(this._categoryService);

  // Future<void> fetchCategories({bool? loadDatabase = false}) async {
  //   if (loadDatabase == true) {
  //     await loadCategoriesFromDatabase();
  //     return;
  //   }
  //   if (_isLoading) return; // Prevent multiple requests
  //   _isLoading = true;
  //   notifyListeners();

  //   try {
  //     if (await NetworkUtils.hasInternetConnection()) {
  //       int page = PaginationConfig.defaultPage;
  //       bool hasMoreData = true;

  //       while (hasMoreData) {
  //         final categories = await _categoryService.query(page: page);
  //         if (categories.isNotEmpty) {
  //           for (var category in categories) {
  //             await _categoryService.updateOrCreate(category);
  //           }
  //           page++;
  //         } else {
  //           hasMoreData = false;
  //         }
  //       }

  //       await loadCategoriesFromDatabase();
  //     } else {
  //       await loadCategoriesFromDatabase();
  //     }
  //   } finally {
  //     _isLoading = false;
  //     notifyListeners();
  //   }
  // }

  // Future<void> loadCategoriesFromDatabase() async {
  //   _isLoading = true;
  //   notifyListeners();

  //   try {
  //     _categories = await _categoryService.query();
  //   } catch (e) {
  //     _categories = [];
  //   } finally {
  //     _isLoading = false;
  //     notifyListeners();
  //   }
  // }

  Future<void> loadCategories() async {
    _isLoading = true;
    notifyListeners();

    final categoriesList = await _categoryService.query();
    _categories = categoriesList;

    _isLoading = false;
    notifyListeners();
  }

  Future<Category> getCategoryById(String id) async {
    return await _categoryService.getById(id);
  }

  Future<Category> getCategoryByCodigo(String codigo) async {
    return await _categoryService.getByCodigo(codigo);
  }
}
