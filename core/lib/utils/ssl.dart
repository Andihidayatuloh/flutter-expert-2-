import 'dart:io';
import 'package:core/core.dart';
import 'package:flutter/services.dart';
import 'package:http/io_client.dart';

class PinSSL {
  static Future<IOClient> get ssl async {
    final sslCert = await rootBundle.load('$BASE_SSL_CERT/certificates.cer');
    SecurityContext securityContext = SecurityContext(withTrustedRoots: false);
    securityContext.setTrustedCertificatesBytes(sslCert.buffer.asInt8List());

    HttpClient httpClient = HttpClient(context: securityContext);
    httpClient.badCertificateCallback = (cert, host, port) => false;
    return IOClient(httpClient);
  }
}

