// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:flashcards_zoan/koan.dart';
import 'package:flashcards_zoan/koan_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'To-Do App',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return KoanFlashcard();
  }

  Widget KoanFlashcard() {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 350,
              minWidth: 350,
              minHeight: 350,
            ),
            child: KoanFlipCard(
              koan: koans[currentIndex],
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: likeKoan,
                iconSize: 25,
                padding: EdgeInsets.all(8.0),
                icon: Icon(
                  Icons.favorite,
                  color: koans[currentIndex].liked == true
                      ? Colors.pink
                      : Colors.grey,
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => MeaningsPage(
                        bottomNav: BottomNav(),
                      ),
                    ),
                  );
                },
                iconSize: 25,
                icon: Icon(Icons.add),
                padding: EdgeInsets.all(8.0),
              ),
              IconButton(
                onPressed: nextKoan,
                iconSize: 25,
                padding: EdgeInsets.all(8.0),
                icon: Icon(Icons.navigate_next),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget BottomNav() {
    final formKey = GlobalKey<FormState>();
    final koanController = TextEditingController();

    return Form(
      key: formKey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some meaning!';
                  }
                  if (value != null) {
                    return value;
                  }
                },
                controller: koanController,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                setState(() {
                  koans[currentIndex].addInterpretation(
                      '${DateTime.now().day}/${DateTime.now().month}',
                      koanController.text);
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  likeKoan() {
    setState(() {
      koans[currentIndex].likeKoan();
    });
  }

  nextKoan() {
    setState(() {
      currentIndex = currentIndex + 1 < koans.length ? currentIndex + 1 : 0;
    });
  }
}

class MeaningsPage extends StatelessWidget {
  final bottomNav;
  const MeaningsPage({Key? key, required this.bottomNav}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(currentIndex);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverList(
              delegate: SliverChildListDelegate([
            ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: 350,
                maxWidth: 350,
                minHeight: 350,
              ),
              child: Card(
                elevation: 4.0,
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Center(
                    child: Text(
                      koans[currentIndex].meaning,
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                ),
              ),
            ),
          ])),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              ((context, index) =>
                  KoanMeaningCard(koanInfo: koanInterpretations[index])),
              childCount: koanInterpretations.length,
            ),
          ),
        ],
      ),
      bottomNavigationBar: bottomNav,
    );
  }
}
