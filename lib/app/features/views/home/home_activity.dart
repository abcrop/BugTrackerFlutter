part of home;

class ActivitySummary extends StatelessWidget {
  const ActivitySummary({required this.data, required this.getxPref, Key? key, required this.isLoading})
      : super(key: key);

  final List<Activity> data;
  final RxBool isLoading;
  final GetStorage getxPref;

  // final Function(int index , ActivitySummaryData eachLog)? onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HeaderSpaceBetween(
            data: HeaderSpaceBetweenData(
                headerText: "Log Activities",
                trailingWidget: InkWell(
                  onTap: () {
                    getxPref.write(GetxStorageConstants.selectedScreenIndex, 2);
                    Get.offAndToNamed(Routes.activity);
                  },
                  child: const TextSpaceIcon(
                      data: TextSpaceIconData(
                          label: "Browse All", icon: Icons.arrow_right_alt)),
                ))),
        const SizedBox(height: kSpacing / 2),
        _buildListLogs()
      ],
    );
  }

  Widget _buildListLogs() {
    return ClipRect(
      child: SizedBox(
          child: Obx(
                () => isLoading.value
                ? const Center(
              child: CircularProgressIndicator(),
            )
                : Column(
              mainAxisSize: MainAxisSize.min,
              children: data
                  .asMap()
                  .entries
                  .map(
                    (e) => _buildLogTile(data: e.value, onPressed: () => {}),
              )
                  .toList(),
            ),
          )),
    );
  }

  Widget _buildLogTile({required Activity data, Function()? onPressed}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: ListTile(
        onTap: onPressed,
        contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        hoverColor: Colors.transparent,
        tileColor: activityColorAccordingToActivityType(data.activityType!).withOpacity(0.1),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kBorderRadius),
        ),
        leading: CircularCachedImage(imageUrl: data.user!.image!),
        title: Text(descriptionMaker(data),
            style: const TextStyle(fontWeight: FontWeight.w600)),
        trailing: Text(
          milliSecondsToDateTimeString(data.dateCreated!),
          style: const TextStyle(fontWeight: FontWeight.w100, fontSize: 13),
        ),
      ),
    );
  }

}
