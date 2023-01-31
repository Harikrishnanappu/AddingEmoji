import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String msg;
  final bool isme;
  const MessageBubble({super.key, required this.msg, required this.isme});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment:
              isme ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 8,
              ),
              constraints: BoxConstraints(
                minWidth: 0,
                maxWidth: MediaQuery.of(context).size.width * 0.7,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
              decoration: BoxDecoration(
                color: isme ? const Color(0xff1EBEA5) : Colors.white,
                borderRadius: const BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              child: Text(
                msg,
                softWrap: true,
                style: TextStyle(color: isme ? Colors.white : Colors.black),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 8,
        )
      ],
    );
  }
}
