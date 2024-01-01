import 'package:flutter/material.dart';
import 'package:intl/intl.dart';



/// Chat data model class
class Chat {
  /// The date the chat message is created at / posted at
  final DateTime createdAt;

  /// The actual chat text message
  final String text;

  /// The sender of the chat message
  final String sender;

  /// Constructor
  Chat({
    required this.createdAt,
    required this.text,
    required this.sender,
  });
}


// set current date & time
final now = DateTime.now();

// Dummy data: List of Chats
List<Chat> dummyChats = [
  Chat(
    createdAt: now,
    text: 'Text1',
    sender: 'userA',
  ),
  Chat(
    createdAt: now,
    text: 'Text2',
    sender: 'userA',
  ),
  Chat(
    createdAt: now.add(const Duration(minutes: 1)),
    text: 'Text3',
    sender: 'userB',
  ),
  Chat(
    createdAt: now.add(const Duration(minutes: 1)),
    text: 'Text4',
    sender: 'userA',
  ),
  Chat(
    createdAt: now.add(const Duration(days: 1, minutes: 5)),
    text: 'Text5',
    sender: 'userB',
  ),
  Chat(
    createdAt: now.add(const Duration(days: 1, minutes: 6)),
    text: 'Text6',
    sender: 'userA',
  ),
  Chat(
    createdAt: now.add(const Duration(days: 2, minutes: 6)),
    text: 'Text7',
    sender: 'userA',
  ),
  Chat(
    createdAt: now.add(const Duration(days: 2, minutes: 10)),
    text: 'Text8',
    sender: 'userA',
  ),
  Chat(
    createdAt: now.add(const Duration(days: 3, minutes: 90)),
    text: 'Text9',
    sender: 'userB',
  ),
  Chat(
    createdAt: now.add(const Duration(days: 3, minutes: 90)),
    text: 'Text10',
    sender: 'userA',
  ),
  Chat(
    createdAt: now.add(const Duration(days: 4, minutes: 100)),
    text: 'Text11',
    sender: 'userB',
  ),
];


void main() {
  runApp(MyApp());
}

/// MyApp class
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChatPage(),
    );
  }
}

class ChatPage extends StatelessWidget {
  ChatPage({Key? key}) : super(key: key);

  // Set dummy data
  // (usually you will get this data from your database using StreamBuilder etc.X)
  final chats = dummyChats;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat App'),
        backgroundColor: Colors.green[300],
      ),
      backgroundColor: Colors.green[50],
      body: _chatBody(),
    );
  }

  Widget _chatBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        child: ListView.builder(
            itemCount: chats.length,
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            padding: const EdgeInsets.only(
              left: 10.0,
              right: 10.0,
              bottom: 70.0,
              top: 10.0,
            ),
            itemBuilder: (context, index) {
              // current chat data from list of chats
              final chat = chats[index];

              // chat created at date (we will use this to create the timestamp and date widget)
              final createdAt = chat.createdAt;

              // we will use this variable to check it the current date is similar as previous date
              // set to false as default
              var isSameDate = false;

              // return True if is same date
            //  isSameDate = tmpDate.isSameDate(createdAt);

              // Show Date Separator widget if not same date (date changed)
              if (!isSameDate) {
                // Reset tmpDate with current message createdAt date
              //  tmpDate = createdAt;
              }


              // check if the chat sender is the user
              // In this tutorial, the user (us) will be [userA]
              // This would be the user id in a real app.
              final isMe = chat.sender == 'userA';

              // text message included in chat
              final text = chat.text;

              // retrieve timestamp and date String value using Date utility we created in [DateUtil.dart]
              final timestamp = DateUtil.hMMFormat(createdAt);
              final date = DateUtil.dateWithDayFormat(createdAt);

              // Pass these parameters to chat bubble widget which we will create later
              final _chatBubble = ChatBubble(
                isMe: isMe,
                text: text,
                timestamp: timestamp,
                showDate: !isSameDate,
                date: date,
              );

              // return the chat bubble created above
              return _chatBubble;
            }),
      ),
    );
  }
}


