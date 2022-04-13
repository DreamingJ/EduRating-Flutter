class GlobalUserInfo{
  //默认值
  static String userID="2018211563";
  static String userName = "明君";
  static String deptName = "计算机学院";
  static String status = "学生";
  // int _teachEvalNum = 0;
  // int get teachEvalNum=>_teachEvalNum;
  static void change(ID,String Name,String sta, String dept){
    userID = ID;
    userName = Name;
    deptName = dept;
    status = sta;
  }

  static void clean(){
   userID="2018211563";
   userName = "明君";
   deptName = "计算机学院";
   status = "学生";
  }

}