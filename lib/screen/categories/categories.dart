import 'package:flutter/material.dart';
import 'package:paragony/model/domain/model_category.dart';
import 'package:paragony/screen/categories/category_item.dart';
import 'package:paragony/services/db_service.dart';
import 'package:paragony/shared/constants.dart';
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
                    onEditClick: _onEditCategoryClicked,
                    onRemoveClick: _onCategoryRemoveClick,
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
              onPressed: _onCreateCategoryClicked,
            ),
          ),
        ));
  }

  void _onCreateCategoryClicked() async {
    dynamic result = await Navigator.pushNamed(context, Routes.addCategory);
    bool isCreateSuccess = result['addComplete'] as bool;

    if (isCreateSuccess) {
      setState(() => {_list = DBService().getCategories()});
    }
  }

  void _onEditCategoryClicked(Category category) async {
    dynamic result = await Navigator.pushNamed(context, Routes.editCategory,
        arguments: {'category': category, 'id': category.id});
    bool isEditSuccess = result['editComplete'] as bool;

    if (isEditSuccess) {
      setState(() => {_list = DBService().getCategories()});
    }
  }

  void _onCategoryRemoveClick(int categoryId) async {
    await DBService().removeCategory(categoryId);
    setState(() => {_list = DBService().getCategories()});
  }
}
