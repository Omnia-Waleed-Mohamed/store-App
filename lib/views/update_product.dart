import 'package:flutter/material.dart';
import 'package:store/models/product_model.dart';
import 'package:store/services/update_product.dart';
import 'package:store/widget/text_field.dart';

class UpdateProduct extends StatelessWidget {
  final ProductModel product;
  final String category;

  UpdateProduct({super.key, required this.product, required this.category});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController imageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Update Product'),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomTextField(
                hintText: 'Product Name',
                controller: nameController,
              ),
              CustomTextField(
                hintText: 'Description',
                controller: descriptionController,
              ),
              CustomTextField(
                hintText: 'Price',
                controller: priceController,
                keyboardType: TextInputType.number,
              ),
              CustomTextField(
                hintText: 'Image URL',
                controller: imageController,
                keyboardType: TextInputType.url,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  UpdateProductService().updateProduct(
                    id: product.id,
                    title: nameController.text.isEmpty
                        ? product.title
                        : nameController.text,
                    price: priceController.text.isEmpty
                        ? product.price
                        : double.tryParse(priceController.text) ??
                            product.price,
                    des: descriptionController.text.isEmpty
                        ? product.description
                        : descriptionController.text,
                    image: imageController.text.isEmpty
                        ? product.image
                        : imageController.text,
                    category: category,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Update'),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
