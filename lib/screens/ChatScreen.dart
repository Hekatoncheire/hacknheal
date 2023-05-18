import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hack_heal/models/constant.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

import '../models/ChatMessageModel.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late bool isLoading;
  TextEditingController _textController = TextEditingController();
  final _scrollController = ScrollController();
  final List<ChatMessage> _messages = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoading = false;
  }

  Future<String> generateResponse(String prompt) async {
    final apiKey = apiSecretKey;
    var url = Uri.https('api.openai.com', '/v1/completions');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode({
        'model': 'text-davinci-003',
        'prompt': prompt,
        'temperature': 0,
        'top_p': 1,
        'frequency_penalty': 0.0,
        'presence_penalty': 0.0,
        'max_tokens': 2000
      }),
    );

    Map<String, dynamic> newResponse = jsonDecode(response.body);
    print(newResponse);
    return newResponse['choices'][0]['text'];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Diagnosis chatbot",
            textAlign: TextAlign.center,
          ),
        ),
        backgroundColor: Colors.redAccent,
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildList(),
          ),
          Visibility(
            visible: isLoading,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircularProgressIndicator(
                color: Colors.redAccent,
              ),
            ),
          ),
          Row(
            children: [
              _buildInput(),
              _buildSubmit(),
            ],
          )
        ],
      ),
    ));
  }

  Expanded _buildInput() {
    return Expanded(
        child: TextField(
      textCapitalization: TextCapitalization.sentences,
      style: TextStyle(
        color: Colors.black,
      ),
      controller: _textController,
      decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none),
    ));
  }

  Widget _buildSubmit() {
    return Visibility(
        visible: !isLoading,
        child: Container(
          color: Colors.white,
          child: IconButton(
            icon: Icon(
              Icons.send_rounded,
              color: Colors.redAccent,
            ),
            onPressed: () {
              setState(() {
                _messages.add(ChatMessage(
                    text: _textController.text,
                    chatMessageType: ChatMessageType.user));
                isLoading = true;
              });
              var input = _textController.text;
              _textController.clear();
              Future.delayed(Duration(milliseconds: 50))
                  .then((value) => _scrollDown());
              generateResponse(input).then((value) => {
                    setState(() {
                      isLoading = false;
                      _messages.add(ChatMessage(
                          text: value,
                          chatMessageType: ChatMessageType.bot));
                    })
                  });
              _textController.clear();
              Future.delayed(Duration(milliseconds: 50))
                  .then((value) => _scrollDown());
            },
          ),
        ));
  }

  void _scrollDown() {
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300), curve: Curves.easeOut);
  }

  ListView _buildList() {
    return ListView.builder(
        itemCount: _messages.length,
        controller: _scrollController,
        itemBuilder: ((context, index) {
          var message = _messages[index];
          return ChatMessageWidget(
            text: message.text,
            chatMessageType: message.chatMessageType,
          );
        }));
  }
}

class ChatMessageWidget extends StatelessWidget {
  final String text;
  final ChatMessageType chatMessageType;
  const ChatMessageWidget(
      {Key? key, required this.text, required this.chatMessageType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.all(16),
      color: chatMessageType == ChatMessageType.bot
          ? Colors.redAccent
          : Colors.transparent,
      child: Row(
        children: [
          chatMessageType == ChatMessageType.bot
              ? Container(
                  margin: EdgeInsets.only(right: 16),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.add_rounded,
                      color: Colors.redAccent,
                    ),
                  ),
                )
              : Container(
                  margin: EdgeInsets.only(right: 16),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      color: Colors.redAccent,
                    ),
                  ),
                ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  text,
                  style: chatMessageType == ChatMessageType.bot
                      ? Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(color: Colors.white)
                      : Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(color: Colors.redAccent),
                ),
              )
            ],
          ))
        ],
      ),
    );
  }
}
