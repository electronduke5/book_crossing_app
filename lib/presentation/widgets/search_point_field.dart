import 'package:book_crossing_app/data/models/pick_up_point.dart';
import 'package:book_crossing_app/presentation/cubits/models_status.dart';
import 'package:book_crossing_app/presentation/cubits/point/point_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_choices/search_choices.dart';

import '../di/app_module.dart';

// ignore: must_be_immutable
class SearchPointField extends StatefulWidget {
  SearchPointField({Key? key, required this.onChanged, this.userPoints}) : super(key: key);

  List<PickUpPoint>? userPoints;

  final ValueChanged<PickUpPoint?> onChanged;

  @override
  State<SearchPointField> createState() => _SearchPointFieldState();
}

class _SearchPointFieldState extends State<SearchPointField> {
  PickUpPoint? _selectedItem;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PointCubit, PointState>(builder: (context, state) {
          () {
        if (widget.userPoints != null) {
          List<PickUpPoint> pointItems = widget.userPoints!;
          List<DropdownMenuItem<PickUpPoint>> menuItems = pointItems
              .map((point) => DropdownMenuItem<PickUpPoint>(
            value: point,
            child: Text(point.getPoint()),
          ))
              .toList();
          return buildSearchPointWidget(menuItems, context);
        }
      }();
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
                        point.getPoint()),
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
        return null;
      },
      items: menuItems,
      value: _selectedItem,
      hint: 'Место',
      searchHint: 'Выберите точку',
      dialogBox: false,
      isExpanded: true,
      menuConstraints: BoxConstraints.tight(const Size.fromHeight(350)),
      closeButton:
          (PickUpPoint? value, BuildContext closeContext, Function updateParent) {
        return TextButton(
          onPressed: () {
            Navigator.of(context).pushNamed('/add-point').then((value) async {
              if (value != null) {
                menuItems.add(DropdownMenuItem<PickUpPoint>(
                  value: value as PickUpPoint,
                  child: Text(
                      '${value.city},ул. ${value.street}, д. ${value.house}, кв. ${value
                          .flat}'),
                ));
                if (menuItems.indexWhere((element) => element.value == value) != -1) {
                  context
                      .read<PointCubit>()
                      .loadUsersPoints(AppModule
                      .getProfileHolder()
                      .user);
                  updateParent(value, true);
                }
              }
            });
          },
          child: const Text('Добавить новую точку'),
        );
      },
      disabledHint: (Function updateParent) {
        return (TextButton(
          onPressed: () {
            Navigator.of(context).pushNamed('/add-point').then((value) async {
              updateParent(value);
            });
          },
          child: const Text(
              "У вас ещё нет мест, где вы можете отдать книгу, ее можно создать здесь"),
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
      onChanged: (PickUpPoint? value, Function? pop) async {
        setState(() {
          if (value is! NotGiven) {
            _selectedItem = value;
            widget.onChanged(value);
          }
          if (pop != null && value is! NotGiven && value != null) {
            pop();
          }
        });
      },
    );
  }
}
