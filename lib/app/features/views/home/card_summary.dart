part of home;

class CardSummaryData {
  final String count;
  final String label;
  final Color primary;
  final Color? onPrimary;

  const CardSummaryData({ required this.label, required this.count, required this.primary, this.onPrimary});
}

class CardSummary extends StatelessWidget {
  const CardSummary({
    required this.data,
    Key? key,
  }) : super(key: key);

  final CardSummaryData data;

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: iconBlack,
      color: data.primary.withOpacity(0.9),
      elevation: 1.0,
      margin:  const EdgeInsets.fromLTRB(0,0,35,0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: SizedBox(
        width: 240,
        height: 150,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                data.count,
                style:  TextStyle(
                  fontSize: fontHeading * 1.3,
                  fontWeight: FontWeight.w800,
                  color: data.onPrimary == null ? Colors.white : data.onPrimary,
                ),
              ),
              const SizedBox(height: kSpacing / 3),
              Text(
                data.label,
                style:  TextStyle(
                  fontSize: fontHeading,
                  fontWeight: FontWeight.w800,
                  color: data.onPrimary == null ? Colors.white : data.onPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

