part of home;

class HomeSummary extends StatelessWidget {
  const HomeSummary({
    required this.summaryLabel,
    required this.summaryDataList,
    Key? key,
  }) : super(key: key);

  final String summaryLabel;
  final List<CardSummaryData> summaryDataList;

  @override
  Widget build(BuildContext context) {
    return
      SizedBox(
          height: 200,
          child:
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                summaryLabel,
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: fontHeading * 1.2,
                ),
              ),

              const SizedBox(height: kSpacing /1.2),

             SingleChildScrollView(
               scrollDirection: Axis.horizontal,
               child:  Row(
                 mainAxisAlignment: MainAxisAlignment.start,
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: summaryDataList
                     .asMap()
                     .entries
                     .map(
                         (e) =>
                         CardSummary(
                           data: CardSummaryData(
                             count: e.value.count,
                             label: e.value.label,
                             primary: e.value.primary.withOpacity(0.8),
                           ),
                         )
                 ).toList(),
               ),
             ),
              // const SizedBox(height: kSpacing /1.2),

            ],
          ),
      );
  }

  Color _getSequenceColor(int index) {
    int val = index % 4;
    if (val == 3) {
      return Colors.indigo;
    } else if (val == 2) {
      return Colors.grey;
    } else if (val == 1) {
      return Colors.redAccent;
    } else {
      return Colors.lightBlue;
    }
  }
}
