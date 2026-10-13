/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _isc;

abstract class Report
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Report._({
    this.id,
    required this.fileName,
    required this.rowCount,
    required this.totalSales,
    required this.totalProfit,
    required this.averageOrderValue,
    required this.topProduct,
    required this.topRegion,
    required this.createdAt,
    this.aiInsight,
  });

  factory Report({
    int? id,
    required String fileName,
    required int rowCount,
    required double totalSales,
    required double totalProfit,
    required double averageOrderValue,
    required String topProduct,
    required String topRegion,
    required DateTime createdAt,
    String? aiInsight,
  }) = _ReportImpl;

  factory Report.fromJson(Map<String, dynamic> jsonSerialization) {
    return Report(
      id: jsonSerialization['id'] as int?,
      fileName: jsonSerialization['fileName'] as String,
      rowCount: jsonSerialization['rowCount'] as int,
      totalSales: (jsonSerialization['totalSales'] as num).toDouble(),
      totalProfit: (jsonSerialization['totalProfit'] as num).toDouble(),
      averageOrderValue: (jsonSerialization['averageOrderValue'] as num)
          .toDouble(),
      topProduct: jsonSerialization['topProduct'] as String,
      topRegion: jsonSerialization['topRegion'] as String,
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      aiInsight: jsonSerialization['aiInsight'] as String?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String fileName;

  int rowCount;

  double totalSales;

  double totalProfit;

  double averageOrderValue;

  String topProduct;

  String topRegion;

  DateTime createdAt;

  String? aiInsight;

  /// Returns a shallow copy of this [Report]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Report copyWith({
    int? id,
    String? fileName,
    int? rowCount,
    double? totalSales,
    double? totalProfit,
    double? averageOrderValue,
    String? topProduct,
    String? topRegion,
    DateTime? createdAt,
    String? aiInsight,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Report',
      if (id != null) 'id': id,
      'fileName': fileName,
      'rowCount': rowCount,
      'totalSales': totalSales,
      'totalProfit': totalProfit,
      'averageOrderValue': averageOrderValue,
      'topProduct': topProduct,
      'topRegion': topRegion,
      'createdAt': createdAt.toJson(),
      if (aiInsight != null) 'aiInsight': aiInsight,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Report',
      if (id != null) 'id': id,
      'fileName': fileName,
      'rowCount': rowCount,
      'totalSales': totalSales,
      'totalProfit': totalProfit,
      'averageOrderValue': averageOrderValue,
      'topProduct': topProduct,
      'topRegion': topRegion,
      'createdAt': createdAt.toJson(),
      if (aiInsight != null) 'aiInsight': aiInsight,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ReportImpl extends Report {
  _ReportImpl({
    int? id,
    required String fileName,
    required int rowCount,
    required double totalSales,
    required double totalProfit,
    required double averageOrderValue,
    required String topProduct,
    required String topRegion,
    required DateTime createdAt,
    String? aiInsight,
  }) : super._(
         id: id,
         fileName: fileName,
         rowCount: rowCount,
         totalSales: totalSales,
         totalProfit: totalProfit,
         averageOrderValue: averageOrderValue,
         topProduct: topProduct,
         topRegion: topRegion,
         createdAt: createdAt,
         aiInsight: aiInsight,
       );

  /// Returns a shallow copy of this [Report]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Report copyWith({
    Object? id = _Undefined,
    String? fileName,
    int? rowCount,
    double? totalSales,
    double? totalProfit,
    double? averageOrderValue,
    String? topProduct,
    String? topRegion,
    DateTime? createdAt,
    Object? aiInsight = _Undefined,
  }) {
    return Report(
      id: id is int? ? id : this.id,
      fileName: fileName ?? this.fileName,
      rowCount: rowCount ?? this.rowCount,
      totalSales: totalSales ?? this.totalSales,
      totalProfit: totalProfit ?? this.totalProfit,
      averageOrderValue: averageOrderValue ?? this.averageOrderValue,
      topProduct: topProduct ?? this.topProduct,
      topRegion: topRegion ?? this.topRegion,
      createdAt: createdAt ?? this.createdAt,
      aiInsight: aiInsight is String? ? aiInsight : this.aiInsight,
    );
  }
}
