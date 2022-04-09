//1.0版为纯前端，数据在前端项目里静态，
//2.0版所需数据应在后端由接口提供
class TeachEvalListData {
  final String teachEvalID;
  final String userID;
  final String courseID;
  bool isSubmit;
  int teachItem1;
  int teachItem2;
  int teachItem3;
  int teachItem4;
  int teachItem5;
  String teachSuggest;

  TeachEvalListData({
    required this.teachEvalID, //自增主键
    required this.userID,
    required this.courseID,
    this.isSubmit = false,
    this.teachItem1 = 0,
    this.teachItem2 = 0,
    this.teachItem3 = 0,
    this.teachItem4 = 0,
    this.teachItem5 = 0,
    this.teachSuggest = "",
  });
}

List<TeachEvalListData> teachEvalList = [
  //学生需要这个表类似选课，那么老师和专家的条目应该是再提交后被insert进这个表的
  TeachEvalListData(
      teachEvalID: '001', userID: '2018211563', courseID: '3132102131'),
  TeachEvalListData(
      teachEvalID: '002', userID: '2018211563', courseID: '3132010201'),
  TeachEvalListData(
      teachEvalID: '003', userID: '2018211563', courseID: '3132102117'),
  TeachEvalListData(
      teachEvalID: '004', userID: '2018211563', courseID: '3132102028'),
  TeachEvalListData(
      teachEvalID: '005', userID: '2018211563', courseID: '3132140216'),
  TeachEvalListData(
      teachEvalID: '006', userID: '2018211563', courseID: '3132102235'),
  TeachEvalListData(
      teachEvalID: '007', userID: '2018211563', courseID: '3132102572'), 
      TeachEvalListData(
      teachEvalID: '008', userID: '2018211563', courseID: '3132800218'),

  TeachEvalListData(
      teachEvalID: '004', userID: '2018212563', courseID: '3132102131'),
  TeachEvalListData(
      teachEvalID: '005', userID: '2018212563', courseID: '3132010201'),
  TeachEvalListData(
      teachEvalID: '006', userID: '2018212563', courseID: '3132102117'),
];
