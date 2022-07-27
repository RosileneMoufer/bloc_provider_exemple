import 'package:bloc_provider_exemple/bloc/background_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<BackgroundCubit>(
      create: (context) => BackgroundCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () {
                  BlocProvider.of<BackgroundCubit>(context).changeColor(
                      const Color.fromARGB(255, 202, 216, 255), true);
                },
                child: Container(
                  padding: const EdgeInsets.all(24.0),
                  alignment: Alignment.center,
                  color: Colors.white,
                  child: const Text(
                      "Clique aqui para mudar a cor do Container abaixo e do background da próxima página para a cor verde"),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: BlocBuilder<BackgroundCubit, BackgroundState>(
                  builder: (context, state) {
                return Container(
                  alignment: Alignment.center,
                  color: state.backgroundColor,
                  padding: const EdgeInsets.all(24.0),
                  child: const Text(
                      "Clique no botão abaixo para ir para a próxima página."),
                );
              }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        elevation: 3,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const NextPage(),
            ),
          );
        },
        child: const Icon(
          Icons.pages,
          color: Color.fromARGB(255, 255, 170, 234),
        ),
      ),
    );
  }
}

class NextPage extends StatelessWidget {
  const NextPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text("SecondPage"),
      ),
      body: BlocConsumer<BackgroundCubit, BackgroundState>(
        listener: (context, state) {
          if (state.colorWasChanged!) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                duration: Duration(seconds: 1),
                content: Text("New color!"),
              ),
            );

            BlocProvider.of<BackgroundCubit>(context)
                .changeStateColorWasChanged(false);
          }
        },
        builder: (context, state) => Container(
          width: size.width,
          height: size.height,
          color: state.backgroundColor,
          alignment: Alignment.center,
          padding: const EdgeInsets.all(24.0),
          child: const Text(
              "Clique no botão abaixo para mudar a cor do background desta página e a cor do container da página anterior."),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (() => BlocProvider.of<BackgroundCubit>(context)
            .changeColor(const Color.fromARGB(255, 255, 151, 255), true)),
        backgroundColor: Colors.white,
        child: const Icon(
          Icons.color_lens,
          color: Colors.amber,
        ),
      ),
    );
  }
}
