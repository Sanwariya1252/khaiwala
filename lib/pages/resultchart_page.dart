import 'package:flutter/material.dart';
import 'package:khaiwala/styles/app_colors.dart';

class ResultchartPage extends StatefulWidget {
  const ResultchartPage({super.key});

  @override
  State<ResultchartPage> createState() => _ResultchartPageState();
}

class _ResultchartPageState extends State<ResultchartPage> {
  DateTime startDate = DateTime(2025, 4, 1);
  DateTime endDate = DateTime(2025, 7, 5);

  final List<String> headers = [
    "2025",
    "D.B",
    "U.K",
    "S.G",
    "F.B",
    "G.B",
    "G.L",
    "Day",
  ];

  final Map<String, List<List<String>>> monthData = {
    "July - 2025": [
      ["01/07", "78", "28", "59", "27", "54", "57", "Tue"],
      ["02/07", "29", "80", "11", "11", "56", "23", "Wed"],
      ["03/07", "14", "14", "98", "32", "27", "21", "Thu"],
      ["04/07", "56", "29", "90", "77", "36", "01", "Fri"],
      ["05/07", "21", "21", "22", "74", "-", "-", "Sat"],
    ],
  };

  Future<void> _pickStartDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: startDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2025, 12, 31),
    );
    if (picked != null) {
      setState(() {
        startDate = picked;
      });
    }
  }

  Future<void> _pickEndDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: endDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2025, 12, 31),
    );
    if (picked != null) {
      setState(() {
        endDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
        title: const Text(
          "Monthly Chart",
          style: TextStyle(fontWeight: FontWeight.bold, fontFamily: "Barabara"),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: _pickStartDate,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8F5E9),
                        border: Border.all(color: AppColors.primaryColor),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              "${startDate.day.toString().padLeft(2, '0')}/${startDate.month.toString().padLeft(2, '0')}/${startDate.year}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: "Barabara",
                                fontSize: 11,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(Icons.calendar_today, size: 18),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: GestureDetector(
                    onTap: _pickEndDate,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8F5E9),
                        border: Border.all(color: AppColors.primaryColor),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              "${endDate.day.toString().padLeft(2, '0')}/${endDate.month.toString().padLeft(2, '0')}/${endDate.year}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: "Barabara",
                                fontSize: 11,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(Icons.calendar_today, size: 18),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_forward, color: Colors.white),
                    onPressed: () {
                      // Handle filter action
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 2),
          Expanded(
            child: ListView.builder(
              itemCount: monthData.keys.length,
              itemBuilder: (context, index) {
                String month = monthData.keys.elementAt(index);
                List<List<String>> rows = monthData[month]!;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      color: const Color(0xFFE8F5E9),
                      child: Text(
                        month,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: "Barabara",
                          color: AppColors.logoFontColor,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      color: AppColors.primaryColor,
                      child: Row(
                        children: headers.map((h) {
                          return Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 3.0),
                              child: Text(
                                h,
                                style: const TextStyle(
                                  fontFamily: "Barabara",
                                  color: Color(0xFFE8F5E9),
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    ...rows.map((row) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 6,
                        ),
                        color: Colors.green.shade100,
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                row[0],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            ...row.sublist(1).map((cell) {
                              return Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        cell,
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ],
                        ),
                      );
                    }),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
