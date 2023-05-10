import 'package:book_crossing_app/data/models/pick_up_point.dart';
import 'package:book_crossing_app/presentation/cubits/models_status.dart';
import 'package:book_crossing_app/presentation/cubits/point/point_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_choices/search_choices.dart';

class SearchPointField extends StatefulWidget {
  const SearchPointField({Key? key}) : super(key: key);

  @override
  State<SearchPointField> createState() => _SearchPointFieldState();
}

class _SearchPointFieldState extends State<SearchPointField> {
  PickUpPoint? _selectedItem;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PointCubit, PointState>(builder: (context, state) {
      print('state.userPoints.runtimeType: ${state.userPoints.runtimeType}');
      switch (state.userPoints.runtimeType) {
        case LoadingStatus<List<PickUpPoint>>:
          return const Center(child: CircularProgressIndicator());
        case FailedStatus:
          return Center(
              child:
                  Text(state.userPoints.message ?? 'Ошибка search_point_field 25 стр'));
        case LoadedStatus<List<PickUpPoint>>:
          List<PickUpPoint> userPoints = state.userPoints.item!;
          List<DropdownMenuItem<PickUpPoint>> menuItems = userPoints
              .map((point) => DropdownMenuItem<PickUpPoint>(
                    value: point,
                    child: Text(
                        '${point.city}, ${point.street},д. ${point.house}, кв. ${point.flat}'),
                  ))
              .toList();

          return buildSearchPointWidget(menuItems, context);
        default:
          return const Center(child: CircularProgressIndicator());
      }
    });
  }

  Widget buildSearchPointWidget(
      List<DropdownMenuItem<PickUpPoint>> menuItems, BuildContext context) {
    return SearchChoices.single(
      validator: (value) {
        if (value == null) {
          return 'Это обязательное поле';
        }
      },
      items: menuItems,
      value: _selectedItem,
      hint: 'Место',
      searchHint: 'Выберите точку или добавьте новую',
      dialogBox: true,
      isExpanded: true,
      //menuConstraints: BoxConstraints.tight(const Size.fromHeight(350)),
      doneButton: TextButton(onPressed: (){Navigator.of(context).pop();}, child: Text("Назад"),),
      closeButton: () {},
      disabledHint: (Function updateParent) {
        return (TextButton(
          onPressed: () {
            Navigator.of(context).pushNamed('/add-point').then((value) async {
              updateParent(value);
            });
          },
          child: Text("У вас ещё нет мест, где вы можете отдать книгу, ее можно создать здесь"),
        ));
      },
      displayItem: (DropdownMenuItem item, selected, Function updateParent) {
        bool deleteRequest = false;
        return ListTile(
          title: item,
          onTap: () {
            if (!deleteRequest) {
              updateParent(item.value, true);
            }
          },
          horizontalTitleGap: 0,
        );
      },
      autofocus: false,
      onChanged: (PickUpPoint? value, Function? pop) {
        //context.read<ReviewCubit>().bookChanged(value!);
        setState(() {
          if (value is! NotGiven) {
            _selectedItem = value;
          }
          if (pop != null && value is! NotGiven && value != null) {
            pop();
          }
        });
      },
    );
  }
}
