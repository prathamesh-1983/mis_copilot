import 'package:flutter/material.dart';

import '../client.dart';
import 'upload_screen.dart';

class HomeScreen
    extends StatefulWidget {

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() =>
      _HomeScreenState();
}

class _HomeScreenState
    extends State<HomeScreen> {

  int tab = 0;

  Future<void> openUpload() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            const UploadScreen(),
      ),
    );

    setState(() {});
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'MIS Copilot',
          style: TextStyle(
            fontWeight:
                FontWeight.w900,
          ),
        ),

        actions: [
          IconButton(
            onPressed: openUpload,
            icon: const Icon(
              Icons.upload_file,
            ),
          ),
        ],
      ),

      body: tab == 0
          ? const Dashboard()
          : const Reports(),

      floatingActionButton:
          FloatingActionButton.extended(
        onPressed: openUpload,
        icon:
            const Icon(Icons.add),
        label:
            const Text('Upload CSV'),
      ),

      bottomNavigationBar:
          NavigationBar(
        selectedIndex: tab,

        onDestinationSelected:
            (value) {
          setState(() {
            tab = value;
          });
        },

        destinations: const [
          NavigationDestination(
            icon: Icon(
              Icons.dashboard_outlined,
            ),
            selectedIcon:
                Icon(Icons.dashboard),
            label: 'Dashboard',
          ),

          NavigationDestination(
            icon: Icon(Icons.history),
            label: 'Reports',
          ),
        ],
      ),
    );
  }
}

class Dashboard
    extends StatefulWidget {

  const Dashboard({super.key});

  @override
  State<Dashboard> createState() =>
      _DashboardState();
}

class _DashboardState
    extends State<Dashboard> {

  late Future<List<dynamic>>
      reportsFuture;

  @override
  void initState() {
    super.initState();

    reportsFuture =
        client.report.listReports();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return FutureBuilder<
        List<dynamic>>(
      future: reportsFuture,

      builder:
          (context, snapshot) {

        if (snapshot
                .connectionState ==
            ConnectionState.waiting) {
          return const Center(
            child:
                CircularProgressIndicator(),
          );
        }
        
  if (snapshot.hasError) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.error_outline,
            color: Colors.red,
            size: 48,
          ),
          const SizedBox(height: 12),
          const Text(
            'Could not load reports',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          SelectableText(
            snapshot.error.toString(),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: () {
              setState(() {
                reportsFuture = client.report.listReports();
              });
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    ),
  );
}

        final reports =
            snapshot.data ?? [];

        if (reports.isEmpty) {
          return Center(
            child:
                FilledButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        const UploadScreen(),
                  ),
                );
              },
              icon: const Icon(
                Icons.upload_file,
              ),
              label: const Text(
                'Upload your first CSV',
              ),
            ),
          );
        }

        final report =
            reports.first;

        return ListView(
          padding:
              const EdgeInsets.all(20),

          children: [
            Text(
              'Executive Dashboard',
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(
                    fontWeight:
                        FontWeight.w900,
                  ),
            ),

            const SizedBox(
              height: 8,
            ),

            Text(
              'Latest report: '
              '${report.fileName}',
            ),

            const SizedBox(
              height: 20,
            ),

            Wrap(
              spacing: 12,
              runSpacing: 12,

              children: [
                KpiCard(
                  title: 'Sales',
                  value:
                      '₹${report.totalSales.toStringAsFixed(2)}',
                ),

                KpiCard(
                  title: 'Profit',
                  value:
                      '₹${report.totalProfit.toStringAsFixed(2)}',
                ),

                KpiCard(
                  title: 'Rows',
                  value:
                      '${report.rowCount}',
                ),

                KpiCard(
                  title: 'Average Order',
                  value:
                      '₹${report.averageOrderValue.toStringAsFixed(2)}',
                ),
              ],
            ),

            const SizedBox(
              height: 20,
            ),

            Card(
              child: Padding(
                padding:
                    const EdgeInsets.all(20),

                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [
                    const Text(
                      'Performance Highlights',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight:
                            FontWeight.w800,
                      ),
                    ),

                    const SizedBox(
                      height: 15,
                    ),

                    Text(
                      'Top product: '
                      '${report.topProduct}',
                    ),

                    Text(
                      'Top region: '
                      '${report.topRegion}',
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(
              height: 16,
            ),

            Card(
              child: Padding(
                padding:
                    const EdgeInsets.all(20),

                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [
                    const Text(
                      'AI Management Insight',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight:
                            FontWeight.w800,
                      ),
                    ),

                    const SizedBox(
                      height: 15,
                    ),

                    Text(
                      report.aiInsight ??
                          'No insight available.',
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class Reports
    extends StatelessWidget {

  const Reports({super.key});

  @override
  Widget build(
    BuildContext context,
  ) {
    return FutureBuilder<
        List<dynamic>>(
      future:
          client.report.listReports(),

      builder:
          (context, snapshot) {

        if (!snapshot.hasData) {
          return const Center(
            child:
                CircularProgressIndicator(),
          );
        }

        final reports =
            snapshot.data!;

        if (reports.isEmpty) {
          return const Center(
            child:
                Text('No reports yet.'),
          );
        }

        return ListView.builder(
          padding:
              const EdgeInsets.all(16),

          itemCount:
              reports.length,

          itemBuilder:
              (context, index) {

            final report =
                reports[index];

            return Card(
              child: ListTile(
                leading:
                    const CircleAvatar(
                  child: Icon(
                    Icons.analytics,
                  ),
                ),

                title: Text(
                  report.fileName,
                ),

                subtitle: Text(
                  '${report.rowCount} rows • '
                  '₹${report.totalSales.toStringAsFixed(2)}',
                ),

                onTap: () {
                  showDialog(
                    context: context,
                    builder: (_) =>
                        AlertDialog(
                      title: Text(
                        report.fileName,
                      ),

                      content:
                          SingleChildScrollView(
                        child: Text(
                          report.aiInsight ??
                              'No insight.',
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}

class KpiCard
    extends StatelessWidget {

  final String title;
  final String value;

  const KpiCard({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return SizedBox(
      width: 240,

      child: Card(
        child: Padding(
          padding:
              const EdgeInsets.all(18),

          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [
              Text(title),

              const SizedBox(
                height: 6,
              ),

              Text(
                value,
                style:
                    const TextStyle(
                  fontSize: 21,
                  fontWeight:
                      FontWeight.w900,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
