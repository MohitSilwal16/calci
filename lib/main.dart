import 'package:flutter/material.dart';
import 'package:function_tree/function_tree.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CalciProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        home: const Calci(),
      ),
    );
  }
}

class Calci extends StatefulWidget {
  const Calci({super.key});

  @override
  State<Calci> createState() => _CalciState();
}

class _CalciState extends State<Calci> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CalciProvider>(builder: (context, provider, _) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height,
          margin: const EdgeInsets.all(10),
          child: Column(
            children: [
              const Spacer(),
              TextField(
                textAlign: TextAlign.end,
                style: const TextStyle(fontSize: 40),
                controller: provider.controller,
                showCursor: false,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
                readOnly: true,
              ),
              TextField(
                textAlign: TextAlign.end,
                style: const TextStyle(
                    fontSize: 30, color: Color.fromARGB(255, 203, 194, 194)),
                controller: provider.out,
                showCursor: false,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
                readOnly: true,
              ),
              Container(
                height: MediaQuery.sizeOf(context).height * 0.6,
                width: MediaQuery.sizeOf(context).width,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:
                            List.generate(4, (index) => buttonList[index]),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:
                            List.generate(4, (index) => buttonList[index + 4]),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:
                            List.generate(4, (index) => buttonList[index + 8]),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:
                            List.generate(4, (index) => buttonList[index + 12]),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:
                            List.generate(4, (index) => buttonList[index + 16]),
                      ),
                    ],
                  ),
                ),
              ),
              // const Spacer(),
            ],
          ),
        ),
      );
    });
  }
}

class Buttons extends StatelessWidget {
  const Buttons({super.key, required this.label, this.col = Colors.black});
  final String label;
  final Color col;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Provider.of<CalciProvider>(context, listen: false).setValue(label);
      },
      child: CircleAvatar(
        radius: 36,
        backgroundColor: col,
        child: Text(
          label,
          style: const TextStyle(fontSize: 37, color: Colors.white),
        ),
      ),
    );
  }
}

class CalciProvider extends ChangeNotifier {
  final controller = TextEditingController();
  final out = TextEditingController();

  setValue(String value) {
    String temp = controller.text;

    switch (value) {
      case '=':
        compute();
        break;
      case 'AC':
        controller.text = "";
        out.text = "";
        break;
      case 'C':
        controller.text = temp.substring(0, temp.length - 1);
        out.text = controller.text;
        break;
      case '+':
      case '-':
      case '*':
      case '/':
      case '%':
        if (temp[temp.length - 1] == '+' ||
            temp[temp.length - 1] == '-' ||
            temp[temp.length - 1] == '*' ||
            temp[temp.length - 1] == '%' ||
            temp[temp.length - 1] == '/') {
          controller.text = temp.substring(0, temp.length - 1);
          controller.text += value;
        } else {
          controller.text += value;
        }
        break;
      default:
        controller.text += value;
    }
    out.text = controller.text.interpret().toString();
  }

  compute() {
    String temp = controller.text;
    controller.text = temp.interpret().toString();
    out.text = "";
  }
}

List<Widget> buttonList = [
  const Buttons(label: "AC", col: Color.fromARGB(255, 39, 37, 37)),
  const Buttons(label: "%", col: Color.fromARGB(255, 39, 37, 37)),
  const Buttons(label: "C", col: Color.fromARGB(255, 39, 37, 37)),
  const Buttons(label: "/", col: Color.fromARGB(255, 39, 37, 37)),
  const Buttons(label: "7", col: Color.fromARGB(255, 26, 24, 24)),
  const Buttons(label: "8", col: Color.fromARGB(255, 26, 24, 24)),
  const Buttons(label: "9", col: Color.fromARGB(255, 26, 24, 24)),
  const Buttons(label: "*", col: Color.fromARGB(255, 39, 37, 37)),
  const Buttons(label: "4", col: Color.fromARGB(255, 26, 24, 24)),
  const Buttons(label: "5", col: Color.fromARGB(255, 26, 24, 24)),
  const Buttons(label: "6", col: Color.fromARGB(255, 26, 24, 24)),
  const Buttons(label: "-", col: Color.fromARGB(255, 39, 37, 37)),
  const Buttons(label: "1", col: Color.fromARGB(255, 26, 24, 24)),
  const Buttons(label: "2", col: Color.fromARGB(255, 26, 24, 24)),
  const Buttons(label: "3", col: Color.fromARGB(255, 26, 24, 24)),
  const Buttons(label: "+", col: Color.fromARGB(255, 39, 37, 37)),
  const Buttons(label: "00", col: Color.fromARGB(255, 26, 24, 24)),
  const Buttons(label: "0", col: Color.fromARGB(255, 26, 24, 24)),
  const Buttons(label: ".", col: Color.fromARGB(255, 26, 24, 24)),
  const Buttons(label: "=", col: Colors.red),
];
