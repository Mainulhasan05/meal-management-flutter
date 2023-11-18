import 'package:gsheets/gsheets.dart';

class UserSheetsApi {
  static final API = 'https://meal.rifatewu.xyz/api/data';
  static const _crdientials = r'''
{
  "type": "service_account",
  "project_id": "phrasal-fire-405505",
  "private_key_id": "06bc1c86139a7b36c01811b6161119111b4b4365",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCQKPiYBj5xtF3M\n67Y7UVabM9ALky48uvZcwt8kAF8XJmkozXE5C2EkcsBzVB2/JCuXZCf4Fmj6JHwN\n8WdZ+I6pp/I7VvHXEettIliOqltGD73CYK15gL8dNdoWGzE1JH7OPxJN2bZP90RP\nnwVn6A/B8b8rPXcG0X+LF5LP80NCa3HB8A7oPXkzB/sJ9QUl1nEaUSUra/PUnGwP\nKpwu8z9RCG/8LcQaH9cXk2920Vig0hhAM24yCIgp7mlYVxB4cJEgrojUWGCwxc7u\nD5sK5jbeJf4XHPOWpbiXT5my284HLCeN7SLJ12xW1Kn8DknE16xJEbUbz5TetBj3\nPDxi7zyvAgMBAAECggEAOblOIYGOi3UPgjh4FbRyG19Z1OiwQP0UHPyi4QWNDfYB\ncachyRe3ZCLW0NdDuf+/vLUMFBjVHCRz0BlzquEOLvziz8P2vomcXWy9TRMFzT4M\nW8Lec6KL5CRmGSf2QjNE200CBU5B5C88mS0xuvN/K8ejJqtL99z3VzivPrlHm1ZU\nsnJV1Gz1PGXb5Q5ngj/hKwBFo10qb/qy6EfS0JjbpsOWZTFlizK8RT1gb+L4vj6X\nS6dVgj+PJGnW3xLaCnCcBn2FhGQMSIt6hX9p/ZrPa9z9ZWysNIXW0EwNk/RaKpnD\nCUxt15lL966Lo4f0HER6aOGMcXGii9jTYENr/Kf6UQKBgQDButEPyLyhiBPok3Zo\nYLngWllsXuH/ANqNwJHsjBOwsmgJcrPbqWSsGzC3r3rEHNsHgznr2gLctXh1aFjb\nqu4hz1E9NksXH3zFDzvomOfvZ5fdje7MHdDZuw5xSRhMtPsNFimPYhj0VC7Ehfwv\nKdg70vExfjNzC9LwUo+xXu8YkwKBgQC+f0cHpE4UMj/eTUP6KU4W256rNB0Hrs/8\nSRFZYBJhTMlcmTQwY9nxBRJCRdn1h8az7GEogEgmD3u3LBazaieWpAQmoD3Iz4Hc\n44KYlWq6qtIDFxS8P74lpNXtoJbnCmSifHOmGKLxg3PlotUO9JXSPGAvJOV5FKf/\n/eh/Ovto9QKBgQComPfWf8FB5tZEowj6X6uER7zpJk4SCeEqWjvknCeKsEkAZ/WF\nJo95hJRKV4pE4EPx7s9apbm18KxrqSsjyUdC31T5K6X/8qQ4L0DY9TFsVUCCTUJU\nG2KmCjfQeWePYjXWNsJmiV3kTNsCpwRI22bW8YZ8pzMJXXHvOjrZhyAXxwKBgFPa\nUrnaaUQammKQQEvtwqHtKnrSBbVMDeFPiIN+9pg95KUOCxsB2P1u7gqeFMMvcRfi\nBSJ+1UNrrVmD3ro7EBIPQISAJLIwJUnGG8ZufvyMFMWnc0kqBdksJb7j4Yjx2jpr\n7bw/O/pzkqCSfJaIsypHyU73Pst9fDYC3kSjAefBAoGBAJIJsN1nllRJvZrBkdHF\nX8kOCD5qZYDIiki+0wzz6a65kCr4qSXtbMKq01rbdCe84xDVrUBhPIxikAU60EcX\npqfM94NEAVTs6PVwQfN8K0DfwqA71VBwIuvpAmyEGhWa7HnNdL5xvC8CKY/No3Qi\nWaAeTsxQ1COj/L4FEWRsPpGh\n-----END PRIVATE KEY-----\n",
  "client_email": "gheets@phrasal-fire-405505.iam.gserviceaccount.com",
  "client_id": "101365334186861331765",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/gheets%40phrasal-fire-405505.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"
}
''';
  static final _spreadsheedId = '168LGnpo7rzATrZiPmRyL1mmeNgsxNpgNhzxGxLcrJ7w';
  static final _gsheets = GSheets(_crdientials);
  static Worksheet? _userSheet;

  static Future init() async {
    final spreadsheet = await _gsheets.spreadsheet(_spreadsheedId);
    _userSheet = await _getWorkSheet(spreadsheet, title: 'Users');
  }

  static Future<Worksheet?> _getWorkSheet(
    Spreadsheet spreadsheet, {
    String title = 'users',
  }) async {
    try {
      return await spreadsheet.addWorksheet(title);
    } catch (e) {
      return await spreadsheet.worksheetByTitle(title);
    }
  }

  static Future insert(List<String> values) async {
    if (_userSheet == null) {
      return;
    }
    await _userSheet!.values.appendRow(values);
  }

  static Future getValues() async {
    if (_userSheet == null) {
      return;
    }
    final values = await _userSheet!.values.allRows();
    return values;
  }

  static Future getListofSheets() async {
    final spreadsheet = await _gsheets.spreadsheet(_spreadsheedId);
    final sheets = await spreadsheet.sheets;
    return sheets;
  }
}
