part of activity;

class ActivityList extends StatelessWidget {
  const ActivityList({required this.data,Key? key, required this.isLoading})
      : super(key: key);

  final List<Activity> data;
  final RxBool isLoading;

  // final Function(int index , ActivityListData eachLog)? onPressed;

  @override
  Widget build(BuildContext context) {
    return         _buildListLogs();
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