import 'package:flutter/material.dart';

void main() => runApp(const MyApp());


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ValueNotifier<int> _counter = ValueNotifier<int>(0);
  final String _textToWrite = "이것은 한국말 된 문장이에요";
  final FocusNode _focusNode = FocusNode(
      canRequestFocus: true
  );
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _counter.addListener(onValueChangeWithIssue);
    //_counter.addListener(onValueChangeWithoutIssue);
  }

  @override
  void dispose() {
    super.dispose();
    _counter.removeListener(onValueChangeWithIssue);
    //_counter.removeListener(onValueChangeWithoutIssue);
  }

  void onValueChangeWithIssue() {
    _controller.clear();
    setState(() {});
  }
  void onValueChangeWithoutIssue() {
    _focusNode.unfocus();
    _controller.clear();
    setState(() {});
    WidgetsBinding.instance.addPostFrameCallback((ts)
    =>_focusNode.requestFocus());
  }

  void onChanged(String input) {
    if(_textToWrite == input) {
      _counter.value += 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ConstrainedBox(
          constraints: const BoxConstraints(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Text to enter => \'$_textToWrite\''),
              Container(
                constraints: const BoxConstraints(),
                child: Row(
                    children: [
                      const Text("Enter Text:"),
                      Expanded(
                        child: EditableText(
                          minLines: 4,
                          maxLines: 10,
                         
                          controller: _controller,
                          focusNode: _focusNode,
                          scrollController: ScrollController(),
                          autofocus: false,
                          autocorrect: false,
                          backgroundCursorColor: Colors.white,
                          cursorColor: Colors.black,
                          style: Theme.of(context).textTheme.headlineMedium!,
                          onChanged: onChanged,
                        ),
                      ),
                    ]),
              ),
              Text(
                'You have entered the text this many times: ${_counter.value}',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
