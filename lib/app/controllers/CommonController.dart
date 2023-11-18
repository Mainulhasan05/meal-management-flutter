import 'package:get/get.dart';
import 'package:gsheets/gsheets.dart';
import 'package:meal_management/sheets/sheets_api.dart';

class CommonController extends GetxController {
  RxString sheetId = ''.obs;
  RxString sheetName = ''.obs;
  // store sheetList in a lis
  RxList sheetList = [].obs;
  // Rx dynamic for sheet Details
  RxList sheetDetails = [].obs;

  Future getSheetList() async {
    sheetList.value = await UserSheetsApi.getListofSheets(sheetId.value);
  }

  Future getSheetData() async {
    print('going to get sheet data');
    print('sheet id: ${sheetId.value}');
    print('sheet name: ${sheetName.value}');
    var sheet =
        await UserSheetsApi.getSheetValues(sheetId.value, sheetName.value);
    // add values except the first row
    sheetDetails.value = sheet!.sublist(1);
    print('sheet details: $sheetDetails');
    // remove fields that are empty
  }
}
