part of project;

class AddEditProject extends StatelessWidget {
  late AddEditProjectController controller;
  final Project? project;

  AddEditProject({
    Key? key,
    this.project,
  }) : super(key: key);

  var tfWidth = 0.0;

  @override
  Widget build(BuildContext context) {
    controller = Get.put(AddEditProjectController(project));
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
                "Project Details",
                style: TextStyle(fontWeight: FontWeight.w700),
              ),

              const SizedBox(
                height: kSpacing,
              ),

              //Enter Full Name
              _buildFullNameTextField(),

              const SizedBox(
                height: kSpacing,
              ),

              //Enter Username
              _buildUserNameTextField(),

              const SizedBox(
                height: kSpacing ,
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
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //subhead
              const Text(
                "Profile Picture",
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

  Widget _buildFullNameTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Full Name*',
            style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w600)),
        const SizedBox(
          height: kSpacing / 4,
        ),

    SizedBox(
    width: tfWidth,
        child: TextFormField(
          controller: controller.nameController,
          decoration: taskPlannerInputDecoration(hintText: "Your name"),
          onChanged: (String value) {},
          validator: (String? value) {
            if (value == null || value.isEmpty) {
              return "Please enter full name.";
            } else {
              return null;
            }
          },
        ),
    ),
      ],
    );
  }

  Widget _buildUserNameTextField() {
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
            decoration: taskPlannerInputDecoration(hintText: "Your username"),
            onChanged: (String value) {},
            maxLines: 4,
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return "Please enter description.";
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
                    {controller.addProject()}
                 else
                    {controller.editProject()}
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
