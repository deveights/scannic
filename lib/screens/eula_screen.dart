import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:scannic/data/eula.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EulaScreen extends StatefulWidget {
  const EulaScreen({super.key});

  @override
  State<EulaScreen> createState() => _EulaScreenState();
}

class _EulaScreenState extends State<EulaScreen> {
  InAppWebViewController? webViewController;
  bool _isAtBottom = false;

  String eulaHtml = """  
  <html>
    <head>
      <script type="text/javascript" src="https://app.termly.io/embed-policy.js"></script>
      <script>
        function checkScroll() {
          var scrollTop = document.documentElement.scrollTop || document.body.scrollTop;
          var scrollHeight = document.documentElement.scrollHeight || document.body.scrollHeight;
          var clientHeight = document.documentElement.clientHeight || window.innerHeight;
          var scrolledToBottom = (scrollTop + clientHeight) >= (scrollHeight - 10);
          
          if (scrolledToBottom) {
            window.flutter_inappwebview.callHandler('scrolledToBottom');
          }
        }
        window.onscroll = checkScroll;
      </script>
    </head>
    <body>
      ${Eula().eulaHtml}
    </body>
  </html>
  """;

  Future<void> _acceptEula() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("accepted_eula", true);
    Navigator.pop(context); // Close the screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("EULA")),
      body: Column(
        children: [
          Expanded(
            child: InAppWebView(
              initialData: InAppWebViewInitialData(data: eulaHtml),
              onWebViewCreated: (controller) {
                webViewController = controller;
                webViewController?.addJavaScriptHandler(
                  handlerName: 'scrolledToBottom',
                  callback: (args) {
                    setState(() {
                      _isAtBottom = true;
                    });
                  },
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed:
                  _isAtBottom ? _acceptEula : null, // Disable until scrolled
              child: Text("Accept"),
            ),
          ),
        ],
      ),
    );
  }
}