/// DateTime extension
extension DateTimeTimeExtension on DateTime {
  /// return true if input date is same
  bool isSameDate(DateTime inputDate) {
    return year == inputDate.year &&
        month == inputDate.month &&
        day == inputDate.day;
  }
}

/// Date Utility class
class DateUtil {
  /// get tomorrow's date
  static DateTime tomorrow() {
    // current date
    final now = DateTime.now();

    return DateTime(now.year, now.month, now.day + 1);
  }

  /// convert to [H:mm] format
  static String hMMFormat(DateTime dateTime) {
    return DateFormat('H:mm').format(dateTime);
  }

  /// convert to [M/d (day)] format
  static String dateWithDayFormat(DateTime dateTime) {
    // get name of days of the week
    final weekName = _weekNames()[dateTime.weekday];

    // get date string value
    final date = DateFormat('M/d').format(dateTime);

    return date + ' ($weekName)';
  }

  // List of days of week
  static List<String> _weekNames() {
    return <String>[
      '',
      'Mon',
      'Tue',
      'Wed',
      'Thur',
      'Fri',
      'Sat',
      'Sun',
    ];
  }
}


/// Chat Bubble widget class
class ChatBubble extends StatelessWidget {
  /// consctructor
  const ChatBubble(
      {Key? key,
        required this.isMe,
        required this.text,
        required this.timestamp,
        required this.showDate,
        required this.date})
      : super(key: key);

  // return true if the chat sender is the user
  final bool isMe;

  // chat text message
  final String text;

  // chat timestamp value
  final String timestamp;

  // return true if should show date widget
  final bool showDate;

  // chat date value
  final String date;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // show Date Separator widget if True
          if (showDate) _dateSeparator(context, date),

          _bubbleRow(context),
        ],
      ),
    );
  }

  // Chat bubble row widget
  Widget _bubbleRow(BuildContext context) {
    return Row(
      // align chat bubble to left side if is User, else align to right side
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // if is User, show timestamp widget on left side
        if (isMe) _timestamp(context),

        // text bubble widget
        _textBubble(context),

        // if is not User, show timestamp widget on right side
        if (!isMe) _timestamp(context),
      ],
    );
  }

  /// Text Bubble widget
  Widget _textBubble(BuildContext context) {
    return Flexible(
      child: Container(
        // make the maximum width of the chat bubble 0.74 of screen width
        constraints:
        BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.74),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            // if is User, set bubble color to white, else set to green
            color: isMe ? Colors.white : Colors.green[400],

            // Change bubble border radius based on chat sender
            borderRadius: BorderRadius.only(
              bottomRight: isMe ? Radius.zero : const Radius.circular(20),
              topLeft: const Radius.circular(20),
              bottomLeft: isMe ? const Radius.circular(20) : Radius.zero,
              topRight: const Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 3,
                offset: const Offset(0, 1),
              ),
            ],
          ),

          // use SelectableText widget instead of a nornaml Text widget so that we can select and copy the text (optional)
          child: SelectableText(
            text,
            toolbarOptions: const ToolbarOptions(
              copy: true,
              selectAll: true,
              cut: false,
              paste: false,
            ),
            style: TextStyle(
              color: isMe ? Colors.black54 : Colors.white,
              fontSize: 16.0,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ),
    );
  }

  /// Chat Bubble Timestamp widget
  Widget _timestamp(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          const SizedBox(height: 4),
          Text(
            timestamp,
            style: const TextStyle(
              fontSize: 10.0,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  /// Date Separator widget
  Widget _dateSeparator(BuildContext context, String date) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Stack(
        children: [
          const Divider(),
          Center(
            child: Container(
              height: 20,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              color: Colors.green[50],
              child: Text(
                date,
                style: const TextStyle(
                  color: Colors.black45,
                  fontSize: 12.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


