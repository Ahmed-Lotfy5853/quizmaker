import 'package:flutter/material.dart';
import 'package:quiz_maker/Presentation/Screens/Student%20Screens/chat/student_all_chats.dart';

import '../../../../Constants/Strings.dart';
import '../../../../Data/Models/user.dart';

class ChatDetails extends StatefulWidget {
  const ChatDetails({super.key, required this.chat});
  final ChatModel chat;


  @override
  State<ChatDetails> createState() => _ChatDetailsState();
}

class _ChatDetailsState extends State<ChatDetails> {
  double height (BuildContext context,double height)=> MediaQuery.sizeOf(context).height*height;
  double width (BuildContext context,double width)=> MediaQuery.sizeOf(context).width*width;
  double textFontSize (BuildContext context,double fontSize)=> MediaQuery.textScalerOf(context).scale(fontSize);
List<MessageModel> messages = [
  MessageModel(sender: User(name: 'Mohamed', photoUrl: 'assets/images/ahmed.jpg', email: '', uid: '', isTeacher: true), message: 'Hi', time: '5:00', receiver: User(name: 'Ahmed', photoUrl: 'assets/images/ahmed.jpg', email: '', uid: '', isTeacher: true)),
  MessageModel(sender: User(name: 'Ahmed', photoUrl: 'assets/images/ahmed.jpg', email: '', uid: '', isTeacher: true), message: 'Hi', time: '5:01', receiver: User(name: 'Mohamed', photoUrl: 'assets/images/ahmed.jpg', email: '', uid: '', isTeacher: true)),
  MessageModel(sender: User(name: 'Mohamed', photoUrl: 'assets/images/ahmed.jpg', email: '', uid: '', isTeacher: true), message: 'Hi', time: '5:00', receiver: User(name: 'Ahmed', photoUrl: 'assets/images/ahmed.jpg', email: '', uid: '', isTeacher: true)),
  MessageModel(sender: User(name: 'Ahmed', photoUrl: 'assets/images/ahmed.jpg', email: '', uid: '', isTeacher: true), message: 'Hi', time: '5:01', receiver: User(name: 'Mohamed', photoUrl: 'assets/images/ahmed.jpg', email: '', uid: '', isTeacher: true)),
  MessageModel(sender: User(name: 'Mohamed', photoUrl: 'assets/images/ahmed.jpg', email: '', uid: '', isTeacher: true), message: 'Hi', time: '5:00', receiver: User(name: 'Ahmed', photoUrl: 'assets/images/ahmed.jpg', email: '', uid: '', isTeacher: true)),
  MessageModel(sender: User(name: 'Ahmed', photoUrl: 'assets/images/ahmed.jpg', email: '', uid: '', isTeacher: true), message: 'Hi', time: '5:01', receiver: User(name: 'Mohamed', photoUrl: 'assets/images/ahmed.jpg', email: '', uid: '', isTeacher: true)),
  MessageModel(sender: User(name: 'Mohamed', photoUrl: 'assets/images/ahmed.jpg', email: '', uid: '', isTeacher: true), message: 'Hi', time: '5:00', receiver: User(name: 'Ahmed', photoUrl: 'assets/images/ahmed.jpg', email: '', uid: '', isTeacher: true)),
  MessageModel(sender: User(name: 'Ahmed', photoUrl: 'assets/images/ahmed.jpg', email: '', uid: '', isTeacher: true), message: 'Hi', time: '5:01', receiver: User(name: 'Mohamed', photoUrl: 'assets/images/ahmed.jpg', email: '', uid: '', isTeacher: true)),
  MessageModel(sender: User(name: 'Mohamed', photoUrl: 'assets/images/ahmed.jpg', email: '', uid: '', isTeacher: true), message: 'Hi', time: '5:00', receiver: User(name: 'Ahmed', photoUrl: 'assets/images/ahmed.jpg', email: '', uid: '', isTeacher: true)),
  MessageModel(sender: User(name: 'Ahmed', photoUrl: 'assets/images/ahmed.jpg', email: '', uid: '', isTeacher: true), message: 'Hi', time: '5:01', receiver: User(name: 'Mohamed', photoUrl: 'assets/images/ahmed.jpg', email: '', uid: '', isTeacher: true)),
  MessageModel(sender: User(name: 'Mohamed', photoUrl: 'assets/images/ahmed.jpg', email: '', uid: '', isTeacher: true), message: 'Hi', time: '5:00', receiver: User(name: 'Ahmed', photoUrl: 'assets/images/ahmed.jpg', email: '', uid: '', isTeacher: true)),
  MessageModel(sender: User(name: 'Ahmed', photoUrl: 'assets/images/ahmed.jpg', email: '', uid: '', isTeacher: true), message: 'Hi', time: '5:01', receiver: User(name: 'Mohamed', photoUrl: 'assets/images/ahmed.jpg', email: '', uid: '', isTeacher: true)),
  MessageModel(sender: User(name: 'Mohamed', photoUrl: 'assets/images/ahmed.jpg', email: '', uid: '', isTeacher: true), message: 'Hi', time: '5:00', receiver: User(name: 'Ahmed', photoUrl: 'assets/images/ahmed.jpg', email: '', uid: '', isTeacher: true)),
  MessageModel(sender: User(name: 'Ahmed', photoUrl: 'assets/images/ahmed.jpg', email: '', uid: '', isTeacher: true), message: 'Hi', time: '5:01', receiver: User(name: 'Mohamed', photoUrl: 'assets/images/ahmed.jpg', email: '', uid: '', isTeacher: true)),

];
  TextEditingController messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.teal,
      leading: BackButton(color: Colors.white,),
      title: Row(
        children: [
          Container(
            width:width(context,0.1) ,
            height:width(context,0.1) ,
            margin: EdgeInsets.only(right: 10.0),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: AssetImage(widget.chat.user.photoUrl),
                    fit: BoxFit.fill
                )
            ),
          ),
          Text(widget.chat.user.name,style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white),),


        ]
      ),
    ),
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: Container(
        height: height(context, 1),
        padding: EdgeInsets.only(bottom:height(context, 0.07)+10),

        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(backgroundAsset),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView.builder(itemBuilder: (context,index)=>

          chatItem(messages[index]),
        itemCount: messages.length,
        // padding: EdgeInsets.only(bottom:height(context, 0.07)),
        ),
      ),
      bottomNavigationBar: Container(
        width: width(context, 1),
        // height: height(context, 0.07),

        child: Row(
          children: [
            Expanded(child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
              child: TextFormField(
                controller: messageController,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white),
                keyboardType: TextInputType.multiline,
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  hintText: "Enter your Message...",
                  contentPadding: EdgeInsets.symmetric(horizontal: height(context, 0.07/2),),
                  constraints: BoxConstraints(minHeight: height(context, 0.07),maxHeight: height(context, 0.07)),
                  hintStyle: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.tealAccent,width: 2),
                    borderRadius: BorderRadius.horizontal(right: Radius.circular(height(context, 0.07)),left: Radius.circular(height(context, 0.07))),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.tealAccent,width: 2),
                    borderRadius: BorderRadius.horizontal(right: Radius.circular(height(context, 0.07)),left: Radius.circular(height(context, 0.07))),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.tealAccent,width: 2),
                    borderRadius: BorderRadius.horizontal(right: Radius.circular(height(context, 0.07)),left: Radius.circular(height(context, 0.07))),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.tealAccent,width: 2),
                    borderRadius: BorderRadius.horizontal(right: Radius.circular(height(context, 0.07)),left: Radius.circular(height(context, 0.07))),
                  ),

                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.tealAccent,width: 2),
                    borderRadius: BorderRadius.horizontal(right: Radius.circular(height(context, 0.07)),left: Radius.circular(height(context, 0.07))),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.tealAccent,width: 2),
                    borderRadius: BorderRadius.horizontal(right: Radius.circular(height(context, 0.07)),left: Radius.circular(height(context, 0.07))),
                  ),
                )
              ),
            )),
            IconButton(onPressed: (){}, icon: Container(
                width: height(context, 0.07),
                height: height(context, 0.07),
                decoration: BoxDecoration(
                  color: Colors.teal,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.send,color: Colors.white,)))
          ],
        ),
      ),
    );
  }
  Widget chatItem(MessageModel messageModel){
    var isMe = messageModel.sender.name == 'Ahmed';
    return Container(
      width: width(context, 1),
      padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
      alignment:  isMe? Alignment.centerRight : Alignment.centerLeft,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        textDirection:  isMe? TextDirection.rtl : TextDirection.ltr,
        children: [
          if(!isMe)
            Container(
              width:width(context,0.08) ,
              height:width(context,0.08) ,
              margin: EdgeInsets.only(right: 10.0),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: AssetImage(widget.chat.user.photoUrl),
                      fit: BoxFit.fill
                  )
              ),
            ),
          Container(
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: isMe ? Colors.teal : Colors.white,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Text(messageModel.message,style: Theme.of(context).textTheme.titleMedium!.copyWith(color: isMe ? Colors.white : Colors.black),),)

        ],
      ),

    );
  }
}
