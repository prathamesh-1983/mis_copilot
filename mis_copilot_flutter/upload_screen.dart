import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../client.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() =>
      _UploadScreenState();
}

class _UploadScreenState
    extends State<UploadScreen> {

  bool loading = false;
  String? error;

  Future<void> upload() async {
    setState(() {
      loading = true;
      error = null;
    });

    try {
      final file =
          await FilePicker.pickFile(
        type: FileType.custom,
        allowedExtensions: ['csv'],
      );

      if (file == null) {
        setState(() {
          loading = false;
        });
        return;
      }

      final bytes =
          await file.readAsBytes();

      final csvText = utf8.decode(
        bytes,
        allowMalformed: true,
      );

      final report =
          await client.report.analyzeCsv(
        file.name,
        csvText,
      );

      if (!mounted) return;

      await showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: const Text(
              'Analysis Complete',
            ),

            content:
                SingleChildScrollView(
              child: Text(
                '''
Rows: ${report.rowCount}

Sales: ₹${report.totalSales.toStringAsFixed(2)}

Profit: ₹${report.totalProfit.toStringAsFixed(2)}

Average Order:
₹${report.averageOrderValue.toStringAsFixed(2)}

Top Product:
${report.topProduct}

Top Region:
${report.topRegion}

AI Insight:

${report.aiInsight ?? ''}
''',
              ),
            ),

            actions: [
              FilledButton(
                onPressed: () {
                  Navigator.pop(
                    context,
                  );
                },
                child:
                    const Text('Done'),
              ),
            ],
          );
        },
      );

      if (mounted) {
        Navigator.pop(
          context,
          report,
        );
      }
    } catch (e) {
      if (!mounted) return;

      setState(() {
        loading = false;
        error = '$e';
      });
    }
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Upload Sales Data'),
      ),

      body: Center(
        child: ConstrainedBox(
          constraints:
              const BoxConstraints(
            maxWidth: 700,
          ),

          child: Card(
            margin:
                const EdgeInsets.all(24),

            child: Padding(
              padding:
                  const EdgeInsets.all(30),

              child: Column(
                mainAxisSize:
                    MainAxisSize.min,

                children: [
                  const Icon(
                    Icons
                        .cloud_upload_rounded,
                    size: 70,
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  const Text(
                    'Upload a CSV Report',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight:
                          FontWeight.w900,
                    ),
                  ),

                  const SizedBox(
                    height: 12,
                  ),

                  const Text(
                    'Required columns:\n'
                    'Product and Sales\n\n'
                    'Recommended:\n'
                    'Date, OrderId, Category, '
                    'Region, Quantity and Profit',

                    textAlign:
                        TextAlign.center,
                  ),

                  const SizedBox(
                    height: 25,
                  ),

                  if (error != null)
                    Text(
                      error!,
                      style:
                          const TextStyle(
                        fontWeight:
                            FontWeight.w600,
                      ),
                    ),

                  const SizedBox(
                    height: 20,
                  ),

                  SizedBox(
                    width:
                        double.infinity,

                    child:
                        FilledButton.icon(
                      onPressed:
                          loading
                              ? null
                              : upload,

                      icon: loading
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child:
                                  CircularProgressIndicator(
                                strokeWidth:
                                    2,
                              ),
                            )
                          : const Icon(
                              Icons.file_open,
                            ),

                      label: Text(
                        loading
                            ? 'Analyzing...'
                            : 'Choose CSV',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
