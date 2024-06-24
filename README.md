<!DOCTYPE html>
<html>
<head>
  <title>Chatbot Mobile App</title>
</head>
<body>
  <h1>Chatbot Mobile App</h1>
  <p>Welcome to the Chatbot mobile app repository. This project contains a Flutter-based mobile application that connects directly to a generative AI API. Optionally, it can use a backend API for extended functionality.</p>

  <h2>Features</h2>
  <ul>
    <li>Direct interaction with the generative AI API.</li>
    <li>Optional backend API integration for extended features.</li>
  </ul>

  <h2>Getting Started</h2>
  <h3>Prerequisites</h3>
  <ul>
    <li>Flutter SDK</li>
    <li>Dart SDK</li>
    <li>A code editor (e.g., VSCode, Android Studio)</li>
  </ul>

  <h3>Installation</h3>
  <pre><code>
  git clone https://github.com/your-username/chatbot-flutter-app.git
  cd chatbot-flutter-app
  flutter pub get
  flutter run
  </code></pre>

  <h2>Usage</h2>
  <p>The mobile app connects directly to the generative AI API. Simply open the app and start interacting with the chatbot.</p>

  <h3>Optional: Using the Backend API</h3>
  <p>The backend API is hosted at: <a href="https://chatbot-vtc9.onrender.com/chat" target="_blank">https://chatbot-vtc9.onrender.com/chat</a></p>
  <p>To use the backend API, modify the API endpoint in your Flutter app to send requests to:</p>
  <pre><code>
  POST /chat
  {
      "prompt": "hello gpt"
  }
  </code></pre>
  <p>The API will return a response from the generative AI.</p>

  <h2>Contributing</h2>
  <p>We welcome contributions to the Chatbot mobile app! Please fork the repository and submit a pull request.</p>

  <h2>License</h2>
  <p>This project is licensed under the MIT License. See the <a href="LICENSE">LICENSE</a> file for details.</p>

  <h2>Contact</h2>
  <p>If you have any questions, feel free to open an issue or contact us at <a href="mailto:support@example.com">support@example.com</a>.</p>
</body>
</html>
