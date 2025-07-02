
import 'package:flutter/material.dart';
import 'package:store/models/product_model.dart';
import 'package:store/services/all_categories_service.dart';
import 'package:store/services/categories_service.dart';
import 'package:store/services/get_all_product_service.dart';
import 'package:store/widget/category_widget.dart';
import 'package:store/widget/custom_bottom_nav.dart';
import 'package:store/widget/product_widget.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ProductModel> products = [];
  List<String> categories = [];
  bool isLoading = true;
  String selectedCategory = 'All';
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    getAllData();
  }

  Future<void> getAllData() async {
    categories = List<String>.from(await AllCategoriesService().getAllCategories());
    categories.insert(0, 'All');
    products = await GetAllProductsService().getAllProduct();
    setState(() => isLoading = false);
  }

  Future<void> filterByCategory(String category) async {
    setState(() {
      selectedCategory = category;
      isLoading = true;
    });

    if (category == 'All') {
      products = await GetAllProductsService().getAllProduct();
    } else {
      products = await CategoriesService().getCategoriesProducts(categoryName: category);
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('Welcome Back!', style: TextStyle(color: Colors.black)),
        actions: const [
          Icon(Icons.search, color: Colors.black),
          SizedBox(width: 16),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('Popular Products',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        Text('Sort by', style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ),

                  // Categories
                  SizedBox(
                    height: 50,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final category = categories[index];
                        final isSelected = selectedCategory == category;
                        return CategoryItemWidget(
                          category: category,
                          isSelected: isSelected,
                          onTap: () => filterByCategory(category),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Products Grid
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: products.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 0.75,
                      ),
                      itemBuilder: (context, index) {
                        return ProductItemWidget(product: products[index],selectedCategory: selectedCategory);
                      },
                    ),
                  ),

                  const SizedBox(height: 16),
                ],
              ),
            ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: selectedIndex,
        onItemSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
    );
  }
}
