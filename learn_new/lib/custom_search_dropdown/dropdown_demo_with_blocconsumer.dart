//List<SubjectBody> subjecttest = [];

//String? _selectSubject;


// BlocConsumer<SubListCubit, SubListState>(
//                  listener: (context, state) {
//                    if (state is SubListLoaded) {
//                      setState(() {
//                        // Mapping SubjectBody to DropdownMenuItem<String>
//                        subject = state.subjectBody
//                            .map<DropdownMenuItem<String>>(
//                              (role) => DropdownMenuItem<String>(
//                                value: role.id, // Set the value to subject ID
//                                child: Text(role
//                                    .subjectName), // Set the child to subject name
//                              ),
//                            )
//                            .toList();
//                      });

//                      // Log the loaded subjects
//                      log("Subjects Loaded: ${subject.length} items");

//                      // Iterate through the subjects and log each one
//                      for (var item in subject) {
//                        log("Subject: ${item.child}, ID: ${item.value}");
//                      }
//                    }
//                  },
//                  builder: (context, state) {
//                    if (state is SubListLoading) {
//                      log("Loading subjects...");
//                      return SearchableDropdown<SubjectBody>(
//                        items: [],
//                        itemLabelBuilder: (item) => "Loading...",
//                        onChanged: (_) {},
//                        hintText: "Loading...",
//                      );
//                    }

//                    if (state is SubListError) {
//                      log("Error loading subjects");
//                      return Center(child: Text("Please Select a Subject"));
//                    }

//                    // Ensure that state is SubListLoaded before accessing subjectBody
//                    if (state is SubListLoaded) {
//                      // Logging before using firstWhere
//                      log("Selected Subject ID: $_selectSubject");

//                      // Ensure _selectSubject is valid
//                      final selectedSubject = state.subjectBody.firstWhere(
//                        (item) => item.id == _selectSubject,
//                        orElse: () => SubjectBodyModel(
//                            id: '',
//                            subjectName:
//                                'No Subject'), // Return a default SubjectBodyModel when no match is found
//                      );

//                      if (selectedSubject == null) {
//                        log("No subject found with ID: $_selectSubject");
//                      } else {
//                        log("Selected Subject: ${selectedSubject.subjectName}, ID: ${selectedSubject.id}");
//                      }

//                      return SearchableDropdown<SubjectBody>(
//                        items:
//                            state.subjectBody, // Use SubjectBody directly here
//                        itemLabelBuilder: (item) =>
//                            item.subjectName, // Extract the subject name
//                        onChanged: (value) {
//                          setState(() {
//                            _selectSubject = value?.id;
//                            // Log selected subject ID
//                            log("Selected Subject ID: $_selectSubject");
//                          });
//                        },
//                        selectedItem:
//                            selectedSubject, // Pass the selected SubjectBody object
//                        hintText: "Select Subject",
//                      );
//                    } else {
//                      // Return an empty widget or placeholder if the state is not SubListLoaded
//                      return SizedBox.shrink();
//                    }
//                  },
//                ),