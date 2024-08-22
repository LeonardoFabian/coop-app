import 'package:public_ip_address/public_ip_address.dart';

Future<String> getIpAddress() async {
  IpAddress _ipAddress = IpAddress();
  var ip = await _ipAddress.getIp();
  print(ip);
  return ip;
}
