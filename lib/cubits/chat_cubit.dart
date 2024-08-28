import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollections);
  void sendMessage({required String message, required String email}) {
  try{
    messages.add({
      kMessage: message,
      kCreatedAt: DateTime.now(),
      'id': email,
    });
  } on Exception catch (error){

  }
  }

  void getMessages() {
    messages
        .orderBy(kCreatedAt, descending: true)
        .snapshots()
        .listen((event) {
          emit(ChatSuccess());
    });
  }
}
