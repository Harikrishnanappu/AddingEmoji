import 'dart:io';

import 'package:chatpage_new/constants.dart';
import 'package:chatpage_new/message_bubble.dart';
import 'package:chatpage_new/msgdata.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';

Data data = Data();

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController textcontroll = TextEditingController();

  bool _showEmoji = false;
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        _showEmoji = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE8EEFD),
      appBar: AppBar(
        backgroundColor: const Color(0xffE8EEFD),
        elevation: 5,
        scrolledUnderElevation: 2,
        toolbarHeight: 105,
        automaticallyImplyLeading: false,
        title: ListTile(
          leading: SizedBox(
            width: 100,
            height: 100,
            child: Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: cblack,
                  ),
                ),
                const CircleAvatar()
              ],
            ),
          ),
          title: const Text(
            "Jhon wick",
            style: TextStyle(color: textclr, fontWeight: textweight),
          ),
          subtitle: const Text(
            "online",
            style: TextStyle(color: textclr, fontWeight: textweight),
          ),
          trailing: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_horiz,
              color: cblack,
            ),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return MessageBubble(
                  msg: data.chatMsgs.values
                      .elementAt(index)
                      .elementAt(0)
                      .toString(),
                  isme: data.chatMsgs.values.elementAt(index).elementAt(1)
                      as bool,
                );
              },
              itemCount: data.chatMsgs.length,
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(
                  left: 24.0,
                  top: 8.0,
                  bottom: 30.0,
                  right: 6.0,
                ),
                width: MediaQuery.of(context).size.width * 0.66,
                height: 50,
                decoration: const BoxDecoration(
                  color: cwhite,
                  borderRadius: BorderRadius.all(
                    Radius.circular(25),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      width: 5,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.50,
                      child: TextField(
                        focusNode: focusNode,
                        controller: textcontroll,
                        cursorColor: textclr,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Type A Message...'),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        focusNode.unfocus();
                        focusNode.canRequestFocus = false;
                        setState(() => _showEmoji = !_showEmoji);
                      },
                      icon: const Icon(
                        Icons.emoji_emotions_outlined,
                        color: textclr,
                      ),
                    ),
                    //  textcontroll.text.trim()==""||textcontroll.text==null?:
                  ],
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: CircleAvatar(
                  backgroundColor: cwhite,
                  radius: 30,
                  child: IconButton(
                    icon: const Icon(
                      Icons.send,
                      color: Colors.green,
                    ),
                    onPressed: () {
                      data.chatMsgs[data.chatMsgs.length] = [
                        textcontroll.text,
                        true
                      ];
                      textcontroll.clear();
                      setState(() {});
                    },
                  ),
                ),
              )
            ],
          ),
          if (_showEmoji)
            SizedBox(
              height: MediaQuery.of(context).size.height * .35,
              child: EmojiPicker(
                textEditingController: textcontroll,
                config: Config(
                  columns: 8,
                  emojiSizeMax: 32 * (Platform.isIOS ? 1.30 : 1.0),
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    textcontroll.dispose();
    super.dispose();
  }
}
