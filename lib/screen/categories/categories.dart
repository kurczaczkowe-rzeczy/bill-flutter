import 'package:flutter/material.dart';
import 'package:paragony/model/domain/model_category.dart';
import 'package:paragony/screen/categories/category_item.dart';
import 'package:paragony/services/db_service.dart';
import 'package:paragony/shared/loading.dart';

class CategoriesWidget extends StatefulWidget {
  const CategoriesWidget({Key? key}) : super(key: key);

  @override
  State<CategoriesWidget> createState() => _CategoriesWidgetState();
}

class _CategoriesWidgetState extends State<CategoriesWidget> {
  Future<List<Category>> _list = DBService().getCategories();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
          future: _list,
          initialData: [],
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: Text(
                  'Brak kategorii',
                  style: TextStyle(color: Colors.black12),
                ),
              );
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Loading();
            }

            List<Category> list = snapshot.data as List<Category>;
            return ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  Category category = list[index];

                  return CategoryItemWidget(
                    category: category,
                    isPreMade: index < 12,
                    onEditClick: (item) {},
                    onRemoveClick: (id) {},
                  );
                });
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: SizedBox(
            width: double.infinity,
            child: FloatingActionButton.extended(
              label: Text('Stwórz kategorię produktów'),
              onPressed: () {},
            ),
          ),
        ));
  }
}
