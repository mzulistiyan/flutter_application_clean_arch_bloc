import 'package:hive/hive.dart';
import '../../../../core/core.dart';

class HiveBoxHelperClass {
  static final HiveBoxHelperClass boxRepoHive = HiveBoxHelperClass._internal();
  factory HiveBoxHelperClass() {
    return boxRepoHive;
  }
  HiveBoxHelperClass._internal();

  static Future<Box<CatModel>> openCatBox({required String boxName}) => Hive.openBox<CatModel>(boxName);

  static Box<CatModel> getCatBox({required String boxName}) => Hive.box<CatModel>('cats');

  //insert data
  static Future<void> putData({required String boxName, required CatModel data}) async {
    Box<CatModel> catBox = await openCatBox(boxName: boxName);
    await catBox.put(data.name, data);
  }

  //get data
  static CatModel? getData({required String boxName, required String key}) {
    Box<CatModel> catBox = getCatBox(boxName: boxName);
    return catBox.get(key);
  }

  //delete data
  static Future<void> deleteData({required String boxName, required String key}) async {
    Box<CatModel> catBox = getCatBox(boxName: boxName);
    await catBox.delete(key);
  }

  //clear data
  static Future<void> clearData({required String boxName}) async {
    Box<CatModel> catBox = getCatBox(boxName: boxName);
    await catBox.clear();
  }

  //close box
  static Future<void> closeBox({required String boxName}) async {
    Box<CatModel> catBox = getCatBox(boxName: boxName);
    await catBox.close();
  }

  //delete box
  static Future<void> deleteBox({required String boxName}) async {
    await Hive.deleteBoxFromDisk(boxName);
  }

  //delete data from index
  static Future<void> deleteDataFromIndex({required String boxName, required int index}) async {
    Box<CatModel> catBox = getCatBox(boxName: boxName);
    await catBox.deleteAt(index);
  }

  //get all data from box as list
  // static List<CatModel> getAllData({required String boxName}) {
  //   Box<CatModel> catBox = getCatBox(boxName: boxName);
  //   return catBox.values.toList();
  // }

  //get all data general method
  static List<T> getAllData<T>({required String boxName}) {
    Box<T> catBox = Hive.box<T>(boxName);
    return catBox.values.toList();
  }

  //get all data general method
  static T? getDataFromIndex<T>({required String boxName, required int index}) {
    Box<T> catBox = Hive.box<T>(boxName);
    return catBox.getAt(index);
  }

  //get all data general method
  static bool isExists<T>({required String boxName, required String key}) {
    Box<T> catBox = Hive.box<T>(boxName);
    return catBox.containsKey(key);
  }

  //get all data general method
  static bool isEmpty<T>({required String boxName}) {
    Box<T> catBox = Hive.box<T>(boxName);
    return catBox.isEmpty;
  }

  //get all data, set model as parameter
  static List<T> getAllDataModel<T>({required String boxName}) {
    Box<T> catBox = Hive.box<T>(boxName);
    return catBox.values.toList();
  }
}
