// import 'package:http/http.dart' as http;
//
// class BaseNetwork {
//   static final String baseUrl = "https://booking.kai.id/api/";
//
//   static Future<http.Response> get(String endpoint) async {
//     final response = await http.get(Uri.parse('$baseUrl$endpoint'));
//
//     if (response.statusCode == 200) {
//       return response;
//     } else {
//       throw Exception('Failed to load data');
//     }
//   }
// }
//
// class StationApi {
//   static Future<http.Response> getStations() {
//     final endpoint = 'stations2';
//     return BaseNetwork.get(endpoint);
//   }
// }
//
// void fetchData() async {
//   try {
//     final response = await StationApi.getStations();
//     // Handle response data
//     print(response.body);
//   } catch (e) {
//     // Handle error
//     print('Error: $e');
//   }
// }