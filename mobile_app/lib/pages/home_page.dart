import 'package:chatgpt_app/widget/gradient_text.dart';
import 'package:flutter/material.dart';


class HomePage extends StatelessWidget {
  static const routeName  = '/home';
   const HomePage({super.key});
   
  

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: const Text(
          "AI ChatBot", 
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white),
            ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          
            colors: [
              Colors.black87,
              Colors.black87,
         
          ]
            
            )

        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height*0.13
            ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            
            
            children: [
              Card(
                
                child: Container(
                  height: MediaQuery.of(context).size.height*0.2,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        //get colors from hex
                        Color(0xFFF69170),
                        Color(0xFF7D96E6),
                      ]
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 16.0, left: 16.0),
                            child: (
                              Text(
                                "Hi! You Can Ask Me", 
                                style:  TextStyle(fontSize: 20.0, 
                                fontWeight: FontWeight.bold, color: Colors.white
                                )
                                )
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 16.0),
                            child: (
                                Text("Anything", style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white))
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0, left: 16.0, bottom: 16.0),
                            child: (
                              TextButton(
                                onPressed: (){
                                  Navigator.pushNamed(context, '/chat');
                                },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                  foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                                ),
                                child: const  Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                                  child: GradientText(
                                    "Ask Now",
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    gradient: LinearGradient(
                                      colors: [
                                        Color(0xFFF69170),
                                        Color(0xFF7D96E6),
                                      ]
                                    ),
                                  ),
                                )
                              )
                            ),
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 16.0),
                        // child: DecoratedBox(
                        //   decoration: BoxDecoration(
                            
                        //   image: DecorationImage(
                            
                        //     //image: AssetImage("assets/images/icon.png"), 
                        //     fit: BoxFit.cover),
                        // ),
                        // child: SizedBox(height: 150, width: 150,),
                        // ),
                      )
                    ],
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 16.0, left: 16.0),
                child: Text(
                  "Services", 
                  style: TextStyle(fontSize: 20.0, 
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                  ),
                  ),
              ),
             SizedBox(height: MediaQuery.of(context).size.height*0.01,),
             SizedBox(


               child: Row(
                children: [
                  Column(
                    children: [
                      Card(
                        child: Container(
                decoration:  const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        //get colors from hex
                            Color(0xFF4C49CA),
                            Color(0xFF4F75F3),

                      ]
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                          height: MediaQuery.of(context).size.height*0.26,
                          width: (MediaQuery.of(context).size.width-32)/2,
                         
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            
                            children: [
                              
                             
                              Text("Brainstorming",style: TextStyle(color: Colors.white,fontSize: 16),),
                              Text("Presentation ideas",style: TextStyle(color: Colors.white,fontSize: 16),),
                              Text("about a topic",style: TextStyle(color: Colors.white,fontSize: 16),)
                            ],
                          
                          ),
                        ),
                       
               
                      )
                    ],
                    
               
                  ),
                 Column(
                    children: [
                      Card(
                        child: Container(
                          height: MediaQuery.of(context).size.height*0.26,
                          width: MediaQuery.of(context).size.width/2,
                         decoration: const BoxDecoration(
                           gradient: LinearGradient(
                             begin: Alignment.topLeft,
                             end: Alignment.bottomRight,
                             colors: [
                        //get colors from hex
                            Color(0xFF4C49CA),
                            Color(0xFF4F75F3),

                             ]
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            
                            children: [
                              Text("Revise my writing",style: TextStyle(color: Colors.white,fontSize: 16),),
                              Text("and fix my",style: TextStyle(color: Colors.white,fontSize: 16),),
                              Text("grammer",style: TextStyle(color: Colors.white,fontSize: 16),)
                            ],
                          
                          ),
                        ),
                       
               
                      )
                    ],
                    
               
                  )
                ],
               
               ),
             )

            ],
          ),
        ),
      ),
    );
  }
}
