import 'package:shared_preferences/shared_preferences.dart';

//存储的键
enum StoreKeys {
  token,
}

//封装sharedpre为store，便于本地存储token
class Store{
  static late StoreKeys storeKeys;
  final SharedPreferences _store;
  static Future<Store> getInstance() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return Store._internal(prefs);
  }

  //构造函数,参数是this._store = prefs的简写
  Store._internal(this._store);

  getString(StoreKeys key) async{
    return _store.get(key.toString());
  }

  setString(StoreKeys key, String value) async{
    return _store.setString(key.toString(), value);
  }

  getStringList(StoreKeys key) async{
    return _store.getStringList(key.toString());
  }
  setStringList(StoreKeys key, List<String> value) async{
    return _store.setStringList(key.toString(), value);
  }
}