import 'package:chatgpt_app/main.dart';
import 'package:chatgpt_app/pages/login_page.dart';
import 'package:chatgpt_app/services/alert_services.dart';
import 'package:chatgpt_app/services/auth_service.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';
import 'dart:convert';



class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final ChatUser _currentUser = ChatUser(id: '1', firstName: 'e', lastName: 'a');
  final ChatUser _gptChatUser = ChatUser(id: '2', firstName: 'bot');
  List<ChatMessage> _messages = <ChatMessage>[];
  List<ChatUser> _typingUsers = <ChatUser>[];
  bool _showWelcomeCard = true;
  late AuthService _authService;
  late NavigationService _navigationService;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GetIt _getIt = GetIt.instance;
  User? _user;
  late AlertServices _alertServices;

  @override
  void initState() {
    super.initState();
    _authService = _getIt.get<AuthService>();
    _navigationService = _getIt.get<NavigationService>();
    _alertServices = _getIt.get<AlertServices>();
    _auth.authStateChanges().listen((event) {
      setState(() {
        _user = event;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 90, 89, 89),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 43, 41, 41),
        title: const Text(
          'Chat bot',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            setState(() {
              _messages.clear();
            });
          },
          color: Colors.white,
          icon: const Icon(Icons.new_label),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              bool result = await _authService.logout();
              if (result) {
                _navigationService.pushReplacementNamed('/login');
                _alertServices.showToast(
                  text: "Successfully Logged Out!",
                  icon: Icons.check_circle,
                );
              }
            },
            color: Colors.white,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Stack(
        children: [
          DashChat(
            currentUser: _currentUser,
            typingUsers: _typingUsers,
                inputOptions: InputOptions(
              sendButtonBuilder: (Function() send)=>IconButton(
                onPressed: send, 
                icon: Icon(Icons.send,color: Colors.white,)
                )
            ),
          
            
            messageOptions: const MessageOptions(
              
              
              currentUserContainerColor: Color.fromARGB(255, 59, 54, 54),
              containerColor: Color.fromARGB(255, 59, 54, 54),
              textColor: Colors.white,
              
              
            ),
            
            
            onSend: (ChatMessage m) {
              _sendMessage(m);
            },
            messages: _messages,
          ),
          if (_showWelcomeCard)
            Center(
              child: _buildWelcomeCard(),
            ),
        ],
      ),
    );
  }

  Widget _buildWelcomeCard() {
    return SizedBox(
      
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        
        children: [
          Card(
            
            child: Container(
              height: MediaQuery.of(context).size.height*0.04,
              width: MediaQuery.of(context).size.width*0.95,
             
              decoration:const  BoxDecoration(
                gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                  
                  colors: [
                        Color.fromARGB(255, 32, 19, 53),
                        Color.fromARGB(255, 107, 86, 145),
                  ]
                ),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                

              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Welcome to chat bot! How can I help you today?',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      
                    ),
                    ),
                ],
              ),
              

            
              

            ),
             
            

          ),
         Card(
            
            child: Container(
              height: MediaQuery.of(context).size.height*0.04,
              width: MediaQuery.of(context).size.width*0.95,
             
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                  
                  colors: [
                        Color.fromARGB(255, 32, 19, 53),
                        Color.fromARGB(255, 107, 86, 145),
                  ]
                ),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                

              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Discover new information. How can I assist?",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      
                    ),
                    ),
                ],
              ),
              

            
              

            ),
             
            

          ),
          Card(
            
            child: Container(
              height: MediaQuery.of(context).size.height*0.04,
              width: MediaQuery.of(context).size.width*0.95,
             
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                  
                  colors: [
                        Color.fromARGB(255, 32, 19, 53),
                        Color.fromARGB(255, 107, 86, 145),
                  ]
                ),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                

              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Explore your desire right here. Let's begin!",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      
                    ),
                    ),
                ],
              ),
              

            
              

            ),
             
            

          )
          
        ],
      ),

    );
  
  }

  Future<void> _sendMessage(ChatMessage m) async {
    if (_showWelcomeCard) {
      setState(() {
        _showWelcomeCard = false;
      });
    }

    setState(() {
      _messages.insert(0, m);
      _typingUsers.add(_gptChatUser);
    });

    // Save message to Firestore
    // await _saveMessageToFirestore(m);

    await getChatResponse(m);
  }

  // Future<void> _saveMessageToFirestore(ChatMessage m) async {
  //   await _firestore.collection('Chat_Messages').add({
  //     'userId': _auth.currentUser?.uid, // Add the userId field
  //     'text': m.text,
  //     'createdAt': m.createdAt,
  //     'userName': '${m.user.firstName} ${m.user.lastName}',
  //   });
  // }

  Future<void> getChatResponse(ChatMessage m) async {
    const maxRetries = 3;
    int retryCount = 0;
    bool success = false;

    while (retryCount < maxRetries && !success) {
      try {
        final response = await http.post(
          Uri.parse('https://chatbot-vtc9.onrender.com/chat'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'prompt': m.text}),
        );

        print('Status code: ${response.statusCode}');
        print('Response body: ${response.body}');

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          setState(() {
            _messages.insert(
              0,
              ChatMessage(
                user: _gptChatUser,
                createdAt: DateTime.now(),
                text: data['response'],
              ),
            );
          });
          success = true;
        } else {
          retryCount++;
          await Future.delayed(const Duration(seconds: 1));
        }
      } catch (e) {
        print('Error: $e');
        retryCount++;
        await Future.delayed( const Duration(seconds: 1));
      }
    }

    if (!success) {
      setState(() {
        _messages.insert(
          0,
          ChatMessage(
            user: _gptChatUser,
            createdAt: DateTime.now(),
            text: 'Error: Could not get response',
          ),
        );
      });
    }

    setState(() {
      _typingUsers.remove(_gptChatUser);
    });
  }
}


