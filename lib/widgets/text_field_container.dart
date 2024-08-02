import 'package:flutter/material.dart';

class TextFieldContainer extends StatefulWidget {
  final ValueChanged<String> onValue;

  const TextFieldContainer({super.key, required this.onValue});

  @override
  _TextFieldContainerState createState() => _TextFieldContainerState();
}

class _TextFieldContainerState extends State<TextFieldContainer> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _focusNode.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final outlineInputBorder = UnderlineInputBorder(
      borderSide: const BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.circular(30),
    );

    final inputDecoration = InputDecoration(
      contentPadding: const EdgeInsets.all(15),
      hintText: 'Busca por título o autor',
      enabledBorder: outlineInputBorder,
      focusedBorder: outlineInputBorder,
      filled: true,
      suffixIcon: IconButton(
        icon: const Icon(Icons.send_outlined),
        onPressed: () {
          final textValue = _textController.text;
          _textController.clear();
          widget.onValue(textValue);         
        },
      ),
    );

    return Container(
      padding: const EdgeInsets.all(15),
      child: TextFormField(
        focusNode: _focusNode,
        controller: _textController,
        decoration: inputDecoration,
        onFieldSubmitted: (value) {
          _textController.clear();
          widget.onValue(value);
        },
      ),
    );
  }
}
