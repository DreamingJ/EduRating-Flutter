class UserModel {
  bool? selected;
  String? userID;
  String? userPwd;
  String? userName;
  String? status;
  String? deptName;

  UserModel(
      {this.selected, this.userID, this.userPwd, this.userName, this.status, this.deptName});

  factory UserModel.fromMap(Map<String?, dynamic> map) {
    return UserModel(
      selected: map['selected'] as bool?,
      userID: map['userID'] as String?,
      userName: map['userName'] as String?,
      userPwd: map['userPwd'] as String?,
      status: map['status'] as String?,
      deptName: map['deptName'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'selected': this.selected,
      'userID': this.userID,
      'userPwd': this.userPwd,
      'userName': this.userName,
      'status': this.status,
      'deptName': this.deptName,
    };
  }
}
