#Sample Video
 - https://drive.google.com/file/d/1umsSgVV2Bo0SkcYTc0dKm83nYRFN9F8r/view?usp=sharing
# Chatbot Mobile App

Welcome to the Chatbot mobile app repository. This project contains a Flutter-based mobile application that connects directly to a generative AI API. Optionally, it can use a backend API for extended functionality.

## Features
- Direct interaction with backend api.
- Firebase integration for database functionality.
- Optional backend API integration for extended features.

## Getting Started

### Prerequisites
- Flutter SDK
- Dart SDK
- A code editor (e.g., VSCode, Android Studio)

### Installation
```sh
git clone https://github.com/Fasill/chatBot.git
cd chatBot
flutter pub get
flutter run
```

## Usage

The mobile app connects directly to the generative AI API. Simply open the app and start interacting with the chatbot.

###Using the Backend API

The backend API is hosted at: [https://chatbot-vtc9.onrender.com/chat](https://chatbot-vtc9.onrender.com/chat)

To use the backend API, modify the API endpoint in your Flutter app to send requests to:
```json
POST /chat
{
    "prompt": "hello gpt"
}
```
The API will return a response from the generative AI.

This Application is Developed by:  
1 Abenezer Gamena  
2 Fasil Hawultie  
3 Firaif Lenjisa  
4 Sewasew Tadele  
5 Tinebeb Amsalu
6 Abel Alemu

