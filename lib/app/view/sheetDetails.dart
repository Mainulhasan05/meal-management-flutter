import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:gsheets/gsheets.dart';

import '../../sheets/sheets_api.dart';
import '../controllers/CommonController.dart';

class SheetDetails extends StatefulWidget {
  const SheetDetails({super.key});

  @override
  State<SheetDetails> createState() => _SheetDetailsState();
}

class _SheetDetailsState extends State<SheetDetails> {
  CommonController commonController = Get.put(CommonController());
  // create controller for each input field
  TextEditingController itemController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sheet Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // sheet id
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                commonController.sheetName.value,
                style: const TextStyle(fontSize: 20),
              ),
            ),
            // create input field to insert item, quantity, price, and date
            TextField(
              controller: itemController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Item',
              ),
            ),
            TextField(
              controller: quantityController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Quantity',
              ),
            ),
            TextField(
              controller: priceController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Price',
              ),
            ),
            TextField(
              controller: dateController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Date',
              ),
            ),

            // create button to submit data to sheet
            ElevatedButton(
              onPressed: () async {
                // create a list of values to be inserted
                List<String> values = [
                  itemController.text,
                  quantityController.text,
                  priceController.text,
                  dateController.text
                ];
                // insert values to sheet
                await UserSheetsApi.insertValues(
                  commonController.sheetId.value,
                  commonController.sheetName.value,
                  values,
                );
                // show toast message
                SnackBar snackBar = SnackBar(
                  content: Text('Data inserted successfully'),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                commonController.getSheetData();
                // clear all input field
                itemController.clear();
                quantityController.clear();
                priceController.clear();
                dateController.clear();
              },
              child: const Text('Submit'),
            ),
            SizedBox(
              height: 20,
            ),

            // show a four column table
            Obx(
              () => DataTable(
                columns: const [
                  DataColumn(label: Text('Item')),
                  DataColumn(label: Text('Quantity')),
                  DataColumn(label: Text('Price')),
                  DataColumn(label: Text('Date')),
                ],
                rows: List<DataRow>.generate(
                  1,
                  (int index) => commonController.sheetDetails[index].length ==
                          0
                      ? DataRow(cells: <DataCell>[DataCell(Text(''))])
                      : DataRow(
                          cells: <DataCell>[
                            DataCell(Text(
                                commonController.sheetDetails[index][0] ?? "")),
                            DataCell(Text(
                                commonController.sheetDetails[index][1] ?? "")),
                            DataCell(Text(
                                commonController.sheetDetails[index][2] ?? "")),
                            DataCell(Text(
                                commonController.sheetDetails[index][3] ?? "")),
                          ],
                        ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
