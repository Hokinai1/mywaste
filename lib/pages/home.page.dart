import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:pie_chart/pie_chart.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, double> dataMap = {};
  final List<Map<String, String>> centres = [
    {"nom": "Centre A", "localite": "Lomé"},
    {"nom": "Centre B", "localite": "Kara"},
    {"nom": "Centre C", "localite": "Sokodé"},
    {"nom": "Centre D", "localite": "Atakpamé"},
  ];

  @override
  void initState() {
    super.initState();
    loadStats();
  }

  Future<void> loadStats() async {
    final String response = await rootBundle.loadString(
      'assets/data/waste_stats.json',
    );
    final Map<String, dynamic> jsonData = json.decode(response);

    setState(() {
      dataMap = jsonData.map((key, value) => MapEntry(key, value.toDouble()));
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorList = <Color>[
      Colors.blue,
      Colors.orange,
      Colors.teal,
      Colors.brown,
    ];

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFE8F5E9), Color(0xFFFFFFFF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 📌 TITRE DU GRAPHIQUE
                const Text(
                  "Répartition des déchets",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 12),

                // 📊 PIE CHART
                if (dataMap.isEmpty)
                  const Center(child: CircularProgressIndicator())
                else
                  PieChart(
                    dataMap: dataMap,
                    animationDuration: const Duration(milliseconds: 800),
                    chartLegendSpacing: 32,
                    chartRadius: MediaQuery.of(context).size.width / 2.2,
                    colorList: colorList,
                    chartType: ChartType.disc,
                    legendOptions: const LegendOptions(
                      showLegends: true,
                      legendPosition: LegendPosition.right,
                      legendTextStyle: TextStyle(fontSize: 14),
                    ),
                    chartValuesOptions: const ChartValuesOptions(
                      showChartValuesInPercentage: true,
                      decimalPlaces: 0,
                    ),
                  ),

                const SizedBox(height: 24),

                // 📌 TITRE STAT CARDS
                const Text(
                  "Statistiques rapides",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 12),

                // 🔹 STAT CARDS CLIQUABLES
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatCard(
                      Icons.delete,
                      "Centres",
                      "12",
                      Colors.green,
                      context,
                    ),
                    _buildStatCard(
                      Icons.recycling,
                      "Collectes",
                      "48",
                      Colors.blue,
                      context,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatCard(
                      Icons.water_drop,
                      "Plastiques",
                      "35%",
                      Colors.orange,
                      context,
                    ),
                    _buildStatCard(
                      Icons.eco,
                      "Organiques",
                      "20%",
                      Colors.brown,
                      context,
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // 📌 LISTE DES CENTRES
                const Text(
                  "Centres de collecte",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 12),

                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: centres.length,
                  itemBuilder: (context, index) {
                    final centre = centres[index];
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 3,
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(12),
                        title: Text(
                          centre["nom"]!,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        subtitle: Text(
                          centre["localite"]!,
                          style: const TextStyle(color: Colors.grey),
                        ),
                        leading: const Icon(
                          Icons.location_city,
                          color: Colors.green,
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  CentreDetailPage(centre: centre),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 🔹 Widget pour une carte stat (cliquable)
  Widget _buildStatCard(
    IconData icon,
    String title,
    String value,
    Color color,
    BuildContext ctx,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          ctx,
          MaterialPageRoute(
            builder: (context) => StatDetailPage(statTitle: title),
          ),
        );
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          padding: const EdgeInsets.all(12),
          width: 150,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: color),
              const SizedBox(height: 8),
              Text(
                value,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              Text(title, style: const TextStyle(fontSize: 14)),
            ],
          ),
        ),
      ),
    );
  }
}

// 📄 Page détail Stat
class StatDetailPage extends StatelessWidget {
  final String statTitle;
  const StatDetailPage({super.key, required this.statTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(statTitle)),
      body: Center(
        child: Text(
          "Explications sur $statTitle",
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}

// 📄 Page détail Centre
class CentreDetailPage extends StatelessWidget {
  final Map<String, String> centre;
  const CentreDetailPage({super.key, required this.centre});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(centre["nom"]!)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Nom : ${centre["nom"]}",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              "Localité : ${centre["localite"]}",
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Text(
              "➡️ Informations détaillées à compléter ici...",
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
