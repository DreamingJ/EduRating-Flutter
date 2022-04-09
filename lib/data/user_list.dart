//1.0版为纯前端，数据在前端项目里静态，但是userID应该保存到哪？scopedModel？
//注意————其实用构造函数并不是静态的持久化存储，用shared_preference或数据库才是
//2.0版所需数据应在后端由接口提供
class UserListData {

  final String userID; 
  final String userName;
  final String userPwd;
  final String deptID;//领导和专家根据deptID，在课程表中查找，确定要评的课
  final String status;  //1学生，2教师，3领导，4专家

  const UserListData(
    {required this.userID,
    required this.userName,
    required this.userPwd,
    this.deptID = '2018211',
    this.status = "学生",
    }
  );
}

const List<UserListData> userList=[
  UserListData(userID: '2018211563', userName: '明君', userPwd: '2018211563'),
  UserListData(userID: '0002211563', userName: '韦东易', userPwd: '0002211563', status: "教师同行",deptID: '2018100',),
  UserListData(userID: '0003211563', userName: '王金宇', userPwd: '0003211563', status: "领导"),
  UserListData(userID: '0004211563', userName: '徐书胜', userPwd: '0004211563', status: "督导专家"),
  UserListData(userID: '2018212563', userName: '杜鹃', userPwd: '2018212563', status: "学生", deptID: '2018212'),
];