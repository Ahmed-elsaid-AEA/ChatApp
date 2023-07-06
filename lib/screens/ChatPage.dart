import 'package:chatapp/models/MessageModels.dart';
import 'package:chatapp/shared/components/ChatBubble.dart';
import 'package:chatapp/shared/components/CustomFormTextField.dart';
import 'package:chatapp/shared/constants.dart';
import 'package:chatapp/shared/helper/SnackBarShowenClass.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessageCollections);
  final _contollerListView = ScrollController();
  TextEditingController controller = TextEditingController();
  String? message;
  String? email;

  @override
  Widget build(BuildContext context) {
    email = ModalRoute.of(context)!.settings.arguments as String;
    return StreamBuilder<QuerySnapshot>(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<MessageModels> messagesList = [];
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              messagesList.add(MessageModels.fromJson(snapshot.data!.docs[i]));
            }
            return Scaffold(
              appBar: AppBar(
                backgroundColor: kMainColor, //background of app bar
                title: Row(mainAxisSize: MainAxisSize.min, children: [
                  Image.asset(
                    kLogoImage,
                    width: 50,
                    height: 50,
                  ),
                  const Text(' Chat App'),
                ]), //text of app bar
                centerTitle: true, //to make title in center
                automaticallyImplyLeading:
                    false, //to hiden arrow that go back screen
              ),
              body: Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                        reverse: true,
                        controller: _contollerListView,
                        itemBuilder: (context, index) =>
                            messagesList[index].id == email
                                ? ChatBubble(text: messagesList[index].message,email: email,)
                                : ChatBubbleForFriend(email: email,
                                    text: messagesList[index].message),
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 0),
                        itemCount: messagesList.length),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomFormTextField(
                        onChanged: (value) {
                          message = value;
                        },
                        onSuffixIConPressed: () {
                          try {
                            if (message!.isNotEmpty) {
                              Future<void> send =
                                  addNewMessage(message!).then((value) {
                                controller.clear();

                                _contollerListView.animateTo(0,
                                    duration: Duration(milliseconds: 500),
                                    curve: Curves.easeIn);
                              });
                            } else {
                              SnackBarShowenClass()
                                  .showSnackBar(context, 'Enter First Message');
                            }
                          } catch (ex) {
                            SnackBarShowenClass()
                                .showSnackBar(context, ex.toString());
                          }
                        },
                        controller: controller,
                        onSubmitted: (value) {
                          //to send data
                          try {
                            Future<void> send =
                                addNewMessage(value).then((value) {
                              controller.clear();
                              _contollerListView.animateTo(0,
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.easeIn);
                            });
                          } catch (ex) {
                            SnackBarShowenClass()
                                .showSnackBar(context, ex.toString());
                          }
                        },
                        suffixIconColor: Colors.blue,
                        suffixIcon: Icons.send,
                        cursorColor: Colors.black,
                        hintText: 'Enter Message',
                        labelText: 'Message',
                        labelColor: Colors.grey,
                        textColor: Colors.black),
                  ),
                ],
              ),
            );
          } else {
            return Scaffold(body: Center(child: Text('Loding.....')));
          }
        },
        stream: messages
            .orderBy(
              'createdAt',
              descending: true,
            )
            .snapshots());
  }

  Future<void> addNewMessage(String value) {
    Future<void> send = messages.add({
      'message': value,
      'createdAt': DateTime.now(),
      'id': email.toString(),
    });
    return send;
  }
}
