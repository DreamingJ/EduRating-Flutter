class StudyModel {
  bool? selected;
  int? sID;
  String? userID;
  String? courseID;
  String? courseName;
  bool? isSubmit;

  StudyModel(
      {this.selected, this.sID, this.userID, this.courseID, this.courseName, this.isSubmit});

  factory StudyModel.fromMap(Map<String?, dynamic> map) {
    return StudyModel(
      selected: map['selected'] as bool?,
      sID: map['sID'] as int?,
      userID: map['userID'] as String?,
      courseID: map['courseID'] as String?,
      courseName: map['courseName'] as String?,
      isSubmit: map['submit'] as bool?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'selected': selected,
      'sID': sID,
      'userID': userID,
      'courseID': courseID,
      'courseName': courseName,
      'isSubmit': isSubmit,
    };
  }
}
