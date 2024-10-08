import 'package:chat_app/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants.dart';
import '../cubits/chat_cubit.dart';
import '../widgets/chat_bubble.dart';
import '../widgets/chat_bubble_for_friend.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollections);

  TextEditingController controller = TextEditingController();
  List<MessageModel> messagesList = [];
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    Object? email = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              kLogo,
              height: 50,
            ),
            const Text("Scholar chat"),
          ],
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatCubit, ChatState>(
              builder: (BuildContext context, ChatState state) {
                List<MessageModel> messagesList = BlocProvider.of<ChatCubit>(context).messagesList;
                return ListView.builder(
                  controller: scrollController,
                  itemCount: messagesList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return messagesList[index].id == email
                        ? ChatBubble(
                            messageModel: messagesList[index],
                          )
                        : ChatBubbleForFriend(
                            messageModel: messagesList[index]);
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: controller,
              onSubmitted: (data) {
                controller.clear();
                scrollController.animateTo(
                  scrollController.position.maxScrollExtent,
                  duration: const Duration(seconds: 10),
                  curve: Curves.easeIn,
                );
              },
              decoration: InputDecoration(
                  hintText: "Send Message ",
                  suffixIcon: const Icon(
                    Icons.send,
                    color: kPrimaryColor,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16))),
            ),
          )
        ],
      ),
    );
  }
}
