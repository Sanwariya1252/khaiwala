import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:khaiwala/styles/app_colors.dart';

class MybidPage extends StatefulWidget {
  const MybidPage({super.key});

  @override
  State<MybidPage> createState() => _MybidPageState();
}

class _MybidPageState extends State<MybidPage> {
  DateTime selectedDate = DateTime.now();
  String selectedGame = 'DISAWAR';

  final List<String> gameList = ['DISAWAR', 'GALI', 'FARIDABAD'];

  List<List<int>> jodiData = List.generate(
    10,
    (_) => List.generate(10, (_) => 0),
  );
  List<List<int>> harupData = List.generate(
    2,
    (_) => List.generate(10, (_) => 0),
  );

  int get totalJodi => jodiData.fold(
    0,
    (sum, row) => sum + row.fold(0, (rSum, item) => rSum + item),
  );

  int get totalHarup => harupData.fold(
    0,
    (sum, row) => sum + row.fold(0, (rSum, item) => rSum + item),
  );

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Widget buildJodiTable() {
    final rowLabels = List.generate(10, (i) => '$i');
    final columnLabels = List.generate(9, (i) => '${i + 1}') + ['0'];

    return Table(
      border: TableBorder.all(color: AppColors.primaryColor),
      columnWidths: {0: FixedColumnWidth(30)},
      children: [
        TableRow(
          decoration: const BoxDecoration(color: AppColors.primaryColor),
          children: [
            const SizedBox(),
            ...columnLabels.map(
              (label) => Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Text(
                    label,
                    style: const TextStyle(
                      fontSize: 14,
                      fontFamily: "Barabara",
                      fontWeight: FontWeight.w900,
                      color: AppColors.backGroundColor,
                    ),
                  ),
                ),
              ),
            ),
            const Center(
              child: Padding(
                padding: EdgeInsets.only(top: 5.0),
                child: Text(
                  'Total',
                  style: TextStyle(
                    fontFamily: "Barabara",
                    fontSize: 11,
                    fontWeight: FontWeight.w900,
                    color: AppColors.backGroundColor,
                  ),
                ),
              ),
            ),
          ],
        ),
        ...List.generate(10, (row) {
          final rowLabel = rowLabels[row];
          int rowTotal = jodiData[row].fold(0, (s, i) => s + i);

          return TableRow(
            children: [
              Container(
                color: AppColors.primaryColor,
                padding: const EdgeInsets.all(13),
                child: Center(
                  child: Text(
                    rowLabel,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: "Barabara",
                      color: AppColors.backGroundColor,
                    ),
                  ),
                ),
              ),

              ...List.generate(10, (col) {
                int jodiNumber = row * 10 + col + 1;
                String jodiText = jodiNumber == 100
                    ? '00'
                    : jodiNumber.toString().padLeft(2, '0');
                final count = jodiData[row][col];

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        jodiText,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '$count',
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ],
                  ),
                );
              }),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    '$rowTotal',
                    style: TextStyle(
                      fontSize: 15,
                      color: AppColors.logoFontColor,
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ],
    );
  }

  Widget buildHarupTable() {
    final labels = List.generate(9, (i) => '${i + 1}') + ['0'];

    return Table(
      border: TableBorder.all(color: AppColors.primaryColor),
      columnWidths: {0: FixedColumnWidth(30)},
      children: [
        TableRow(
          decoration: const BoxDecoration(color: AppColors.primaryColor),
          children: [
            const SizedBox(),
            ...labels.map(
              (label) => Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Text(
                    label,
                    style: const TextStyle(
                      fontSize: 14,
                      fontFamily: "Barabara",
                      fontWeight: FontWeight.w900,
                      color: AppColors.backGroundColor,
                    ),
                  ),
                ),
              ),
            ),
            const Center(
              child: Padding(
                padding: EdgeInsets.only(top: 5.0),
                child: Text(
                  'Total',
                  style: TextStyle(
                    fontFamily: "Barabara",
                    fontSize: 11,
                    fontWeight: FontWeight.w900,
                    color: AppColors.backGroundColor,
                  ),
                ),
              ),
            ),
          ],
        ),
        ...List.generate(2, (row) {
          int rowTotal = harupData[row].fold(0, (s, i) => s + i);
          String label = row == 0 ? 'A' : 'B';

          return TableRow(
            children: [
              Container(
                color: AppColors.primaryColor,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Text(
                      label,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.backGroundColor,
                        fontFamily: "Barabara",
                      ),
                    ),
                  ),
                ),
              ),
              ...List.generate(10, (colIdx) {
                final count = harupData[row][colIdx];
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Text(
                      '$count',
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                );
              }),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 1.0),
                  child: Text(
                    '$rowTotal',
                    style: TextStyle(
                      fontSize: 15,
                      color: AppColors.logoFontColor,
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ],
    );
  }

  Widget buildTotalTable() {
    return Table(
      border: TableBorder.all(color: AppColors.primaryColor),
      children: [
        TableRow(
          decoration: const BoxDecoration(color: AppColors.primaryColor),
          children: const [
            Center(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  'Total Jodi',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.backGroundColor,
                    fontFamily: "Barabara",
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Total Harup',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.backGroundColor,
                    fontFamily: "Barabara",
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Sub-Total',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.backGroundColor,
                    fontFamily: "Barabara",
                  ),
                ),
              ),
            ),
          ],
        ),
        TableRow(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  '$totalJodi',
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '$totalHarup',
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  '${totalJodi + totalHarup}',
                  style: TextStyle(
                    fontSize: 15,
                    color: AppColors.logoFontColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
        title: const Text(
          "My Bid Details",
          style: TextStyle(fontWeight: FontWeight.bold, fontFamily: "Barabara"),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: _pickDate,
                    child: Container(
                      height: 50,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.primaryColor),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Text(
                              DateFormat('dd/MM/yyyy').format(selectedDate),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: "Barabara",
                              ),
                            ),
                          ),
                          const Icon(Icons.calendar_today),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.primaryColor),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: selectedGame,
                        isExpanded: true,
                        items: gameList
                            .map(
                              (game) => DropdownMenuItem(
                                value: game,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Text(
                                    game,
                                    style: TextStyle(
                                      fontFamily: "Barabara",
                                      fontSize: 14,
                                      color: AppColors.logoFontColor,
                                    ),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              selectedGame = value;
                            });
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: const Text(
                'Jodi Game',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: "Barabara",
                  color: AppColors.logoFontColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            buildJodiTable(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: const Text(
                'Harup Game',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: "Barabara",
                  color: AppColors.logoFontColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            buildHarupTable(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: const Text(
                'Total Game',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: "Barabara",
                  color: AppColors.logoFontColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            buildTotalTable(),
          ],
        ),
      ),
    );
  }
}
