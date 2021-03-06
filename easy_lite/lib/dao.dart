import 'package:sqflite/sqflite.dart';

/// 数据库表所有操作最顶层协议类
abstract class Dao<T> {
  /// 是否有记录
  /// [whereClause]：查询条件
  /// [whereArgs] 查询条件参数
  /// return：true，记录存在；false，记录不存在
  Future<bool> has(String whereClause, {List<dynamic> whereArgs});

  /// 查询符合条件的某条记录
  /// [whereClause] 查询条件
  /// [whereArgs] 查询条件中的参数
  /// return 实体类
  Future<T> query(String whereClause, {List<dynamic> whereArgs});

  /// 查询符合条件的多条记录
  /// [whereClause] 查询条件
  /// [whereArgs] 查询条件中的参数
  /// return 符合条件的多条记录
  Future<List<T>> queryMany(String whereClause, {List<dynamic> whereArgs});

  /// 万能查询
  /// [sql] sql语句
  /// [whereArgs] 条件参数
  /// return [Map]
  Future<List<Map<String, dynamic>>> rawQuery(String sql, {List<dynamic> whereArgs});

  /// 查询某实体（T）所有记录
  /// return 所有记录
  Future<List<T>> queryAll();

  /// 插入实体
  /// @param entity 实体
  /// @return true, 插入成功；false，操作失败
  Future<int> insert(T entity);

  /// 批量插入实体
  /// [entities] 批量实体
  /// 关于[exclusive]、[noResult]、[continueOnError]，请查看[Batch.commit]
  /// return [Batch.commit]
  Future<List<dynamic>> batchInsert(List<T> entities, {bool exclusive, bool noResult, bool continueOnError});

  /// 按条件更新实体记录
  /// [entity] 实体
  /// [whereClause] 更新条件
  /// [whereArgs] 更新条件中的参数
  /// return true，更新成功；false，更新失败
  Future<int> update(T entity, String whereClause, {List<dynamic> whereArgs});

  /// 按条件更新实体记录部分信息
  /// [values] 部分值更新
  /// [whereClause] 更新条件
  /// [whereArgs] 更新条件中的参数
  /// return true，更新成功；false，更新失败
  Future<int> updatePart(Map<String, dynamic> values, String whereClause, {List<dynamic> whereArgs});

  /// 按条件批量更新
  /// [entities] 批量实体
  /// [primaryKey] 主键
  /// return true，批量更新成功；false，批量更新失败
  Future<List<dynamic>> batchUpdate(List<T> entities, String primaryKey,
      {bool exclusive, bool noResult, bool continueOnError});

  /// 删除符合条件的记录
  /// [whereClause] 删除条件
  /// [whereArgs] 删除条件中的参数
  /// return，[Batch.delete]
  Future<int> delete(String whereClause, {List<dynamic> whereArgs});

  /// 按条件插入或更新
  /// [entity] 实体
  /// [whereClause] 插入或更新条件
  /// [whereArgs] 插入或更新条件中的参数
  /// return 插入或更新成功；false，插入或更新失败
  Future<int> insertOrUpdate(T entity, String whereClause, {List<dynamic> whereArgs});

  /// 查询column值、求和（SUM(column))、最大值（MAX(column)）等等（仅一条记录）
  /// [columnOrExpression] 列名或表达式
  /// [whereClause] 查询条件
  /// [whereArgs] 查询参数
  /// return 查询结果
  Future<int> getInt(String columnOrExpression, String whereClause, {List<dynamic> whereArgs});

  /// 获取行某列的文本（仅一条记录）
  /// [columnOrExpression] 列名或表达式
  /// [whereClause] 查询条件
  /// [whereArgs] 查询参数
  /// return 取行某列的文本
  Future<String> getString(String columnOrExpression, String whereClause, {List<dynamic> whereArgs});

  /// 查询column值、求和（SUM(column))、最大值（MAX(column)）等等（多条记录）
  /// [columnOrExpression] 列名或表达式
  /// [whereClause] 查询条件
  /// [whereArgs] 查询参数
  /// return [columnOrExpression]对应的多个值
  Future<List<int>> getInts(String columnOrExpression, String whereClause, {List<dynamic> whereArgs});

  /// 获取行某列的文本（多条记录）
  /// [columnOrExpression] 列名或表达式
  /// [whereClause] 查询条件
  /// [whereArgs] 查询参数
  /// @return 取行某列的文本
  Future<List<String>> getStrings(String columnOrExpression, String whereClause, {List<dynamic> whereArgs});

  /// 获取某行数据的部分或全部值
  /// [columnsOrExpressions] 多列或多表达式
  /// [whereClause] 查询条件
  /// [whereArgs] 查询参数
  /// return [columnsOrExpressions]对应的值
  Future<Map<String, dynamic>> getRowValues(List<String> columnsOrExpressions, String whereClause, {List<dynamic> whereArgs});

}