// 搜索页数据准备
class CourseItemData {

  final String courseID; 
  final String courseName;
  final String teacherName;
  final String semester;
  final String deptID;
  // final List<String> tags;
  bool isSubmit;
  CourseItemData(
    {required this.courseID,
    required this.courseName,
    required this.teacherName,
    required this.semester,
    this.deptID = '计算机学院',
    this.isSubmit = false, //TODO：此字段应放在评教表中，每人不一样
    }
  );
}

List<CourseItemData> dataList=[
  CourseItemData(
      courseName: '数据结构',
      teacherName: "王武",
      semester:
          "2021-2022-1",
      courseID: '3132102131',
      isSubmit: true
      ),
    CourseItemData(
      courseName: '高等数学 (上)',
      teacherName: "韦东易",
      semester:
          "2021-2022-1",
      courseID: '3132010201',
      deptID: '2018100',
      isSubmit: true
      ),
  CourseItemData(
      courseName: '计算机组成原理',
      teacherName: "李坚强",
      semester:
          "2021-2022-1",
      courseID: '3132102117',
      // tags: ["近地铁", "随时看房"]
      ),
  CourseItemData(
      courseName: '计算机网络',
      teacherName: "高瞰",
      semester:
          "2021-2022-1",
      courseID: '3132102028',
      // tags: ["近地铁", "集中供暖", "新上", "随时看房"]
      ),
  CourseItemData(
      courseName: '离散数学 (上)',
      teacherName: "罗凡",
      semester:
          "2021-2022-1",
      courseID: '3132140216',
  ),
  CourseItemData(
      courseName: '计算机系统结构',
      teacherName: "李青霞",
      semester:
          "2021-2022-1",
      courseID: '3132102235',
      isSubmit: true
  ),
  CourseItemData(
      courseName: '大学英语 (上)',
      teacherName: "范思洁",
      deptID: '2018101',
      semester:
          "2021-2022-1",
      courseID: '3132105443',
  ),
  CourseItemData(
      courseName: '形势与政策',
      teacherName: "古奇",
      deptID: '2018101',
      semester:
          "2021-2022-1",
      courseID: '3132102572',
  ),
  CourseItemData(
      courseName: '大学物理',
      teacherName: "孙立",
      deptID: '2018100',
      semester:
          "2021-2022-1",
      courseID: '3132102841',
  ),
  CourseItemData(
      courseName: '通信原理',
      teacherName: "周信明",
      deptID: '2018111',
      semester:
          "2021-2022-1",
      courseID: '3132800218',
  ),
  CourseItemData(
      courseName: '程序设计实践',
      teacherName: "王双安",
      semester:
          "2021-2022-1",
      courseID: '3132102435',
  ),
  CourseItemData(
      courseName: 'testing2121d',
      teacherName: "吴宇森",
      semester:
          "2021-2022-1",
      courseID: '3132102426',
  ),
  CourseItemData(
      courseName: 'test23123',
      teacherName: "刘明希",
      semester:
          "2021-2022-1",
      courseID: '3132102423',
  ),
  CourseItemData(
      courseName: 'test0971csac',
      teacherName: "王进",
      semester:
          "2021-2022-1",
      courseID: '3132102870',
  ),
];
