import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../functions/image_picker.dart';
import '../functions/httpRequest.dart';

class CXR_page extends StatefulWidget {
  @override
  _CXR_pageState createState() => _CXR_pageState();
}

class _CXR_pageState extends State<CXR_page> {
  File pickedImage;
  Map outputData;
  ImgPicker imgPicker = ImgPicker();
  HttpOperations httpOperations = HttpOperations();

  void showErrDialog(msg) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('An Error Occurd'),
        content: Text(msg),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Okk'))
        ],
      ),
    );
  }

  void imagepickerFn() async {
    try {
      File selectedimg = await imgPicker.selctImg();
      setState(() {
        pickedImage = selectedimg;
      });
    } catch (e) {
      showErrDialog(e.toString());
    }
  }

  void predictFn() async {
    EasyLoading.show(status: 'Loading....');
    var data = await httpOperations.PostRequest(
        image: pickedImage, urlEndpoint: 'predict_cxr');
    EasyLoading.dismiss();
    setState(() {
      outputData = data;
    });
    print(outputData);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(20)),
              child: (pickedImage != null)
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.file(
                        pickedImage,
                        fit: BoxFit.cover,
                      ))
                  : Center(
                      child: Text(
                        'No Image Selected',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ),
            ),
            TextButton.icon(
                onPressed: imagepickerFn,
                icon: Icon(Icons.image),
                label: Text("Select Image")),
            ElevatedButton.icon(
              onPressed: (pickedImage == null) ? null : predictFn,
              icon: Icon(Icons.analytics_outlined),
              label: Text("Predict"),
            ),
            Container(
              padding: EdgeInsets.only(top: 20),
              width: double.infinity,
              child: (outputData != null)
                  ? Column(
                      children: [
                        Center(
                          child: Text(
                            'Prediction',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        DataTable(
                          dataRowColor: MaterialStateProperty.resolveWith(
                              (states) => Colors.grey[200]),
                          columns: [
                            DataColumn(label: Text("Model Name")),
                            DataColumn(label: Text("Covid")),
                            DataColumn(label: Text("Non Covid")),
                          ],
                          rows: [
                            DataRow(
                              cells: [
                                DataCell(Text("VGG16")),
                                DataCell(Text(
                                    '${outputData['vgg_covid'].toStringAsFixed(2)}' ??
                                        '')),
                                DataCell(Text(
                                    '${(outputData['vgg_normal']).toStringAsFixed(2)}' ??
                                        '')),
                              ],
                            ),
                            DataRow(
                              cells: [
                                DataCell(Text("ResNet")),
                                DataCell(Text(
                                    '${outputData['resnet_covid'].toStringAsFixed(2)}' ??
                                        '')),
                                DataCell(Text(
                                    '${(outputData['resnet_normal']).toStringAsFixed(2)}' ??
                                        '')),
                              ],
                            ),
                            DataRow(
                              cells: [
                                DataCell(Text("Xception")),
                                DataCell(Text(
                                    '${outputData['xception_covid'].toStringAsFixed(2)}' ??
                                        '')),
                                DataCell(Text(
                                    '${(outputData['xception_normal']).toStringAsFixed(2)}' ??
                                        '')),
                              ],
                            ),
                            DataRow(
                              cells: [
                                DataCell(Text("Inception")),
                                DataCell(Text(
                                    '${outputData['inception_covid'].toStringAsFixed(2)}' ??
                                        '')),
                                DataCell(Text(
                                    '${(outputData['inception_normal']).toStringAsFixed(2)}' ??
                                        '')),
                              ],
                            )
                          ],
                        )
                      ],
                    )
                  : Container(),
            )
          ],
        ),
      ),
    );
  }
}
