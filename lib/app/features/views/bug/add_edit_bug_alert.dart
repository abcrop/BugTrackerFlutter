part of bug;

class AddEditBug extends StatelessWidget {
  late AddEditBugController controller;
  final Bug? bug;

  AddEditBug({
    Key? key,
    this.bug,
  }) : super(key: key);

  var tfWidth = 0.0;

  @override
  Widget build(BuildContext context) {
    controller = Get.put(AddEditBugController(bug));
    return
      LayoutBuilder(
        builder:
    (layoutContext, constraints) =>Obx(
      () => TaskPlannerPopup(
        popupTitle: controller.popupTitle.value,
        onClose: () {
          Get.back();
        },
        child: _buildView(context, constraints),
      ),
    )
      );
  }

  Widget _buildView(BuildContext context, BoxConstraints constraints) {
    tfWidth = constraints.maxWidth * 0.6;

    return Form(
      key: controller.formKey,
      child: Row(children: [
        Flexible(
          flex: 2,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //subhead
              const Text(
                "User Details",
                style: TextStyle(fontWeight: FontWeight.w700),
              ),

              const SizedBox(
                height: kSpacing,
              ),

              //Enter title
              _buildTitleTextField(),

              const SizedBox(
                height: kSpacing,
              ),

              //Enter description
              _buildDescriptionTextField(),

              const SizedBox(
                height: kSpacing,
              ),

              //Enter bug status
              _buildBugStatusTextField(),

              const SizedBox(
                height: kSpacing,
              ),

              //Enter bug flag
              _buildBugFlagTextField(),

              const SizedBox(
                height: kSpacing,
              ),

              //Enter bug flag
              _buildBugReporterTextField(),

              const SizedBox(
                height: kSpacing,
              ),

              //Enter bug flag
              _buildBugAssignedToTextField(),

              const SizedBox(
                height: kSpacing,
              ),

              //Enter app version
              _buildAppVersionField(),

                const SizedBox(
                  height: kSpacing,
                ),

              //Enter logcat
              _buildLogcatField(),

              const SizedBox(
                height: kSpacing,
              ),

              //Add and Cancel Task
              _buildAddTaskCancel(),
            ],
          ),
        ),
        SizedBox(
          width: kSpacing * 4,
          height: MediaQuery.of(context).size.height / 2.5,
          child: const VerticalDivider(),
        ),
        Flexible(
          flex: 1,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //subhead
              const Text(
                "Bug ScreenShot",
                style: TextStyle(fontWeight: FontWeight.w700),
              ),

              const SizedBox(
                height: kSpacing,
              ),

              Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  //Enter picture logo
                  InkWell(
                      onTap: () {
                        controller.pickImage();
                      },
                      child: controller.uploadedPhotoUrl.isNotEmpty
                          ? CachedImage(imageUrl: controller.uploadedPhotoUrl.value,)
                          : controller.pickedPhoto.value.name!.isNotEmpty
                          ? controller.isLoading.value
                          ? ImageFiltered(
                          imageFilter: ImageFilter.blur(
                              sigmaX: 4.0, sigmaY: 3.0),
                          child: Image.memory(
                            controller.pickedPhoto.value.bytes!,
                          ))
                          : Image.memory(
                        controller.pickedPhoto.value.bytes!,
                      )
                          : const Icon(
                        Icons.person,
                        size: logoSizeBig * 3,
                      )),

                  if (controller.isLoading.value && controller.pickedPhoto.value.name.isNotEmpty)
                    CircularProgressIndicator(
                        backgroundColor: Theme.of(context).primaryColor,
                        valueColor: const AlwaysStoppedAnimation<Color>(
                            Colors.white)),
                ],
              ),

              const SizedBox(height: 200,)
            ],
          ),
        ),
      ]),
    );
  }

  Widget _buildTitleTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Title*',
            style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w600)),
        const SizedBox(
          height: kSpacing / 4,
        ),

    SizedBox(
    width: tfWidth,
        child: TextFormField(
          controller: controller.titleController,
          decoration: taskPlannerInputDecoration(hintText: "Bug Title"),
          onChanged: (String value) {},
          validator: (String? value) {
            if (value == null || value.isEmpty) {
              return "Please enter bug title.";
            } else {
              return null;
            }
          },
        ),
    ),
      ],
    );
  }

  Widget _buildDescriptionTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Description*',
            style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w600)),
        const SizedBox(
          height: kSpacing / 4,
        ),

        SizedBox(
          width: tfWidth,
          child: TextFormField(
            controller: controller.descriptionController,
            decoration: taskPlannerInputDecoration(hintText: "Bug Description"),
            onChanged: (String value) {},
            maxLines: 4,
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return "Please enter bug description.";
              } else {
                return null;
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildBugFlagTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Bug Flag*',
            style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w600)),
        const SizedBox(
          height: kSpacing / 4,
        ),
        SizedBox(
          width: tfWidth,
          child:
          //Sort by
          Obx(
                ()=> TaskPlannerDropdown2<BugFlag>(
                selectedValue: controller.bugFlag.value,
                hintValue: "Choose Bug Flag",
                dropdownList: controller.bugFlagList,
                onChangeDropdownItem: controller.updateBugFlag),
          ),
        ),
      ],
    );
  }


  Widget _buildBugStatusTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Bug Status*',
            style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w600)),
        const SizedBox(
          height: kSpacing / 4,
        ),
        SizedBox(
          width: tfWidth,
          child:
          //Sort by
          Obx(
                ()=> TaskPlannerDropdown2<BugStatus>(
                selectedValue: controller.bugStatus.value,
                hintValue: "Choose Bug Status",
                dropdownList: controller.bugStatusList,
                onChangeDropdownItem: controller.updateBugStatus),
          ),
        ),
      ],
    );
  }

  Widget _buildBugReporterTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Choose Bug Reporter*',
            style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w600)),
        const SizedBox(
          height: kSpacing / 5,
        ),
        SizedBox(
          width: tfWidth,
            child: TextAutoCompleteDropDown<User>(
              showAllItemsAtFirst: true,
              selectedValue: controller.reporter.value,
              dropdownItems: controller.userList,
              hintText: "Choose Bug Reporter",
              isForMultipleDropdown: false,
              isEnabled: true,
              onChangeDropdownItem: controller.onChangeBugReporterDropdownItem,
            )),
      ],
    );
  }

  Widget _buildBugAssignedToTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Choose Bug Assigned To*',
            style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w600)),
        const SizedBox(
          height: kSpacing / 5,
        ),
        SizedBox(
          width: tfWidth,
            child: TextAutoCompleteDropDown<User>(
              showAllItemsAtFirst: true,
              selectedValue: controller.assignedTo.value,
              dropdownItems: controller.userList,
              hintText: "Choose Bug Assigned To",
              isForMultipleDropdown: false,
              isEnabled: true,
              onChangeDropdownItem: controller.onChangeBugAssignedToDropdownItem,
            )),
      ],
    );
  }

  Widget _buildAppVersionField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('App Version*',
            style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w600)),
        const SizedBox(
          height: kSpacing / 4,
        ),
        SizedBox(
          width: tfWidth,
          child:
          TextFormField(
          controller: controller.appVersionController,
          decoration: taskPlannerInputDecoration(hintText: "App Version"),
          onChanged: (String value) {},
          validator: (String? value) {
            if (value == null || value.isEmpty) {
              return "Please enter an app version.";
            } else {
              return null;
            }
          },
        ),
        ),
      ],
    );
  }

  Widget _buildLogcatField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Logcat*',
            style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w600)),
        const SizedBox(
          height: kSpacing / 4,
        ),
        SizedBox(
          width: tfWidth,
          child:
          TextFormField(
            controller: controller.logcatController,
            decoration: taskPlannerInputDecoration(hintText: "Bug Logcat"),
            onChanged: (String value) {},
            maxLines: 5,
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return "Please enter a logcat";
              } else {
                return null;
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildAddTaskCancel() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _addOrEditUser(),
          const SizedBox(
            width: 30,
          ),
          ElevatedButton(
            onPressed: () {
              if (!controller.isLoading.value) {
                Get.back();
              }
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(iconGrey),
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                'Cancel',
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: fontNormal),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _addOrEditUser() {
    return controller.isLoading.value
        ? const CircularProgressIndicator()
        : ElevatedButton(
            onPressed: () => {
              if (controller.formKey.currentState!.validate())
                {
                  if (controller.isAdd.value)
                    {controller.addUser()}
                 else
                    {controller.editUser()}
                }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                controller.popupTitle.value,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: fontNormal),
              ),
            ),
          );
  }
}
