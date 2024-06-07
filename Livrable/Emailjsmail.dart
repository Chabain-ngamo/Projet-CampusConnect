//import 'package:http/http.dart' as http;
import 'dart:convert';

Future mail_sender(
  String? email,
) async {
  email = email ?? '';

  final url = Uri.parse("https://api.emailjs.com/api/v1.0/email/send");
  const service_id = "service_frj2oif";
  const template_id = "service_frj2oif";
  const user_id = "9uo0i4JOqQSsiXL2o";
  final response = await http.post(url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        "service_id": service_id,
        "template_id": template_id,
        "user_id": user_id,
        "template_params": {
          "sent_to": email,
        }
      }));
  return response.statusCode;
}
