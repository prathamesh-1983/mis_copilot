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

abstract class SalesRecord
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  SalesRecord._({
    this.id,
    required this.reportId,
    this.orderDate,
    required this.orderId,
    required this.product,
    required this.category,
    required this.region,
    required this.quantity,
    required this.sales,
    required this.profit,
  });

  factory SalesRecord({
    int? id,
    required int reportId,
    DateTime? orderDate,
    required String orderId,
    required String product,
    required String category,
    required String region,
    required int quantity,
    required double sales,
    required double profit,
  }) = _SalesRecordImpl;

  factory SalesRecord.fromJson(Map<String, dynamic> jsonSerialization) {
    return SalesRecord(
      id: jsonSerialization['id'] as int?,
      reportId: jsonSerialization['reportId'] as int,
      orderDate: jsonSerialization['orderDate'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['orderDate']),
      orderId: jsonSerialization['orderId'] as String,
      product: jsonSerialization['product'] as String,
      category: jsonSerialization['category'] as String,
      region: jsonSerialization['region'] as String,
      quantity: jsonSerialization['quantity'] as int,
      sales: (jsonSerialization['sales'] as num).toDouble(),
      profit: (jsonSerialization['profit'] as num).toDouble(),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int reportId;

  DateTime? orderDate;

  String orderId;

  String product;

  String category;

  String region;

  int quantity;

  double sales;

  double profit;

  /// Returns a shallow copy of this [SalesRecord]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  SalesRecord copyWith({
    int? id,
    int? reportId,
    DateTime? orderDate,
    String? orderId,
    String? product,
    String? category,
    String? region,
    int? quantity,
    double? sales,
    double? profit,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SalesRecord',
      if (id != null) 'id': id,
      'reportId': reportId,
      if (orderDate != null) 'orderDate': orderDate?.toJson(),
      'orderId': orderId,
      'product': product,
      'category': category,
      'region': region,
      'quantity': quantity,
      'sales': sales,
      'profit': profit,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SalesRecord',
      if (id != null) 'id': id,
      'reportId': reportId,
      if (orderDate != null) 'orderDate': orderDate?.toJson(),
      'orderId': orderId,
      'product': product,
      'category': category,
      'region': region,
      'quantity': quantity,
      'sales': sales,
      'profit': profit,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SalesRecordImpl extends SalesRecord {
  _SalesRecordImpl({
    int? id,
    required int reportId,
    DateTime? orderDate,
    required String orderId,
    required String product,
    required String category,
    required String region,
    required int quantity,
    required double sales,
    required double profit,
  }) : super._(
         id: id,
         reportId: reportId,
         orderDate: orderDate,
         orderId: orderId,
         product: product,
         category: category,
         region: region,
         quantity: quantity,
         sales: sales,
         profit: profit,
       );

  /// Returns a shallow copy of this [SalesRecord]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  SalesRecord copyWith({
    Object? id = _Undefined,
    int? reportId,
    Object? orderDate = _Undefined,
    String? orderId,
    String? product,
    String? category,
    String? region,
    int? quantity,
    double? sales,
    double? profit,
  }) {
    return SalesRecord(
      id: id is int? ? id : this.id,
      reportId: reportId ?? this.reportId,
      orderDate: orderDate is DateTime? ? orderDate : this.orderDate,
      orderId: orderId ?? this.orderId,
      product: product ?? this.product,
      category: category ?? this.category,
      region: region ?? this.region,
      quantity: quantity ?? this.quantity,
      sales: sales ?? this.sales,
      profit: profit ?? this.profit,
    );
  }
}
