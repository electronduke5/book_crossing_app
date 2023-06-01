import 'package:book_crossing_app/presentation/cubits/point/point_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../di/app_module.dart';
import '../widgets/profile_widgets/profile_image_small.dart';

class AddPointPage extends StatelessWidget {
  AddPointPage({Key? key}) : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController cityController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController houseController = TextEditingController();
  final TextEditingController flatController = TextEditingController();
  final TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final fieldWidth = MediaQuery.of(context).size.width / 1.3;
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0),
          child:
          ProfileAvatarSmall(maxRadius: 15, user: AppModule.getProfileHolder().user),
        ),
        title: const Text(
          'Добавление адреса',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: BlocBuilder<PointCubit, PointState>(
            builder: (context, state) {
              return SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Lottie.asset(
                        'assets/lottie/location.json',
                        repeat: false,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Card(
                      elevation: 0,
                      color: Theme.of(context).cardColor.withOpacity(0.8),
                      margin: EdgeInsets.zero,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  const Text('Город:'),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  SizedBox(
                                    width: fieldWidth,
                                    child: TextFormField(
                                      controller: cityController,
                                      validator: (value) {
                                        if (value?.trim().isNotEmpty == true) {
                                          return null;
                                        }
                                        return "Это обязательное поле";
                                      },
                                      decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(20)),
                                        hintText: 'Москва',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  const Text('Улица:'),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  SizedBox(
                                    width: fieldWidth,
                                    child: TextFormField(
                                      controller: streetController,
                                      decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(20)),
                                        hintText: 'Тверская',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text('Дом №:'),
                                  const SizedBox(width: 5),
                                  SizedBox(
                                    width: fieldWidth / 3,
                                    child: TextFormField(
                                      controller: houseController,
                                      maxLength: 4,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        counterText: '',
                                        contentPadding: const EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(20)),
                                        hintText: '19',
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  const Text('Кв №:'),
                                  const SizedBox(width: 5),
                                  SizedBox(
                                    width: fieldWidth / 3,
                                    child: TextFormField(
                                      maxLength: 3,
                                      keyboardType: TextInputType.number,
                                      controller: flatController,
                                      decoration: InputDecoration(
                                        counterText: '',
                                        contentPadding: const EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(20)),
                                        hintText: '1',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  const Text('Комментарий:'),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: ConstrainedBox(
                                      constraints: const BoxConstraints(
                                        maxHeight: 300.0,
                                      ),
                                      child: TextFormField(
                                        maxLines: null,
                                        controller: commentController,
                                        decoration: InputDecoration(
                                          contentPadding: const EdgeInsets.symmetric(
                                              horizontal: 10.0),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),
                              ElevatedButton(
                                onPressed: () async {
                                  if (_formKey.currentState?.validate() ?? false) {
                                    final String city = cityController.value.text;
                                    final String street = streetController.value.text;
                                    final String house = houseController.value.text;
                                    final String flat = flatController.value.text;
                                    final String comment =
                                        commentController.value.text;

                                    await context
                                        .read<PointCubit>()
                                        .createPoint(
                                          city: city.trim(),
                                          street: street.trim(),
                                          house: house.trim(),
                                          flat: flat.trim(),
                                          comment: comment.trim(),
                                          user: AppModule.getProfileHolder().user,
                                        )
                                        .then((value) {
                                      if (value != null) {
                                        Navigator.pop(context, value);
                                      }
                                    });
                                  }
                                },
                                child: const Text("Далее"),
                              ),
                              const SizedBox(height: 5),
                              OutlinedButton(
                                onPressed: () => Navigator.pop(context, null),
                                child: const Text("Назад"),
                              ),

                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
