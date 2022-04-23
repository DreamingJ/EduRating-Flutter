class TeachModel {
  bool? selected;
  int? tID;
  String? userID;
  String? courseID;
  String? courseName;
  bool? isSubmit;

  TeachModel(
      {this.selected, this.tID, this.userID, this.courseID, this.courseName, this.isSubmit});

  factory TeachModel.fromMap(Map<String?, dynamic> map) {
    return TeachModel(
      selected: map['selected'] as bool?,
      tID: map['tID'] as int?,
      userID: map['userID'] as String?,
      courseID: map['courseID'] as String?,
      courseName: map['courseName'] as String?,
      isSubmit: map['submit'] as bool?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'selected': selected,
      'tID': tID,
      'userID': userID,
      'courseID': courseID,
      'courseName': courseName,
      'isSubmit': isSubmit,
    };
  }
}
