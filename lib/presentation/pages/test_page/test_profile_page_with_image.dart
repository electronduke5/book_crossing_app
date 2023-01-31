import 'package:flutter/material.dart';

class TestProfilePage extends StatelessWidget {
  const TestProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return profileCard(context);
  }

  Widget profileCard(BuildContext context) {
    return Stack(
      children: [
        Align(
            alignment: Alignment.topCenter,
            child: Image.asset('assets/images/wallpaper.jpg')),
        const Card(
          child: SizedBox(height: 100),
        ),
        Positioned(
          top: 100,
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                Positioned(
                  child: SizedBox(
                    height: 220,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 50.0,
                        left: 30,
                        right: 30,
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
                      child: CircleAvatar(
                        minRadius: 2,
                        maxRadius: 60,
                        child: Text(
                          'Г П',
                          style: TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 36),
                        ),
                      ),
                      // child: CircleAvatar(
                      //   minRadius: 2,
                      //   maxRadius: 60,
                      //   backgroundImage: AssetImage('assets/images/11.jpg'),
                      // ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
