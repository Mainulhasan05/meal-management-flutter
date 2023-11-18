import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:gsheets/gsheets.dart';
import 'package:meal_management/app/controllers/CommonController.dart';

class SheetsScreen extends StatefulWidget {
  const SheetsScreen({super.key});

  @override
  State<SheetsScreen> createState() => _SheetsScreenState();
}

class _SheetsScreenState extends State<SheetsScreen> {
  CommonController commonController = Get.put(CommonController());
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sheets Screen'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // sheet id
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                commonController.sheetId.value,
                style: const TextStyle(fontSize: 20),
              ),
            ),
            // sheet list
            ListView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: commonController.sheetList.length,
              itemBuilder: (BuildContext context, int index) {
                Worksheet sheet = commonController.sheetList[index];
                return GestureDetector(
                  onTap: () async {
                    commonController.sheetName.value = sheet.title;
                    print('sheet name: ${commonController.sheetName.value}');
                    commonController.getSheetData();

                    Navigator.pushNamed(context, '/sheetDetails');
                  },
                  child: ListTile(
                    title: Text(sheet.title),
                    subtitle: Text(sheet.id.toString()),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
