import "package:googleapis_auth/auth_io.dart";


// Use service account credentials to get an authenticated and auto refreshing client.
Future<AuthClient> obtainAuthenticatedClient() async {
  final accountCredentials = ServiceAccountCredentials.fromJson({
    "private_key_id": "9ea30f67c53ad06a1451504294ed43f223cd9b6b",
    "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQC8kzKkdB9axnu7\nzb8g8vM/qbfxcsxhRQsJXasejRuhVepDOGx500Cj/dAWfFHmiO+W1nbgMZszJ9Rz\nUZZmTy638qHeHhKLe/kQvQjBUa2KqbalM5E+CBWYzJAXMxxY/In4oM7sBY4P5q/H\nMLQ3yLXDT3jMCBXvvVJSZXejO+dxMxUaUfHaGIgYiNY9i6V9a+Ev9TGim/EtjEVY\ncLgCvMjne6rbIZAdAI5PtWPaw4dQtiqjkLTgmK+EDUTCfq743PsPREeQu4wSckRW\nAh1z/NotORc5wNipmDoRETh/ct7PS0+p4bSmi1wqyP1qugNBA3M2YSMuFoS5ZsLr\n60itY8jtAgMBAAECggEADhQMNhhgReHnF26FHCPfMqvMSoeYSBPEPusCDToaK7mT\nD3ktKgwyOXwHtsIJyEUFZBS3U8YIUPGijAh1isZTFdMUsBU9K7Ix9kSynGIpa15/\nvwYiTAgE+r8c68p6TY9vCoOQ5zCD+l5t1Zhmf/qpTT9H5K2e26Ld/D5MiAB/JyV4\nz/4X+4AM5SWjs2f5B8qyVA3JRijrSVzBtvwd1ZSLlLMM/cAsl+0f3ST84g8H37g5\nRCWOT0sfSv3eq9wwkWOh8gm84rGzxGzqSqehU6n8Mc8fdFGgYo93CxolJN7bx74V\nA89PSOTXW1av64fM8KxQH0cG1lw9+PfQWYOqgiHSWQKBgQD6x9gSGhMiAEMD54o+\nSjZQgIIY6TUm3YxcJcH192ImbE9X/MId8f0BXPNn439DPf6RrmCwn0QHicoUJOcQ\nM3nzz/O8QJIRPNSTZ0woyDlFHzURV8cTpLgh6ociFUbKypvVM581F97tVjV3lKmO\nLwmiix3GaObkl+wC93pO1QwuhQKBgQDAf+xD1nc0j7kHvdfWHAgamAeEkDa40naM\nOL9unoRQZpqEgbo/FUaPbr5Eljny6HmR9A8RpP7DuoZ+eOU7JS2xwb6bsY4wcEIT\nlSA/3m9Wb4p9mWZ/bwTfGkXmEW7ziLBUBhcDc4L+XgL4CAVDCdOUBc/rlwVA0I+m\nJ+ZEsIwBSQKBgEIoQFceK9f3a7Z2+aBPIZ8BF9EMjKoRHjsc9ts1hN4QCqpykp8l\nvJIEfG32tRb/Hs49y2Is0dyPPBEuXwqGGfD49hq+igokGww73vqPP5R9lBlcJ7eF\n59GCtl2GcWOEKbIH6UMvZe8EpBxEyqoovIj13EgAWpEJhwiNUuXDDHClAoGAGQmK\nZVhjsMZwvn0GsaZ7t1nGwIsxUuCs4pgO7ghYFU0DE/D7lHDj+Ivi23DeoKV0CnO/\n8f+P001TaOe4iPTQ+KnGbOGvKMWxEnL2+teni4p+bM+i8TgzXgFAzie+UpaYuJUC\nMUS46PS5ViFU7d89Uadf37iIymFWDbpqzMxZqWECgYB3+Ng1g3ZCz/VFwj70ePau\nivpo0SQEltGyP9HB622A1nupDEKiMFUq9g2Gy42b10mAxKYal5/V/uIyhT8Q8ZPB\nBKC8WgbZ0bqnYpuzsYj30xLtKtnMX9ub1zVPc1VcxK0z1HH30ImAExXIK8e9H34v\nQYIo8f91ljCqhpHxyzYm1Q==\n-----END PRIVATE KEY-----\n",
    "client_email": "form-776@kiosk-367413.iam.gserviceaccount.com",
    "client_id": "100058819522238181847",
    "type": "service_account"
  });
  List<String> scopes = [
    "https://www.googleapis.com/auth/script.external_request",
    "https://www.googleapis.com/auth/drive",
    "https://www.googleapis.com/auth/drive.readonly",
    "https://www.googleapis.com/auth/forms.body",
    "https://www.googleapis.com/auth/forms.body.readonly",
    "https://www.googleapis.com/auth/forms.responses.readonly"
  ];

  AuthClient client = await clientViaServiceAccount(accountCredentials, scopes);

  return client; // Remember to close the client when you are finished with it.
}