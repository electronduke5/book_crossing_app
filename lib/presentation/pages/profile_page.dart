import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  final double _horizontalPadding = 0.0;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      clipBehavior: Clip.none,
      child: Column(
        children: [
          profileCard(context),
          statsWidget(),
          reviewWidget(context),
          SizedBox(height: 10),
          Text('1 запись', style: Theme.of(context).textTheme.titleSmall),
        ],
      ),
    );
  }

  Padding reviewWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: _horizontalPadding),
      child: InkWell(
        onDoubleTap: () {
          print('like! 19');
        },
        child: Card(
          margin: EdgeInsets.zero,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      backgroundImage: AssetImage('assets/images/11.jpg'),
                      maxRadius: 20,
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Гришин Павел',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text('20 ноя. 2022 г.',
                            style: Theme.of(context).textTheme.bodySmall),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                const Text(
                  'Дж. Оруэлл - "1984"',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 15),
                Text(
                  'Книга очень тяжёлая для прочтения. Много невнятных терминов, благодаря чему интереснее читать словарик, чем саму книгу. Постоянные однотипные рассказы про войну, контроль власти и пытки людей, которые надоедают во время прочтения так, что появляется желание выбросить чтиво в дальний угол и больше не открывать. Обычно читаю книгу с 300 страницами не более чем за день, в данном случае из-за отсутствия интриги и скучного ,долгого развития сюжета она пылилась месяцами. На любителя.',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        print('like! 60');
                      },
                      icon: Icon(Icons.favorite_outline),
                      label: Text('144'),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding statsWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: _horizontalPadding,
        vertical: 12,
      ),
      child: Card(
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                itemInStatsRow(title: 'Рецензий', value: '12'),
                const VerticalDivider(
                  indent: 10,
                  endIndent: 10,
                ),
                itemInStatsRow(title: 'Лайков', value: '157'),
                const VerticalDivider(
                  indent: 10,
                  endIndent: 10,
                ),
                itemInStatsRow(title: 'Конфет', value: '29'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column itemInStatsRow({required String title, required dynamic value}) {
    return Column(
      children: [
        Text(
          value.toString(),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(title),
      ],
    );
  }

  Widget profileCard(BuildContext context) {
    return Stack(
      children: [
        Align(
            alignment: Alignment.topCenter,
            child: Image.asset('assets/images/wallpaper.jpg')),
        Padding(
          padding: const EdgeInsets.only(top: 60.0),
          child: profileWidget(context),
        ),
      ],
    );
  }

  Stack profileWidget(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          child: SizedBox(
            height: 220,
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.only(
                top: 50.0,
                left: _horizontalPadding,
                right: _horizontalPadding,
              ),
              child: Card(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(25),
                  ),
                ),
                margin: EdgeInsets.zero,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Гришин Павел',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Почта: ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text('g.pav5@mail.ru'),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).cardColor,
            ),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              // child: CircleAvatar(
              //   minRadius: 2,
              //   maxRadius: 60,
              //   child: Text(
              //     'Г П',
              //     style:
              //         TextStyle(fontWeight: FontWeight.normal, fontSize: 36),
              //   ),
              // ),
              child: CircleAvatar(
                minRadius: 2,
                maxRadius: 60,
                backgroundImage: AssetImage('assets/images/11.jpg'),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
