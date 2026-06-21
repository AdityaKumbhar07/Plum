// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $CustomersTable extends Customers
    with TableInfo<$CustomersTable, Customer> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CustomersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 20,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: Constant(DateTime.now().millisecondsSinceEpoch),
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, phone, address, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'customers';
  @override
  VerificationContext validateIntegrity(
    Insertable<Customer> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    } else if (isInserting) {
      context.missing(_phoneMeta);
    }
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Customer map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Customer(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      name:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}name'],
          )!,
      phone:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}phone'],
          )!,
      address:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}address'],
          )!,
      createdAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}created_at'],
          )!,
    );
  }

  @override
  $CustomersTable createAlias(String alias) {
    return $CustomersTable(attachedDatabase, alias);
  }
}

class Customer extends DataClass implements Insertable<Customer> {
  final int id;
  final String name;
  final String phone;
  final String address;
  final int createdAt;
  const Customer({
    required this.id,
    required this.name,
    required this.phone,
    required this.address,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['phone'] = Variable<String>(phone);
    map['address'] = Variable<String>(address);
    map['created_at'] = Variable<int>(createdAt);
    return map;
  }

  CustomersCompanion toCompanion(bool nullToAbsent) {
    return CustomersCompanion(
      id: Value(id),
      name: Value(name),
      phone: Value(phone),
      address: Value(address),
      createdAt: Value(createdAt),
    );
  }

  factory Customer.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Customer(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      phone: serializer.fromJson<String>(json['phone']),
      address: serializer.fromJson<String>(json['address']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'phone': serializer.toJson<String>(phone),
      'address': serializer.toJson<String>(address),
      'createdAt': serializer.toJson<int>(createdAt),
    };
  }

  Customer copyWith({
    int? id,
    String? name,
    String? phone,
    String? address,
    int? createdAt,
  }) => Customer(
    id: id ?? this.id,
    name: name ?? this.name,
    phone: phone ?? this.phone,
    address: address ?? this.address,
    createdAt: createdAt ?? this.createdAt,
  );
  Customer copyWithCompanion(CustomersCompanion data) {
    return Customer(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      phone: data.phone.present ? data.phone.value : this.phone,
      address: data.address.present ? data.address.value : this.address,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Customer(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('address: $address, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, phone, address, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Customer &&
          other.id == this.id &&
          other.name == this.name &&
          other.phone == this.phone &&
          other.address == this.address &&
          other.createdAt == this.createdAt);
}

class CustomersCompanion extends UpdateCompanion<Customer> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> phone;
  final Value<String> address;
  final Value<int> createdAt;
  const CustomersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.phone = const Value.absent(),
    this.address = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  CustomersCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String phone,
    this.address = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : name = Value(name),
       phone = Value(phone);
  static Insertable<Customer> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? phone,
    Expression<String>? address,
    Expression<int>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (phone != null) 'phone': phone,
      if (address != null) 'address': address,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  CustomersCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? phone,
    Value<String>? address,
    Value<int>? createdAt,
  }) {
    return CustomersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CustomersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('address: $address, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $BillsTable extends Bills with TableInfo<$BillsTable, Bill> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BillsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _customerIdMeta = const VerificationMeta(
    'customerId',
  );
  @override
  late final GeneratedColumn<int> customerId = GeneratedColumn<int>(
    'customer_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES customers (id)',
    ),
  );
  static const VerificationMeta _billNumberMeta = const VerificationMeta(
    'billNumber',
  );
  @override
  late final GeneratedColumn<int> billNumber = GeneratedColumn<int>(
    'bill_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalAmountMeta = const VerificationMeta(
    'totalAmount',
  );
  @override
  late final GeneratedColumn<double> totalAmount = GeneratedColumn<double>(
    'total_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _amountPaidMeta = const VerificationMeta(
    'amountPaid',
  );
  @override
  late final GeneratedColumn<double> amountPaid = GeneratedColumn<double>(
    'amount_paid',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: Constant(DateTime.now().millisecondsSinceEpoch),
  );
  static const VerificationMeta _isPaidMeta = const VerificationMeta('isPaid');
  @override
  late final GeneratedColumn<bool> isPaid = GeneratedColumn<bool>(
    'is_paid',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_paid" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    customerId,
    billNumber,
    totalAmount,
    amountPaid,
    createdAt,
    isPaid,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bills';
  @override
  VerificationContext validateIntegrity(
    Insertable<Bill> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('customer_id')) {
      context.handle(
        _customerIdMeta,
        customerId.isAcceptableOrUnknown(data['customer_id']!, _customerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_customerIdMeta);
    }
    if (data.containsKey('bill_number')) {
      context.handle(
        _billNumberMeta,
        billNumber.isAcceptableOrUnknown(data['bill_number']!, _billNumberMeta),
      );
    } else if (isInserting) {
      context.missing(_billNumberMeta);
    }
    if (data.containsKey('total_amount')) {
      context.handle(
        _totalAmountMeta,
        totalAmount.isAcceptableOrUnknown(
          data['total_amount']!,
          _totalAmountMeta,
        ),
      );
    }
    if (data.containsKey('amount_paid')) {
      context.handle(
        _amountPaidMeta,
        amountPaid.isAcceptableOrUnknown(data['amount_paid']!, _amountPaidMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('is_paid')) {
      context.handle(
        _isPaidMeta,
        isPaid.isAcceptableOrUnknown(data['is_paid']!, _isPaidMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Bill map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Bill(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      customerId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}customer_id'],
          )!,
      billNumber:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}bill_number'],
          )!,
      totalAmount:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}total_amount'],
          )!,
      amountPaid:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}amount_paid'],
          )!,
      createdAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}created_at'],
          )!,
      isPaid:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}is_paid'],
          )!,
    );
  }

  @override
  $BillsTable createAlias(String alias) {
    return $BillsTable(attachedDatabase, alias);
  }
}

class Bill extends DataClass implements Insertable<Bill> {
  final int id;
  final int customerId;
  final int billNumber;
  final double totalAmount;
  final double amountPaid;
  final int createdAt;
  final bool isPaid;
  const Bill({
    required this.id,
    required this.customerId,
    required this.billNumber,
    required this.totalAmount,
    required this.amountPaid,
    required this.createdAt,
    required this.isPaid,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['customer_id'] = Variable<int>(customerId);
    map['bill_number'] = Variable<int>(billNumber);
    map['total_amount'] = Variable<double>(totalAmount);
    map['amount_paid'] = Variable<double>(amountPaid);
    map['created_at'] = Variable<int>(createdAt);
    map['is_paid'] = Variable<bool>(isPaid);
    return map;
  }

  BillsCompanion toCompanion(bool nullToAbsent) {
    return BillsCompanion(
      id: Value(id),
      customerId: Value(customerId),
      billNumber: Value(billNumber),
      totalAmount: Value(totalAmount),
      amountPaid: Value(amountPaid),
      createdAt: Value(createdAt),
      isPaid: Value(isPaid),
    );
  }

  factory Bill.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Bill(
      id: serializer.fromJson<int>(json['id']),
      customerId: serializer.fromJson<int>(json['customerId']),
      billNumber: serializer.fromJson<int>(json['billNumber']),
      totalAmount: serializer.fromJson<double>(json['totalAmount']),
      amountPaid: serializer.fromJson<double>(json['amountPaid']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      isPaid: serializer.fromJson<bool>(json['isPaid']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'customerId': serializer.toJson<int>(customerId),
      'billNumber': serializer.toJson<int>(billNumber),
      'totalAmount': serializer.toJson<double>(totalAmount),
      'amountPaid': serializer.toJson<double>(amountPaid),
      'createdAt': serializer.toJson<int>(createdAt),
      'isPaid': serializer.toJson<bool>(isPaid),
    };
  }

  Bill copyWith({
    int? id,
    int? customerId,
    int? billNumber,
    double? totalAmount,
    double? amountPaid,
    int? createdAt,
    bool? isPaid,
  }) => Bill(
    id: id ?? this.id,
    customerId: customerId ?? this.customerId,
    billNumber: billNumber ?? this.billNumber,
    totalAmount: totalAmount ?? this.totalAmount,
    amountPaid: amountPaid ?? this.amountPaid,
    createdAt: createdAt ?? this.createdAt,
    isPaid: isPaid ?? this.isPaid,
  );
  Bill copyWithCompanion(BillsCompanion data) {
    return Bill(
      id: data.id.present ? data.id.value : this.id,
      customerId:
          data.customerId.present ? data.customerId.value : this.customerId,
      billNumber:
          data.billNumber.present ? data.billNumber.value : this.billNumber,
      totalAmount:
          data.totalAmount.present ? data.totalAmount.value : this.totalAmount,
      amountPaid:
          data.amountPaid.present ? data.amountPaid.value : this.amountPaid,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      isPaid: data.isPaid.present ? data.isPaid.value : this.isPaid,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Bill(')
          ..write('id: $id, ')
          ..write('customerId: $customerId, ')
          ..write('billNumber: $billNumber, ')
          ..write('totalAmount: $totalAmount, ')
          ..write('amountPaid: $amountPaid, ')
          ..write('createdAt: $createdAt, ')
          ..write('isPaid: $isPaid')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    customerId,
    billNumber,
    totalAmount,
    amountPaid,
    createdAt,
    isPaid,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Bill &&
          other.id == this.id &&
          other.customerId == this.customerId &&
          other.billNumber == this.billNumber &&
          other.totalAmount == this.totalAmount &&
          other.amountPaid == this.amountPaid &&
          other.createdAt == this.createdAt &&
          other.isPaid == this.isPaid);
}

class BillsCompanion extends UpdateCompanion<Bill> {
  final Value<int> id;
  final Value<int> customerId;
  final Value<int> billNumber;
  final Value<double> totalAmount;
  final Value<double> amountPaid;
  final Value<int> createdAt;
  final Value<bool> isPaid;
  const BillsCompanion({
    this.id = const Value.absent(),
    this.customerId = const Value.absent(),
    this.billNumber = const Value.absent(),
    this.totalAmount = const Value.absent(),
    this.amountPaid = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.isPaid = const Value.absent(),
  });
  BillsCompanion.insert({
    this.id = const Value.absent(),
    required int customerId,
    required int billNumber,
    this.totalAmount = const Value.absent(),
    this.amountPaid = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.isPaid = const Value.absent(),
  }) : customerId = Value(customerId),
       billNumber = Value(billNumber);
  static Insertable<Bill> custom({
    Expression<int>? id,
    Expression<int>? customerId,
    Expression<int>? billNumber,
    Expression<double>? totalAmount,
    Expression<double>? amountPaid,
    Expression<int>? createdAt,
    Expression<bool>? isPaid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (customerId != null) 'customer_id': customerId,
      if (billNumber != null) 'bill_number': billNumber,
      if (totalAmount != null) 'total_amount': totalAmount,
      if (amountPaid != null) 'amount_paid': amountPaid,
      if (createdAt != null) 'created_at': createdAt,
      if (isPaid != null) 'is_paid': isPaid,
    });
  }

  BillsCompanion copyWith({
    Value<int>? id,
    Value<int>? customerId,
    Value<int>? billNumber,
    Value<double>? totalAmount,
    Value<double>? amountPaid,
    Value<int>? createdAt,
    Value<bool>? isPaid,
  }) {
    return BillsCompanion(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      billNumber: billNumber ?? this.billNumber,
      totalAmount: totalAmount ?? this.totalAmount,
      amountPaid: amountPaid ?? this.amountPaid,
      createdAt: createdAt ?? this.createdAt,
      isPaid: isPaid ?? this.isPaid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (customerId.present) {
      map['customer_id'] = Variable<int>(customerId.value);
    }
    if (billNumber.present) {
      map['bill_number'] = Variable<int>(billNumber.value);
    }
    if (totalAmount.present) {
      map['total_amount'] = Variable<double>(totalAmount.value);
    }
    if (amountPaid.present) {
      map['amount_paid'] = Variable<double>(amountPaid.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (isPaid.present) {
      map['is_paid'] = Variable<bool>(isPaid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BillsCompanion(')
          ..write('id: $id, ')
          ..write('customerId: $customerId, ')
          ..write('billNumber: $billNumber, ')
          ..write('totalAmount: $totalAmount, ')
          ..write('amountPaid: $amountPaid, ')
          ..write('createdAt: $createdAt, ')
          ..write('isPaid: $isPaid')
          ..write(')'))
        .toString();
  }
}

class $BillItemsTable extends BillItems
    with TableInfo<$BillItemsTable, BillItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BillItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _billIdMeta = const VerificationMeta('billId');
  @override
  late final GeneratedColumn<int> billId = GeneratedColumn<int>(
    'bill_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES bills (id)',
    ),
  );
  static const VerificationMeta _itemNameMeta = const VerificationMeta(
    'itemName',
  );
  @override
  late final GeneratedColumn<String> itemName = GeneratedColumn<String>(
    'item_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<double> quantity = GeneratedColumn<double>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(1.0),
  );
  static const VerificationMeta _unitPriceMeta = const VerificationMeta(
    'unitPrice',
  );
  @override
  late final GeneratedColumn<double> unitPrice = GeneratedColumn<double>(
    'unit_price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalMeta = const VerificationMeta('total');
  @override
  late final GeneratedColumn<double> total = GeneratedColumn<double>(
    'total',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    billId,
    itemName,
    quantity,
    unitPrice,
    total,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bill_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<BillItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('bill_id')) {
      context.handle(
        _billIdMeta,
        billId.isAcceptableOrUnknown(data['bill_id']!, _billIdMeta),
      );
    } else if (isInserting) {
      context.missing(_billIdMeta);
    }
    if (data.containsKey('item_name')) {
      context.handle(
        _itemNameMeta,
        itemName.isAcceptableOrUnknown(data['item_name']!, _itemNameMeta),
      );
    } else if (isInserting) {
      context.missing(_itemNameMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    }
    if (data.containsKey('unit_price')) {
      context.handle(
        _unitPriceMeta,
        unitPrice.isAcceptableOrUnknown(data['unit_price']!, _unitPriceMeta),
      );
    } else if (isInserting) {
      context.missing(_unitPriceMeta);
    }
    if (data.containsKey('total')) {
      context.handle(
        _totalMeta,
        total.isAcceptableOrUnknown(data['total']!, _totalMeta),
      );
    } else if (isInserting) {
      context.missing(_totalMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BillItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BillItem(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      billId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}bill_id'],
          )!,
      itemName:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}item_name'],
          )!,
      quantity:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}quantity'],
          )!,
      unitPrice:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}unit_price'],
          )!,
      total:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}total'],
          )!,
    );
  }

  @override
  $BillItemsTable createAlias(String alias) {
    return $BillItemsTable(attachedDatabase, alias);
  }
}

class BillItem extends DataClass implements Insertable<BillItem> {
  final int id;
  final int billId;
  final String itemName;
  final double quantity;
  final double unitPrice;
  final double total;
  const BillItem({
    required this.id,
    required this.billId,
    required this.itemName,
    required this.quantity,
    required this.unitPrice,
    required this.total,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['bill_id'] = Variable<int>(billId);
    map['item_name'] = Variable<String>(itemName);
    map['quantity'] = Variable<double>(quantity);
    map['unit_price'] = Variable<double>(unitPrice);
    map['total'] = Variable<double>(total);
    return map;
  }

  BillItemsCompanion toCompanion(bool nullToAbsent) {
    return BillItemsCompanion(
      id: Value(id),
      billId: Value(billId),
      itemName: Value(itemName),
      quantity: Value(quantity),
      unitPrice: Value(unitPrice),
      total: Value(total),
    );
  }

  factory BillItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BillItem(
      id: serializer.fromJson<int>(json['id']),
      billId: serializer.fromJson<int>(json['billId']),
      itemName: serializer.fromJson<String>(json['itemName']),
      quantity: serializer.fromJson<double>(json['quantity']),
      unitPrice: serializer.fromJson<double>(json['unitPrice']),
      total: serializer.fromJson<double>(json['total']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'billId': serializer.toJson<int>(billId),
      'itemName': serializer.toJson<String>(itemName),
      'quantity': serializer.toJson<double>(quantity),
      'unitPrice': serializer.toJson<double>(unitPrice),
      'total': serializer.toJson<double>(total),
    };
  }

  BillItem copyWith({
    int? id,
    int? billId,
    String? itemName,
    double? quantity,
    double? unitPrice,
    double? total,
  }) => BillItem(
    id: id ?? this.id,
    billId: billId ?? this.billId,
    itemName: itemName ?? this.itemName,
    quantity: quantity ?? this.quantity,
    unitPrice: unitPrice ?? this.unitPrice,
    total: total ?? this.total,
  );
  BillItem copyWithCompanion(BillItemsCompanion data) {
    return BillItem(
      id: data.id.present ? data.id.value : this.id,
      billId: data.billId.present ? data.billId.value : this.billId,
      itemName: data.itemName.present ? data.itemName.value : this.itemName,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      unitPrice: data.unitPrice.present ? data.unitPrice.value : this.unitPrice,
      total: data.total.present ? data.total.value : this.total,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BillItem(')
          ..write('id: $id, ')
          ..write('billId: $billId, ')
          ..write('itemName: $itemName, ')
          ..write('quantity: $quantity, ')
          ..write('unitPrice: $unitPrice, ')
          ..write('total: $total')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, billId, itemName, quantity, unitPrice, total);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BillItem &&
          other.id == this.id &&
          other.billId == this.billId &&
          other.itemName == this.itemName &&
          other.quantity == this.quantity &&
          other.unitPrice == this.unitPrice &&
          other.total == this.total);
}

class BillItemsCompanion extends UpdateCompanion<BillItem> {
  final Value<int> id;
  final Value<int> billId;
  final Value<String> itemName;
  final Value<double> quantity;
  final Value<double> unitPrice;
  final Value<double> total;
  const BillItemsCompanion({
    this.id = const Value.absent(),
    this.billId = const Value.absent(),
    this.itemName = const Value.absent(),
    this.quantity = const Value.absent(),
    this.unitPrice = const Value.absent(),
    this.total = const Value.absent(),
  });
  BillItemsCompanion.insert({
    this.id = const Value.absent(),
    required int billId,
    required String itemName,
    this.quantity = const Value.absent(),
    required double unitPrice,
    required double total,
  }) : billId = Value(billId),
       itemName = Value(itemName),
       unitPrice = Value(unitPrice),
       total = Value(total);
  static Insertable<BillItem> custom({
    Expression<int>? id,
    Expression<int>? billId,
    Expression<String>? itemName,
    Expression<double>? quantity,
    Expression<double>? unitPrice,
    Expression<double>? total,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (billId != null) 'bill_id': billId,
      if (itemName != null) 'item_name': itemName,
      if (quantity != null) 'quantity': quantity,
      if (unitPrice != null) 'unit_price': unitPrice,
      if (total != null) 'total': total,
    });
  }

  BillItemsCompanion copyWith({
    Value<int>? id,
    Value<int>? billId,
    Value<String>? itemName,
    Value<double>? quantity,
    Value<double>? unitPrice,
    Value<double>? total,
  }) {
    return BillItemsCompanion(
      id: id ?? this.id,
      billId: billId ?? this.billId,
      itemName: itemName ?? this.itemName,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
      total: total ?? this.total,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (billId.present) {
      map['bill_id'] = Variable<int>(billId.value);
    }
    if (itemName.present) {
      map['item_name'] = Variable<String>(itemName.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<double>(quantity.value);
    }
    if (unitPrice.present) {
      map['unit_price'] = Variable<double>(unitPrice.value);
    }
    if (total.present) {
      map['total'] = Variable<double>(total.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BillItemsCompanion(')
          ..write('id: $id, ')
          ..write('billId: $billId, ')
          ..write('itemName: $itemName, ')
          ..write('quantity: $quantity, ')
          ..write('unitPrice: $unitPrice, ')
          ..write('total: $total')
          ..write(')'))
        .toString();
  }
}

class $QuotationsTable extends Quotations
    with TableInfo<$QuotationsTable, Quotation> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $QuotationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _customerIdMeta = const VerificationMeta(
    'customerId',
  );
  @override
  late final GeneratedColumn<int> customerId = GeneratedColumn<int>(
    'customer_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES customers (id)',
    ),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: Constant(DateTime.now().millisecondsSinceEpoch),
  );
  @override
  List<GeneratedColumn> get $columns => [id, customerId, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'quotations';
  @override
  VerificationContext validateIntegrity(
    Insertable<Quotation> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('customer_id')) {
      context.handle(
        _customerIdMeta,
        customerId.isAcceptableOrUnknown(data['customer_id']!, _customerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_customerIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Quotation map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Quotation(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      customerId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}customer_id'],
          )!,
      createdAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}created_at'],
          )!,
    );
  }

  @override
  $QuotationsTable createAlias(String alias) {
    return $QuotationsTable(attachedDatabase, alias);
  }
}

class Quotation extends DataClass implements Insertable<Quotation> {
  final int id;
  final int customerId;
  final int createdAt;
  const Quotation({
    required this.id,
    required this.customerId,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['customer_id'] = Variable<int>(customerId);
    map['created_at'] = Variable<int>(createdAt);
    return map;
  }

  QuotationsCompanion toCompanion(bool nullToAbsent) {
    return QuotationsCompanion(
      id: Value(id),
      customerId: Value(customerId),
      createdAt: Value(createdAt),
    );
  }

  factory Quotation.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Quotation(
      id: serializer.fromJson<int>(json['id']),
      customerId: serializer.fromJson<int>(json['customerId']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'customerId': serializer.toJson<int>(customerId),
      'createdAt': serializer.toJson<int>(createdAt),
    };
  }

  Quotation copyWith({int? id, int? customerId, int? createdAt}) => Quotation(
    id: id ?? this.id,
    customerId: customerId ?? this.customerId,
    createdAt: createdAt ?? this.createdAt,
  );
  Quotation copyWithCompanion(QuotationsCompanion data) {
    return Quotation(
      id: data.id.present ? data.id.value : this.id,
      customerId:
          data.customerId.present ? data.customerId.value : this.customerId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Quotation(')
          ..write('id: $id, ')
          ..write('customerId: $customerId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, customerId, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Quotation &&
          other.id == this.id &&
          other.customerId == this.customerId &&
          other.createdAt == this.createdAt);
}

class QuotationsCompanion extends UpdateCompanion<Quotation> {
  final Value<int> id;
  final Value<int> customerId;
  final Value<int> createdAt;
  const QuotationsCompanion({
    this.id = const Value.absent(),
    this.customerId = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  QuotationsCompanion.insert({
    this.id = const Value.absent(),
    required int customerId,
    this.createdAt = const Value.absent(),
  }) : customerId = Value(customerId);
  static Insertable<Quotation> custom({
    Expression<int>? id,
    Expression<int>? customerId,
    Expression<int>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (customerId != null) 'customer_id': customerId,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  QuotationsCompanion copyWith({
    Value<int>? id,
    Value<int>? customerId,
    Value<int>? createdAt,
  }) {
    return QuotationsCompanion(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (customerId.present) {
      map['customer_id'] = Variable<int>(customerId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('QuotationsCompanion(')
          ..write('id: $id, ')
          ..write('customerId: $customerId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $QuotationItemsTable extends QuotationItems
    with TableInfo<$QuotationItemsTable, QuotationItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $QuotationItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _quotationIdMeta = const VerificationMeta(
    'quotationId',
  );
  @override
  late final GeneratedColumn<int> quotationId = GeneratedColumn<int>(
    'quotation_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES quotations (id)',
    ),
  );
  static const VerificationMeta _itemNameMeta = const VerificationMeta(
    'itemName',
  );
  @override
  late final GeneratedColumn<String> itemName = GeneratedColumn<String>(
    'item_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<double> quantity = GeneratedColumn<double>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(1.0),
  );
  static const VerificationMeta _unitMeta = const VerificationMeta('unit');
  @override
  late final GeneratedColumn<String> unit = GeneratedColumn<String>(
    'unit',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    quotationId,
    itemName,
    quantity,
    unit,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'quotation_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<QuotationItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('quotation_id')) {
      context.handle(
        _quotationIdMeta,
        quotationId.isAcceptableOrUnknown(
          data['quotation_id']!,
          _quotationIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_quotationIdMeta);
    }
    if (data.containsKey('item_name')) {
      context.handle(
        _itemNameMeta,
        itemName.isAcceptableOrUnknown(data['item_name']!, _itemNameMeta),
      );
    } else if (isInserting) {
      context.missing(_itemNameMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    }
    if (data.containsKey('unit')) {
      context.handle(
        _unitMeta,
        unit.isAcceptableOrUnknown(data['unit']!, _unitMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  QuotationItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return QuotationItem(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      quotationId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}quotation_id'],
          )!,
      itemName:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}item_name'],
          )!,
      quantity:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}quantity'],
          )!,
      unit:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}unit'],
          )!,
    );
  }

  @override
  $QuotationItemsTable createAlias(String alias) {
    return $QuotationItemsTable(attachedDatabase, alias);
  }
}

class QuotationItem extends DataClass implements Insertable<QuotationItem> {
  final int id;
  final int quotationId;
  final String itemName;
  final double quantity;
  final String unit;
  const QuotationItem({
    required this.id,
    required this.quotationId,
    required this.itemName,
    required this.quantity,
    required this.unit,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['quotation_id'] = Variable<int>(quotationId);
    map['item_name'] = Variable<String>(itemName);
    map['quantity'] = Variable<double>(quantity);
    map['unit'] = Variable<String>(unit);
    return map;
  }

  QuotationItemsCompanion toCompanion(bool nullToAbsent) {
    return QuotationItemsCompanion(
      id: Value(id),
      quotationId: Value(quotationId),
      itemName: Value(itemName),
      quantity: Value(quantity),
      unit: Value(unit),
    );
  }

  factory QuotationItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return QuotationItem(
      id: serializer.fromJson<int>(json['id']),
      quotationId: serializer.fromJson<int>(json['quotationId']),
      itemName: serializer.fromJson<String>(json['itemName']),
      quantity: serializer.fromJson<double>(json['quantity']),
      unit: serializer.fromJson<String>(json['unit']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'quotationId': serializer.toJson<int>(quotationId),
      'itemName': serializer.toJson<String>(itemName),
      'quantity': serializer.toJson<double>(quantity),
      'unit': serializer.toJson<String>(unit),
    };
  }

  QuotationItem copyWith({
    int? id,
    int? quotationId,
    String? itemName,
    double? quantity,
    String? unit,
  }) => QuotationItem(
    id: id ?? this.id,
    quotationId: quotationId ?? this.quotationId,
    itemName: itemName ?? this.itemName,
    quantity: quantity ?? this.quantity,
    unit: unit ?? this.unit,
  );
  QuotationItem copyWithCompanion(QuotationItemsCompanion data) {
    return QuotationItem(
      id: data.id.present ? data.id.value : this.id,
      quotationId:
          data.quotationId.present ? data.quotationId.value : this.quotationId,
      itemName: data.itemName.present ? data.itemName.value : this.itemName,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      unit: data.unit.present ? data.unit.value : this.unit,
    );
  }

  @override
  String toString() {
    return (StringBuffer('QuotationItem(')
          ..write('id: $id, ')
          ..write('quotationId: $quotationId, ')
          ..write('itemName: $itemName, ')
          ..write('quantity: $quantity, ')
          ..write('unit: $unit')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, quotationId, itemName, quantity, unit);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is QuotationItem &&
          other.id == this.id &&
          other.quotationId == this.quotationId &&
          other.itemName == this.itemName &&
          other.quantity == this.quantity &&
          other.unit == this.unit);
}

class QuotationItemsCompanion extends UpdateCompanion<QuotationItem> {
  final Value<int> id;
  final Value<int> quotationId;
  final Value<String> itemName;
  final Value<double> quantity;
  final Value<String> unit;
  const QuotationItemsCompanion({
    this.id = const Value.absent(),
    this.quotationId = const Value.absent(),
    this.itemName = const Value.absent(),
    this.quantity = const Value.absent(),
    this.unit = const Value.absent(),
  });
  QuotationItemsCompanion.insert({
    this.id = const Value.absent(),
    required int quotationId,
    required String itemName,
    this.quantity = const Value.absent(),
    this.unit = const Value.absent(),
  }) : quotationId = Value(quotationId),
       itemName = Value(itemName);
  static Insertable<QuotationItem> custom({
    Expression<int>? id,
    Expression<int>? quotationId,
    Expression<String>? itemName,
    Expression<double>? quantity,
    Expression<String>? unit,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (quotationId != null) 'quotation_id': quotationId,
      if (itemName != null) 'item_name': itemName,
      if (quantity != null) 'quantity': quantity,
      if (unit != null) 'unit': unit,
    });
  }

  QuotationItemsCompanion copyWith({
    Value<int>? id,
    Value<int>? quotationId,
    Value<String>? itemName,
    Value<double>? quantity,
    Value<String>? unit,
  }) {
    return QuotationItemsCompanion(
      id: id ?? this.id,
      quotationId: quotationId ?? this.quotationId,
      itemName: itemName ?? this.itemName,
      quantity: quantity ?? this.quantity,
      unit: unit ?? this.unit,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (quotationId.present) {
      map['quotation_id'] = Variable<int>(quotationId.value);
    }
    if (itemName.present) {
      map['item_name'] = Variable<String>(itemName.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<double>(quantity.value);
    }
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('QuotationItemsCompanion(')
          ..write('id: $id, ')
          ..write('quotationId: $quotationId, ')
          ..write('itemName: $itemName, ')
          ..write('quantity: $quantity, ')
          ..write('unit: $unit')
          ..write(')'))
        .toString();
  }
}

class $SavedItemsTable extends SavedItems
    with TableInfo<$SavedItemsTable, SavedItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SavedItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _defaultPriceMeta = const VerificationMeta(
    'defaultPrice',
  );
  @override
  late final GeneratedColumn<double> defaultPrice = GeneratedColumn<double>(
    'default_price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, defaultPrice, sortOrder];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'saved_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<SavedItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('default_price')) {
      context.handle(
        _defaultPriceMeta,
        defaultPrice.isAcceptableOrUnknown(
          data['default_price']!,
          _defaultPriceMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_defaultPriceMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SavedItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SavedItem(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      name:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}name'],
          )!,
      defaultPrice:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}default_price'],
          )!,
      sortOrder:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}sort_order'],
          )!,
    );
  }

  @override
  $SavedItemsTable createAlias(String alias) {
    return $SavedItemsTable(attachedDatabase, alias);
  }
}

class SavedItem extends DataClass implements Insertable<SavedItem> {
  final int id;
  final String name;
  final double defaultPrice;
  final int sortOrder;
  const SavedItem({
    required this.id,
    required this.name,
    required this.defaultPrice,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['default_price'] = Variable<double>(defaultPrice);
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  SavedItemsCompanion toCompanion(bool nullToAbsent) {
    return SavedItemsCompanion(
      id: Value(id),
      name: Value(name),
      defaultPrice: Value(defaultPrice),
      sortOrder: Value(sortOrder),
    );
  }

  factory SavedItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SavedItem(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      defaultPrice: serializer.fromJson<double>(json['defaultPrice']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'defaultPrice': serializer.toJson<double>(defaultPrice),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  SavedItem copyWith({
    int? id,
    String? name,
    double? defaultPrice,
    int? sortOrder,
  }) => SavedItem(
    id: id ?? this.id,
    name: name ?? this.name,
    defaultPrice: defaultPrice ?? this.defaultPrice,
    sortOrder: sortOrder ?? this.sortOrder,
  );
  SavedItem copyWithCompanion(SavedItemsCompanion data) {
    return SavedItem(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      defaultPrice:
          data.defaultPrice.present
              ? data.defaultPrice.value
              : this.defaultPrice,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SavedItem(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('defaultPrice: $defaultPrice, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, defaultPrice, sortOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SavedItem &&
          other.id == this.id &&
          other.name == this.name &&
          other.defaultPrice == this.defaultPrice &&
          other.sortOrder == this.sortOrder);
}

class SavedItemsCompanion extends UpdateCompanion<SavedItem> {
  final Value<int> id;
  final Value<String> name;
  final Value<double> defaultPrice;
  final Value<int> sortOrder;
  const SavedItemsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.defaultPrice = const Value.absent(),
    this.sortOrder = const Value.absent(),
  });
  SavedItemsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required double defaultPrice,
    this.sortOrder = const Value.absent(),
  }) : name = Value(name),
       defaultPrice = Value(defaultPrice);
  static Insertable<SavedItem> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<double>? defaultPrice,
    Expression<int>? sortOrder,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (defaultPrice != null) 'default_price': defaultPrice,
      if (sortOrder != null) 'sort_order': sortOrder,
    });
  }

  SavedItemsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<double>? defaultPrice,
    Value<int>? sortOrder,
  }) {
    return SavedItemsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      defaultPrice: defaultPrice ?? this.defaultPrice,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (defaultPrice.present) {
      map['default_price'] = Variable<double>(defaultPrice.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SavedItemsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('defaultPrice: $defaultPrice, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }
}

class $ShowcasePhotosTable extends ShowcasePhotos
    with TableInfo<$ShowcasePhotosTable, ShowcasePhoto> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ShowcasePhotosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _filePathMeta = const VerificationMeta(
    'filePath',
  );
  @override
  late final GeneratedColumn<String> filePath = GeneratedColumn<String>(
    'file_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: Constant(DateTime.now().millisecondsSinceEpoch),
  );
  @override
  List<GeneratedColumn> get $columns => [id, filePath, category, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'showcase_photos';
  @override
  VerificationContext validateIntegrity(
    Insertable<ShowcasePhoto> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('file_path')) {
      context.handle(
        _filePathMeta,
        filePath.isAcceptableOrUnknown(data['file_path']!, _filePathMeta),
      );
    } else if (isInserting) {
      context.missing(_filePathMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ShowcasePhoto map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ShowcasePhoto(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      filePath:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}file_path'],
          )!,
      category:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}category'],
          )!,
      createdAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}created_at'],
          )!,
    );
  }

  @override
  $ShowcasePhotosTable createAlias(String alias) {
    return $ShowcasePhotosTable(attachedDatabase, alias);
  }
}

class ShowcasePhoto extends DataClass implements Insertable<ShowcasePhoto> {
  final int id;
  final String filePath;
  final String category;
  final int createdAt;
  const ShowcasePhoto({
    required this.id,
    required this.filePath,
    required this.category,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['file_path'] = Variable<String>(filePath);
    map['category'] = Variable<String>(category);
    map['created_at'] = Variable<int>(createdAt);
    return map;
  }

  ShowcasePhotosCompanion toCompanion(bool nullToAbsent) {
    return ShowcasePhotosCompanion(
      id: Value(id),
      filePath: Value(filePath),
      category: Value(category),
      createdAt: Value(createdAt),
    );
  }

  factory ShowcasePhoto.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ShowcasePhoto(
      id: serializer.fromJson<int>(json['id']),
      filePath: serializer.fromJson<String>(json['filePath']),
      category: serializer.fromJson<String>(json['category']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'filePath': serializer.toJson<String>(filePath),
      'category': serializer.toJson<String>(category),
      'createdAt': serializer.toJson<int>(createdAt),
    };
  }

  ShowcasePhoto copyWith({
    int? id,
    String? filePath,
    String? category,
    int? createdAt,
  }) => ShowcasePhoto(
    id: id ?? this.id,
    filePath: filePath ?? this.filePath,
    category: category ?? this.category,
    createdAt: createdAt ?? this.createdAt,
  );
  ShowcasePhoto copyWithCompanion(ShowcasePhotosCompanion data) {
    return ShowcasePhoto(
      id: data.id.present ? data.id.value : this.id,
      filePath: data.filePath.present ? data.filePath.value : this.filePath,
      category: data.category.present ? data.category.value : this.category,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ShowcasePhoto(')
          ..write('id: $id, ')
          ..write('filePath: $filePath, ')
          ..write('category: $category, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, filePath, category, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ShowcasePhoto &&
          other.id == this.id &&
          other.filePath == this.filePath &&
          other.category == this.category &&
          other.createdAt == this.createdAt);
}

class ShowcasePhotosCompanion extends UpdateCompanion<ShowcasePhoto> {
  final Value<int> id;
  final Value<String> filePath;
  final Value<String> category;
  final Value<int> createdAt;
  const ShowcasePhotosCompanion({
    this.id = const Value.absent(),
    this.filePath = const Value.absent(),
    this.category = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  ShowcasePhotosCompanion.insert({
    this.id = const Value.absent(),
    required String filePath,
    required String category,
    this.createdAt = const Value.absent(),
  }) : filePath = Value(filePath),
       category = Value(category);
  static Insertable<ShowcasePhoto> custom({
    Expression<int>? id,
    Expression<String>? filePath,
    Expression<String>? category,
    Expression<int>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (filePath != null) 'file_path': filePath,
      if (category != null) 'category': category,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  ShowcasePhotosCompanion copyWith({
    Value<int>? id,
    Value<String>? filePath,
    Value<String>? category,
    Value<int>? createdAt,
  }) {
    return ShowcasePhotosCompanion(
      id: id ?? this.id,
      filePath: filePath ?? this.filePath,
      category: category ?? this.category,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (filePath.present) {
      map['file_path'] = Variable<String>(filePath.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ShowcasePhotosCompanion(')
          ..write('id: $id, ')
          ..write('filePath: $filePath, ')
          ..write('category: $category, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $CoreCuttingRatesTable extends CoreCuttingRates
    with TableInfo<$CoreCuttingRatesTable, CoreCuttingRate> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CoreCuttingRatesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _holeSizeMeta = const VerificationMeta(
    'holeSize',
  );
  @override
  late final GeneratedColumn<String> holeSize = GeneratedColumn<String>(
    'hole_size',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pricePerHoleMeta = const VerificationMeta(
    'pricePerHole',
  );
  @override
  late final GeneratedColumn<double> pricePerHole = GeneratedColumn<double>(
    'price_per_hole',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [id, holeSize, pricePerHole, sortOrder];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'core_cutting_rates';
  @override
  VerificationContext validateIntegrity(
    Insertable<CoreCuttingRate> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('hole_size')) {
      context.handle(
        _holeSizeMeta,
        holeSize.isAcceptableOrUnknown(data['hole_size']!, _holeSizeMeta),
      );
    } else if (isInserting) {
      context.missing(_holeSizeMeta);
    }
    if (data.containsKey('price_per_hole')) {
      context.handle(
        _pricePerHoleMeta,
        pricePerHole.isAcceptableOrUnknown(
          data['price_per_hole']!,
          _pricePerHoleMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_pricePerHoleMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CoreCuttingRate map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CoreCuttingRate(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      holeSize:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}hole_size'],
          )!,
      pricePerHole:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}price_per_hole'],
          )!,
      sortOrder:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}sort_order'],
          )!,
    );
  }

  @override
  $CoreCuttingRatesTable createAlias(String alias) {
    return $CoreCuttingRatesTable(attachedDatabase, alias);
  }
}

class CoreCuttingRate extends DataClass implements Insertable<CoreCuttingRate> {
  final int id;
  final String holeSize;
  final double pricePerHole;
  final int sortOrder;
  const CoreCuttingRate({
    required this.id,
    required this.holeSize,
    required this.pricePerHole,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['hole_size'] = Variable<String>(holeSize);
    map['price_per_hole'] = Variable<double>(pricePerHole);
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  CoreCuttingRatesCompanion toCompanion(bool nullToAbsent) {
    return CoreCuttingRatesCompanion(
      id: Value(id),
      holeSize: Value(holeSize),
      pricePerHole: Value(pricePerHole),
      sortOrder: Value(sortOrder),
    );
  }

  factory CoreCuttingRate.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CoreCuttingRate(
      id: serializer.fromJson<int>(json['id']),
      holeSize: serializer.fromJson<String>(json['holeSize']),
      pricePerHole: serializer.fromJson<double>(json['pricePerHole']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'holeSize': serializer.toJson<String>(holeSize),
      'pricePerHole': serializer.toJson<double>(pricePerHole),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  CoreCuttingRate copyWith({
    int? id,
    String? holeSize,
    double? pricePerHole,
    int? sortOrder,
  }) => CoreCuttingRate(
    id: id ?? this.id,
    holeSize: holeSize ?? this.holeSize,
    pricePerHole: pricePerHole ?? this.pricePerHole,
    sortOrder: sortOrder ?? this.sortOrder,
  );
  CoreCuttingRate copyWithCompanion(CoreCuttingRatesCompanion data) {
    return CoreCuttingRate(
      id: data.id.present ? data.id.value : this.id,
      holeSize: data.holeSize.present ? data.holeSize.value : this.holeSize,
      pricePerHole:
          data.pricePerHole.present
              ? data.pricePerHole.value
              : this.pricePerHole,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CoreCuttingRate(')
          ..write('id: $id, ')
          ..write('holeSize: $holeSize, ')
          ..write('pricePerHole: $pricePerHole, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, holeSize, pricePerHole, sortOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CoreCuttingRate &&
          other.id == this.id &&
          other.holeSize == this.holeSize &&
          other.pricePerHole == this.pricePerHole &&
          other.sortOrder == this.sortOrder);
}

class CoreCuttingRatesCompanion extends UpdateCompanion<CoreCuttingRate> {
  final Value<int> id;
  final Value<String> holeSize;
  final Value<double> pricePerHole;
  final Value<int> sortOrder;
  const CoreCuttingRatesCompanion({
    this.id = const Value.absent(),
    this.holeSize = const Value.absent(),
    this.pricePerHole = const Value.absent(),
    this.sortOrder = const Value.absent(),
  });
  CoreCuttingRatesCompanion.insert({
    this.id = const Value.absent(),
    required String holeSize,
    required double pricePerHole,
    this.sortOrder = const Value.absent(),
  }) : holeSize = Value(holeSize),
       pricePerHole = Value(pricePerHole);
  static Insertable<CoreCuttingRate> custom({
    Expression<int>? id,
    Expression<String>? holeSize,
    Expression<double>? pricePerHole,
    Expression<int>? sortOrder,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (holeSize != null) 'hole_size': holeSize,
      if (pricePerHole != null) 'price_per_hole': pricePerHole,
      if (sortOrder != null) 'sort_order': sortOrder,
    });
  }

  CoreCuttingRatesCompanion copyWith({
    Value<int>? id,
    Value<String>? holeSize,
    Value<double>? pricePerHole,
    Value<int>? sortOrder,
  }) {
    return CoreCuttingRatesCompanion(
      id: id ?? this.id,
      holeSize: holeSize ?? this.holeSize,
      pricePerHole: pricePerHole ?? this.pricePerHole,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (holeSize.present) {
      map['hole_size'] = Variable<String>(holeSize.value);
    }
    if (pricePerHole.present) {
      map['price_per_hole'] = Variable<double>(pricePerHole.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CoreCuttingRatesCompanion(')
          ..write('id: $id, ')
          ..write('holeSize: $holeSize, ')
          ..write('pricePerHole: $pricePerHole, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }
}

class $AppSettingsTable extends AppSettings
    with TableInfo<$AppSettingsTable, AppSetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _ownerNameMeta = const VerificationMeta(
    'ownerName',
  );
  @override
  late final GeneratedColumn<String> ownerName = GeneratedColumn<String>(
    'owner_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ownerPhoneMeta = const VerificationMeta(
    'ownerPhone',
  );
  @override
  late final GeneratedColumn<String> ownerPhone = GeneratedColumn<String>(
    'owner_phone',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _localeMeta = const VerificationMeta('locale');
  @override
  late final GeneratedColumn<String> locale = GeneratedColumn<String>(
    'locale',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('mr'),
  );
  @override
  List<GeneratedColumn> get $columns => [id, ownerName, ownerPhone, locale];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<AppSetting> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('owner_name')) {
      context.handle(
        _ownerNameMeta,
        ownerName.isAcceptableOrUnknown(data['owner_name']!, _ownerNameMeta),
      );
    } else if (isInserting) {
      context.missing(_ownerNameMeta);
    }
    if (data.containsKey('owner_phone')) {
      context.handle(
        _ownerPhoneMeta,
        ownerPhone.isAcceptableOrUnknown(data['owner_phone']!, _ownerPhoneMeta),
      );
    } else if (isInserting) {
      context.missing(_ownerPhoneMeta);
    }
    if (data.containsKey('locale')) {
      context.handle(
        _localeMeta,
        locale.isAcceptableOrUnknown(data['locale']!, _localeMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AppSetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppSetting(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      ownerName:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}owner_name'],
          )!,
      ownerPhone:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}owner_phone'],
          )!,
      locale:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}locale'],
          )!,
    );
  }

  @override
  $AppSettingsTable createAlias(String alias) {
    return $AppSettingsTable(attachedDatabase, alias);
  }
}

class AppSetting extends DataClass implements Insertable<AppSetting> {
  final int id;
  final String ownerName;
  final String ownerPhone;
  final String locale;
  const AppSetting({
    required this.id,
    required this.ownerName,
    required this.ownerPhone,
    required this.locale,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['owner_name'] = Variable<String>(ownerName);
    map['owner_phone'] = Variable<String>(ownerPhone);
    map['locale'] = Variable<String>(locale);
    return map;
  }

  AppSettingsCompanion toCompanion(bool nullToAbsent) {
    return AppSettingsCompanion(
      id: Value(id),
      ownerName: Value(ownerName),
      ownerPhone: Value(ownerPhone),
      locale: Value(locale),
    );
  }

  factory AppSetting.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppSetting(
      id: serializer.fromJson<int>(json['id']),
      ownerName: serializer.fromJson<String>(json['ownerName']),
      ownerPhone: serializer.fromJson<String>(json['ownerPhone']),
      locale: serializer.fromJson<String>(json['locale']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'ownerName': serializer.toJson<String>(ownerName),
      'ownerPhone': serializer.toJson<String>(ownerPhone),
      'locale': serializer.toJson<String>(locale),
    };
  }

  AppSetting copyWith({
    int? id,
    String? ownerName,
    String? ownerPhone,
    String? locale,
  }) => AppSetting(
    id: id ?? this.id,
    ownerName: ownerName ?? this.ownerName,
    ownerPhone: ownerPhone ?? this.ownerPhone,
    locale: locale ?? this.locale,
  );
  AppSetting copyWithCompanion(AppSettingsCompanion data) {
    return AppSetting(
      id: data.id.present ? data.id.value : this.id,
      ownerName: data.ownerName.present ? data.ownerName.value : this.ownerName,
      ownerPhone:
          data.ownerPhone.present ? data.ownerPhone.value : this.ownerPhone,
      locale: data.locale.present ? data.locale.value : this.locale,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppSetting(')
          ..write('id: $id, ')
          ..write('ownerName: $ownerName, ')
          ..write('ownerPhone: $ownerPhone, ')
          ..write('locale: $locale')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, ownerName, ownerPhone, locale);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppSetting &&
          other.id == this.id &&
          other.ownerName == this.ownerName &&
          other.ownerPhone == this.ownerPhone &&
          other.locale == this.locale);
}

class AppSettingsCompanion extends UpdateCompanion<AppSetting> {
  final Value<int> id;
  final Value<String> ownerName;
  final Value<String> ownerPhone;
  final Value<String> locale;
  const AppSettingsCompanion({
    this.id = const Value.absent(),
    this.ownerName = const Value.absent(),
    this.ownerPhone = const Value.absent(),
    this.locale = const Value.absent(),
  });
  AppSettingsCompanion.insert({
    this.id = const Value.absent(),
    required String ownerName,
    required String ownerPhone,
    this.locale = const Value.absent(),
  }) : ownerName = Value(ownerName),
       ownerPhone = Value(ownerPhone);
  static Insertable<AppSetting> custom({
    Expression<int>? id,
    Expression<String>? ownerName,
    Expression<String>? ownerPhone,
    Expression<String>? locale,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ownerName != null) 'owner_name': ownerName,
      if (ownerPhone != null) 'owner_phone': ownerPhone,
      if (locale != null) 'locale': locale,
    });
  }

  AppSettingsCompanion copyWith({
    Value<int>? id,
    Value<String>? ownerName,
    Value<String>? ownerPhone,
    Value<String>? locale,
  }) {
    return AppSettingsCompanion(
      id: id ?? this.id,
      ownerName: ownerName ?? this.ownerName,
      ownerPhone: ownerPhone ?? this.ownerPhone,
      locale: locale ?? this.locale,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (ownerName.present) {
      map['owner_name'] = Variable<String>(ownerName.value);
    }
    if (ownerPhone.present) {
      map['owner_phone'] = Variable<String>(ownerPhone.value);
    }
    if (locale.present) {
      map['locale'] = Variable<String>(locale.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingsCompanion(')
          ..write('id: $id, ')
          ..write('ownerName: $ownerName, ')
          ..write('ownerPhone: $ownerPhone, ')
          ..write('locale: $locale')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CustomersTable customers = $CustomersTable(this);
  late final $BillsTable bills = $BillsTable(this);
  late final $BillItemsTable billItems = $BillItemsTable(this);
  late final $QuotationsTable quotations = $QuotationsTable(this);
  late final $QuotationItemsTable quotationItems = $QuotationItemsTable(this);
  late final $SavedItemsTable savedItems = $SavedItemsTable(this);
  late final $ShowcasePhotosTable showcasePhotos = $ShowcasePhotosTable(this);
  late final $CoreCuttingRatesTable coreCuttingRates = $CoreCuttingRatesTable(
    this,
  );
  late final $AppSettingsTable appSettings = $AppSettingsTable(this);
  late final CustomerDao customerDao = CustomerDao(this as AppDatabase);
  late final BillDao billDao = BillDao(this as AppDatabase);
  late final QuotationDao quotationDao = QuotationDao(this as AppDatabase);
  late final SavedItemDao savedItemDao = SavedItemDao(this as AppDatabase);
  late final ShowcaseDao showcaseDao = ShowcaseDao(this as AppDatabase);
  late final CoreCuttingDao coreCuttingDao = CoreCuttingDao(
    this as AppDatabase,
  );
  late final SettingsDao settingsDao = SettingsDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    customers,
    bills,
    billItems,
    quotations,
    quotationItems,
    savedItems,
    showcasePhotos,
    coreCuttingRates,
    appSettings,
  ];
}

typedef $$CustomersTableCreateCompanionBuilder =
    CustomersCompanion Function({
      Value<int> id,
      required String name,
      required String phone,
      Value<String> address,
      Value<int> createdAt,
    });
typedef $$CustomersTableUpdateCompanionBuilder =
    CustomersCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> phone,
      Value<String> address,
      Value<int> createdAt,
    });

final class $$CustomersTableReferences
    extends BaseReferences<_$AppDatabase, $CustomersTable, Customer> {
  $$CustomersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$BillsTable, List<Bill>> _billsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.bills,
    aliasName: $_aliasNameGenerator(db.customers.id, db.bills.customerId),
  );

  $$BillsTableProcessedTableManager get billsRefs {
    final manager = $$BillsTableTableManager(
      $_db,
      $_db.bills,
    ).filter((f) => f.customerId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_billsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$QuotationsTable, List<Quotation>>
  _quotationsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.quotations,
    aliasName: $_aliasNameGenerator(db.customers.id, db.quotations.customerId),
  );

  $$QuotationsTableProcessedTableManager get quotationsRefs {
    final manager = $$QuotationsTableTableManager(
      $_db,
      $_db.quotations,
    ).filter((f) => f.customerId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_quotationsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CustomersTableFilterComposer
    extends Composer<_$AppDatabase, $CustomersTable> {
  $$CustomersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> billsRefs(
    Expression<bool> Function($$BillsTableFilterComposer f) f,
  ) {
    final $$BillsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.bills,
      getReferencedColumn: (t) => t.customerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BillsTableFilterComposer(
            $db: $db,
            $table: $db.bills,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> quotationsRefs(
    Expression<bool> Function($$QuotationsTableFilterComposer f) f,
  ) {
    final $$QuotationsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.quotations,
      getReferencedColumn: (t) => t.customerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuotationsTableFilterComposer(
            $db: $db,
            $table: $db.quotations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CustomersTableOrderingComposer
    extends Composer<_$AppDatabase, $CustomersTable> {
  $$CustomersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CustomersTableAnnotationComposer
    extends Composer<_$AppDatabase, $CustomersTable> {
  $$CustomersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> billsRefs<T extends Object>(
    Expression<T> Function($$BillsTableAnnotationComposer a) f,
  ) {
    final $$BillsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.bills,
      getReferencedColumn: (t) => t.customerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BillsTableAnnotationComposer(
            $db: $db,
            $table: $db.bills,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> quotationsRefs<T extends Object>(
    Expression<T> Function($$QuotationsTableAnnotationComposer a) f,
  ) {
    final $$QuotationsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.quotations,
      getReferencedColumn: (t) => t.customerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuotationsTableAnnotationComposer(
            $db: $db,
            $table: $db.quotations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CustomersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CustomersTable,
          Customer,
          $$CustomersTableFilterComposer,
          $$CustomersTableOrderingComposer,
          $$CustomersTableAnnotationComposer,
          $$CustomersTableCreateCompanionBuilder,
          $$CustomersTableUpdateCompanionBuilder,
          (Customer, $$CustomersTableReferences),
          Customer,
          PrefetchHooks Function({bool billsRefs, bool quotationsRefs})
        > {
  $$CustomersTableTableManager(_$AppDatabase db, $CustomersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$CustomersTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$CustomersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$CustomersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> phone = const Value.absent(),
                Value<String> address = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
              }) => CustomersCompanion(
                id: id,
                name: name,
                phone: phone,
                address: address,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String phone,
                Value<String> address = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
              }) => CustomersCompanion.insert(
                id: id,
                name: name,
                phone: phone,
                address: address,
                createdAt: createdAt,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$CustomersTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({billsRefs = false, quotationsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (billsRefs) db.bills,
                if (quotationsRefs) db.quotations,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (billsRefs)
                    await $_getPrefetchedData<Customer, $CustomersTable, Bill>(
                      currentTable: table,
                      referencedTable: $$CustomersTableReferences
                          ._billsRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$CustomersTableReferences(
                                db,
                                table,
                                p0,
                              ).billsRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) => referencedItems.where(
                            (e) => e.customerId == item.id,
                          ),
                      typedResults: items,
                    ),
                  if (quotationsRefs)
                    await $_getPrefetchedData<
                      Customer,
                      $CustomersTable,
                      Quotation
                    >(
                      currentTable: table,
                      referencedTable: $$CustomersTableReferences
                          ._quotationsRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$CustomersTableReferences(
                                db,
                                table,
                                p0,
                              ).quotationsRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) => referencedItems.where(
                            (e) => e.customerId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$CustomersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CustomersTable,
      Customer,
      $$CustomersTableFilterComposer,
      $$CustomersTableOrderingComposer,
      $$CustomersTableAnnotationComposer,
      $$CustomersTableCreateCompanionBuilder,
      $$CustomersTableUpdateCompanionBuilder,
      (Customer, $$CustomersTableReferences),
      Customer,
      PrefetchHooks Function({bool billsRefs, bool quotationsRefs})
    >;
typedef $$BillsTableCreateCompanionBuilder =
    BillsCompanion Function({
      Value<int> id,
      required int customerId,
      required int billNumber,
      Value<double> totalAmount,
      Value<double> amountPaid,
      Value<int> createdAt,
      Value<bool> isPaid,
    });
typedef $$BillsTableUpdateCompanionBuilder =
    BillsCompanion Function({
      Value<int> id,
      Value<int> customerId,
      Value<int> billNumber,
      Value<double> totalAmount,
      Value<double> amountPaid,
      Value<int> createdAt,
      Value<bool> isPaid,
    });

final class $$BillsTableReferences
    extends BaseReferences<_$AppDatabase, $BillsTable, Bill> {
  $$BillsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CustomersTable _customerIdTable(_$AppDatabase db) => db.customers
      .createAlias($_aliasNameGenerator(db.bills.customerId, db.customers.id));

  $$CustomersTableProcessedTableManager get customerId {
    final $_column = $_itemColumn<int>('customer_id')!;

    final manager = $$CustomersTableTableManager(
      $_db,
      $_db.customers,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_customerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$BillItemsTable, List<BillItem>>
  _billItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.billItems,
    aliasName: $_aliasNameGenerator(db.bills.id, db.billItems.billId),
  );

  $$BillItemsTableProcessedTableManager get billItemsRefs {
    final manager = $$BillItemsTableTableManager(
      $_db,
      $_db.billItems,
    ).filter((f) => f.billId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_billItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$BillsTableFilterComposer extends Composer<_$AppDatabase, $BillsTable> {
  $$BillsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get billNumber => $composableBuilder(
    column: $table.billNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amountPaid => $composableBuilder(
    column: $table.amountPaid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isPaid => $composableBuilder(
    column: $table.isPaid,
    builder: (column) => ColumnFilters(column),
  );

  $$CustomersTableFilterComposer get customerId {
    final $$CustomersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.customerId,
      referencedTable: $db.customers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomersTableFilterComposer(
            $db: $db,
            $table: $db.customers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> billItemsRefs(
    Expression<bool> Function($$BillItemsTableFilterComposer f) f,
  ) {
    final $$BillItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.billItems,
      getReferencedColumn: (t) => t.billId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BillItemsTableFilterComposer(
            $db: $db,
            $table: $db.billItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BillsTableOrderingComposer
    extends Composer<_$AppDatabase, $BillsTable> {
  $$BillsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get billNumber => $composableBuilder(
    column: $table.billNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amountPaid => $composableBuilder(
    column: $table.amountPaid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isPaid => $composableBuilder(
    column: $table.isPaid,
    builder: (column) => ColumnOrderings(column),
  );

  $$CustomersTableOrderingComposer get customerId {
    final $$CustomersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.customerId,
      referencedTable: $db.customers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomersTableOrderingComposer(
            $db: $db,
            $table: $db.customers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BillsTableAnnotationComposer
    extends Composer<_$AppDatabase, $BillsTable> {
  $$BillsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get billNumber => $composableBuilder(
    column: $table.billNumber,
    builder: (column) => column,
  );

  GeneratedColumn<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => column,
  );

  GeneratedColumn<double> get amountPaid => $composableBuilder(
    column: $table.amountPaid,
    builder: (column) => column,
  );

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<bool> get isPaid =>
      $composableBuilder(column: $table.isPaid, builder: (column) => column);

  $$CustomersTableAnnotationComposer get customerId {
    final $$CustomersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.customerId,
      referencedTable: $db.customers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomersTableAnnotationComposer(
            $db: $db,
            $table: $db.customers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> billItemsRefs<T extends Object>(
    Expression<T> Function($$BillItemsTableAnnotationComposer a) f,
  ) {
    final $$BillItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.billItems,
      getReferencedColumn: (t) => t.billId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BillItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.billItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BillsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BillsTable,
          Bill,
          $$BillsTableFilterComposer,
          $$BillsTableOrderingComposer,
          $$BillsTableAnnotationComposer,
          $$BillsTableCreateCompanionBuilder,
          $$BillsTableUpdateCompanionBuilder,
          (Bill, $$BillsTableReferences),
          Bill,
          PrefetchHooks Function({bool customerId, bool billItemsRefs})
        > {
  $$BillsTableTableManager(_$AppDatabase db, $BillsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$BillsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$BillsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$BillsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> customerId = const Value.absent(),
                Value<int> billNumber = const Value.absent(),
                Value<double> totalAmount = const Value.absent(),
                Value<double> amountPaid = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<bool> isPaid = const Value.absent(),
              }) => BillsCompanion(
                id: id,
                customerId: customerId,
                billNumber: billNumber,
                totalAmount: totalAmount,
                amountPaid: amountPaid,
                createdAt: createdAt,
                isPaid: isPaid,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int customerId,
                required int billNumber,
                Value<double> totalAmount = const Value.absent(),
                Value<double> amountPaid = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<bool> isPaid = const Value.absent(),
              }) => BillsCompanion.insert(
                id: id,
                customerId: customerId,
                billNumber: billNumber,
                totalAmount: totalAmount,
                amountPaid: amountPaid,
                createdAt: createdAt,
                isPaid: isPaid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$BillsTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({customerId = false, billItemsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (billItemsRefs) db.billItems],
              addJoins: <
                T extends TableManagerState<
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic
                >
              >(state) {
                if (customerId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.customerId,
                            referencedTable: $$BillsTableReferences
                                ._customerIdTable(db),
                            referencedColumn:
                                $$BillsTableReferences._customerIdTable(db).id,
                          )
                          as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (billItemsRefs)
                    await $_getPrefetchedData<Bill, $BillsTable, BillItem>(
                      currentTable: table,
                      referencedTable: $$BillsTableReferences
                          ._billItemsRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$BillsTableReferences(
                                db,
                                table,
                                p0,
                              ).billItemsRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) =>
                              referencedItems.where((e) => e.billId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$BillsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BillsTable,
      Bill,
      $$BillsTableFilterComposer,
      $$BillsTableOrderingComposer,
      $$BillsTableAnnotationComposer,
      $$BillsTableCreateCompanionBuilder,
      $$BillsTableUpdateCompanionBuilder,
      (Bill, $$BillsTableReferences),
      Bill,
      PrefetchHooks Function({bool customerId, bool billItemsRefs})
    >;
typedef $$BillItemsTableCreateCompanionBuilder =
    BillItemsCompanion Function({
      Value<int> id,
      required int billId,
      required String itemName,
      Value<double> quantity,
      required double unitPrice,
      required double total,
    });
typedef $$BillItemsTableUpdateCompanionBuilder =
    BillItemsCompanion Function({
      Value<int> id,
      Value<int> billId,
      Value<String> itemName,
      Value<double> quantity,
      Value<double> unitPrice,
      Value<double> total,
    });

final class $$BillItemsTableReferences
    extends BaseReferences<_$AppDatabase, $BillItemsTable, BillItem> {
  $$BillItemsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BillsTable _billIdTable(_$AppDatabase db) => db.bills.createAlias(
    $_aliasNameGenerator(db.billItems.billId, db.bills.id),
  );

  $$BillsTableProcessedTableManager get billId {
    final $_column = $_itemColumn<int>('bill_id')!;

    final manager = $$BillsTableTableManager(
      $_db,
      $_db.bills,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_billIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$BillItemsTableFilterComposer
    extends Composer<_$AppDatabase, $BillItemsTable> {
  $$BillItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get itemName => $composableBuilder(
    column: $table.itemName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get unitPrice => $composableBuilder(
    column: $table.unitPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get total => $composableBuilder(
    column: $table.total,
    builder: (column) => ColumnFilters(column),
  );

  $$BillsTableFilterComposer get billId {
    final $$BillsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.billId,
      referencedTable: $db.bills,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BillsTableFilterComposer(
            $db: $db,
            $table: $db.bills,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BillItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $BillItemsTable> {
  $$BillItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get itemName => $composableBuilder(
    column: $table.itemName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get unitPrice => $composableBuilder(
    column: $table.unitPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get total => $composableBuilder(
    column: $table.total,
    builder: (column) => ColumnOrderings(column),
  );

  $$BillsTableOrderingComposer get billId {
    final $$BillsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.billId,
      referencedTable: $db.bills,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BillsTableOrderingComposer(
            $db: $db,
            $table: $db.bills,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BillItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $BillItemsTable> {
  $$BillItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get itemName =>
      $composableBuilder(column: $table.itemName, builder: (column) => column);

  GeneratedColumn<double> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<double> get unitPrice =>
      $composableBuilder(column: $table.unitPrice, builder: (column) => column);

  GeneratedColumn<double> get total =>
      $composableBuilder(column: $table.total, builder: (column) => column);

  $$BillsTableAnnotationComposer get billId {
    final $$BillsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.billId,
      referencedTable: $db.bills,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BillsTableAnnotationComposer(
            $db: $db,
            $table: $db.bills,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BillItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BillItemsTable,
          BillItem,
          $$BillItemsTableFilterComposer,
          $$BillItemsTableOrderingComposer,
          $$BillItemsTableAnnotationComposer,
          $$BillItemsTableCreateCompanionBuilder,
          $$BillItemsTableUpdateCompanionBuilder,
          (BillItem, $$BillItemsTableReferences),
          BillItem,
          PrefetchHooks Function({bool billId})
        > {
  $$BillItemsTableTableManager(_$AppDatabase db, $BillItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$BillItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$BillItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$BillItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> billId = const Value.absent(),
                Value<String> itemName = const Value.absent(),
                Value<double> quantity = const Value.absent(),
                Value<double> unitPrice = const Value.absent(),
                Value<double> total = const Value.absent(),
              }) => BillItemsCompanion(
                id: id,
                billId: billId,
                itemName: itemName,
                quantity: quantity,
                unitPrice: unitPrice,
                total: total,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int billId,
                required String itemName,
                Value<double> quantity = const Value.absent(),
                required double unitPrice,
                required double total,
              }) => BillItemsCompanion.insert(
                id: id,
                billId: billId,
                itemName: itemName,
                quantity: quantity,
                unitPrice: unitPrice,
                total: total,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$BillItemsTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({billId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                T extends TableManagerState<
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic
                >
              >(state) {
                if (billId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.billId,
                            referencedTable: $$BillItemsTableReferences
                                ._billIdTable(db),
                            referencedColumn:
                                $$BillItemsTableReferences._billIdTable(db).id,
                          )
                          as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$BillItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BillItemsTable,
      BillItem,
      $$BillItemsTableFilterComposer,
      $$BillItemsTableOrderingComposer,
      $$BillItemsTableAnnotationComposer,
      $$BillItemsTableCreateCompanionBuilder,
      $$BillItemsTableUpdateCompanionBuilder,
      (BillItem, $$BillItemsTableReferences),
      BillItem,
      PrefetchHooks Function({bool billId})
    >;
typedef $$QuotationsTableCreateCompanionBuilder =
    QuotationsCompanion Function({
      Value<int> id,
      required int customerId,
      Value<int> createdAt,
    });
typedef $$QuotationsTableUpdateCompanionBuilder =
    QuotationsCompanion Function({
      Value<int> id,
      Value<int> customerId,
      Value<int> createdAt,
    });

final class $$QuotationsTableReferences
    extends BaseReferences<_$AppDatabase, $QuotationsTable, Quotation> {
  $$QuotationsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CustomersTable _customerIdTable(_$AppDatabase db) =>
      db.customers.createAlias(
        $_aliasNameGenerator(db.quotations.customerId, db.customers.id),
      );

  $$CustomersTableProcessedTableManager get customerId {
    final $_column = $_itemColumn<int>('customer_id')!;

    final manager = $$CustomersTableTableManager(
      $_db,
      $_db.customers,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_customerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$QuotationItemsTable, List<QuotationItem>>
  _quotationItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.quotationItems,
    aliasName: $_aliasNameGenerator(
      db.quotations.id,
      db.quotationItems.quotationId,
    ),
  );

  $$QuotationItemsTableProcessedTableManager get quotationItemsRefs {
    final manager = $$QuotationItemsTableTableManager(
      $_db,
      $_db.quotationItems,
    ).filter((f) => f.quotationId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_quotationItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$QuotationsTableFilterComposer
    extends Composer<_$AppDatabase, $QuotationsTable> {
  $$QuotationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$CustomersTableFilterComposer get customerId {
    final $$CustomersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.customerId,
      referencedTable: $db.customers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomersTableFilterComposer(
            $db: $db,
            $table: $db.customers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> quotationItemsRefs(
    Expression<bool> Function($$QuotationItemsTableFilterComposer f) f,
  ) {
    final $$QuotationItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.quotationItems,
      getReferencedColumn: (t) => t.quotationId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuotationItemsTableFilterComposer(
            $db: $db,
            $table: $db.quotationItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$QuotationsTableOrderingComposer
    extends Composer<_$AppDatabase, $QuotationsTable> {
  $$QuotationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$CustomersTableOrderingComposer get customerId {
    final $$CustomersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.customerId,
      referencedTable: $db.customers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomersTableOrderingComposer(
            $db: $db,
            $table: $db.customers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$QuotationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $QuotationsTable> {
  $$QuotationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$CustomersTableAnnotationComposer get customerId {
    final $$CustomersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.customerId,
      referencedTable: $db.customers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomersTableAnnotationComposer(
            $db: $db,
            $table: $db.customers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> quotationItemsRefs<T extends Object>(
    Expression<T> Function($$QuotationItemsTableAnnotationComposer a) f,
  ) {
    final $$QuotationItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.quotationItems,
      getReferencedColumn: (t) => t.quotationId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuotationItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.quotationItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$QuotationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $QuotationsTable,
          Quotation,
          $$QuotationsTableFilterComposer,
          $$QuotationsTableOrderingComposer,
          $$QuotationsTableAnnotationComposer,
          $$QuotationsTableCreateCompanionBuilder,
          $$QuotationsTableUpdateCompanionBuilder,
          (Quotation, $$QuotationsTableReferences),
          Quotation,
          PrefetchHooks Function({bool customerId, bool quotationItemsRefs})
        > {
  $$QuotationsTableTableManager(_$AppDatabase db, $QuotationsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$QuotationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$QuotationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$QuotationsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> customerId = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
              }) => QuotationsCompanion(
                id: id,
                customerId: customerId,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int customerId,
                Value<int> createdAt = const Value.absent(),
              }) => QuotationsCompanion.insert(
                id: id,
                customerId: customerId,
                createdAt: createdAt,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$QuotationsTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({
            customerId = false,
            quotationItemsRefs = false,
          }) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (quotationItemsRefs) db.quotationItems,
              ],
              addJoins: <
                T extends TableManagerState<
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic
                >
              >(state) {
                if (customerId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.customerId,
                            referencedTable: $$QuotationsTableReferences
                                ._customerIdTable(db),
                            referencedColumn:
                                $$QuotationsTableReferences
                                    ._customerIdTable(db)
                                    .id,
                          )
                          as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (quotationItemsRefs)
                    await $_getPrefetchedData<
                      Quotation,
                      $QuotationsTable,
                      QuotationItem
                    >(
                      currentTable: table,
                      referencedTable: $$QuotationsTableReferences
                          ._quotationItemsRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$QuotationsTableReferences(
                                db,
                                table,
                                p0,
                              ).quotationItemsRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) => referencedItems.where(
                            (e) => e.quotationId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$QuotationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $QuotationsTable,
      Quotation,
      $$QuotationsTableFilterComposer,
      $$QuotationsTableOrderingComposer,
      $$QuotationsTableAnnotationComposer,
      $$QuotationsTableCreateCompanionBuilder,
      $$QuotationsTableUpdateCompanionBuilder,
      (Quotation, $$QuotationsTableReferences),
      Quotation,
      PrefetchHooks Function({bool customerId, bool quotationItemsRefs})
    >;
typedef $$QuotationItemsTableCreateCompanionBuilder =
    QuotationItemsCompanion Function({
      Value<int> id,
      required int quotationId,
      required String itemName,
      Value<double> quantity,
      Value<String> unit,
    });
typedef $$QuotationItemsTableUpdateCompanionBuilder =
    QuotationItemsCompanion Function({
      Value<int> id,
      Value<int> quotationId,
      Value<String> itemName,
      Value<double> quantity,
      Value<String> unit,
    });

final class $$QuotationItemsTableReferences
    extends BaseReferences<_$AppDatabase, $QuotationItemsTable, QuotationItem> {
  $$QuotationItemsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $QuotationsTable _quotationIdTable(_$AppDatabase db) =>
      db.quotations.createAlias(
        $_aliasNameGenerator(db.quotationItems.quotationId, db.quotations.id),
      );

  $$QuotationsTableProcessedTableManager get quotationId {
    final $_column = $_itemColumn<int>('quotation_id')!;

    final manager = $$QuotationsTableTableManager(
      $_db,
      $_db.quotations,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_quotationIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$QuotationItemsTableFilterComposer
    extends Composer<_$AppDatabase, $QuotationItemsTable> {
  $$QuotationItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get itemName => $composableBuilder(
    column: $table.itemName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnFilters(column),
  );

  $$QuotationsTableFilterComposer get quotationId {
    final $$QuotationsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.quotationId,
      referencedTable: $db.quotations,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuotationsTableFilterComposer(
            $db: $db,
            $table: $db.quotations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$QuotationItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $QuotationItemsTable> {
  $$QuotationItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get itemName => $composableBuilder(
    column: $table.itemName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnOrderings(column),
  );

  $$QuotationsTableOrderingComposer get quotationId {
    final $$QuotationsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.quotationId,
      referencedTable: $db.quotations,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuotationsTableOrderingComposer(
            $db: $db,
            $table: $db.quotations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$QuotationItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $QuotationItemsTable> {
  $$QuotationItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get itemName =>
      $composableBuilder(column: $table.itemName, builder: (column) => column);

  GeneratedColumn<double> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<String> get unit =>
      $composableBuilder(column: $table.unit, builder: (column) => column);

  $$QuotationsTableAnnotationComposer get quotationId {
    final $$QuotationsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.quotationId,
      referencedTable: $db.quotations,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuotationsTableAnnotationComposer(
            $db: $db,
            $table: $db.quotations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$QuotationItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $QuotationItemsTable,
          QuotationItem,
          $$QuotationItemsTableFilterComposer,
          $$QuotationItemsTableOrderingComposer,
          $$QuotationItemsTableAnnotationComposer,
          $$QuotationItemsTableCreateCompanionBuilder,
          $$QuotationItemsTableUpdateCompanionBuilder,
          (QuotationItem, $$QuotationItemsTableReferences),
          QuotationItem,
          PrefetchHooks Function({bool quotationId})
        > {
  $$QuotationItemsTableTableManager(
    _$AppDatabase db,
    $QuotationItemsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$QuotationItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () =>
                  $$QuotationItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$QuotationItemsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> quotationId = const Value.absent(),
                Value<String> itemName = const Value.absent(),
                Value<double> quantity = const Value.absent(),
                Value<String> unit = const Value.absent(),
              }) => QuotationItemsCompanion(
                id: id,
                quotationId: quotationId,
                itemName: itemName,
                quantity: quantity,
                unit: unit,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int quotationId,
                required String itemName,
                Value<double> quantity = const Value.absent(),
                Value<String> unit = const Value.absent(),
              }) => QuotationItemsCompanion.insert(
                id: id,
                quotationId: quotationId,
                itemName: itemName,
                quantity: quantity,
                unit: unit,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$QuotationItemsTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({quotationId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                T extends TableManagerState<
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic
                >
              >(state) {
                if (quotationId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.quotationId,
                            referencedTable: $$QuotationItemsTableReferences
                                ._quotationIdTable(db),
                            referencedColumn:
                                $$QuotationItemsTableReferences
                                    ._quotationIdTable(db)
                                    .id,
                          )
                          as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$QuotationItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $QuotationItemsTable,
      QuotationItem,
      $$QuotationItemsTableFilterComposer,
      $$QuotationItemsTableOrderingComposer,
      $$QuotationItemsTableAnnotationComposer,
      $$QuotationItemsTableCreateCompanionBuilder,
      $$QuotationItemsTableUpdateCompanionBuilder,
      (QuotationItem, $$QuotationItemsTableReferences),
      QuotationItem,
      PrefetchHooks Function({bool quotationId})
    >;
typedef $$SavedItemsTableCreateCompanionBuilder =
    SavedItemsCompanion Function({
      Value<int> id,
      required String name,
      required double defaultPrice,
      Value<int> sortOrder,
    });
typedef $$SavedItemsTableUpdateCompanionBuilder =
    SavedItemsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<double> defaultPrice,
      Value<int> sortOrder,
    });

class $$SavedItemsTableFilterComposer
    extends Composer<_$AppDatabase, $SavedItemsTable> {
  $$SavedItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get defaultPrice => $composableBuilder(
    column: $table.defaultPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SavedItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $SavedItemsTable> {
  $$SavedItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get defaultPrice => $composableBuilder(
    column: $table.defaultPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SavedItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SavedItemsTable> {
  $$SavedItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<double> get defaultPrice => $composableBuilder(
    column: $table.defaultPrice,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);
}

class $$SavedItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SavedItemsTable,
          SavedItem,
          $$SavedItemsTableFilterComposer,
          $$SavedItemsTableOrderingComposer,
          $$SavedItemsTableAnnotationComposer,
          $$SavedItemsTableCreateCompanionBuilder,
          $$SavedItemsTableUpdateCompanionBuilder,
          (
            SavedItem,
            BaseReferences<_$AppDatabase, $SavedItemsTable, SavedItem>,
          ),
          SavedItem,
          PrefetchHooks Function()
        > {
  $$SavedItemsTableTableManager(_$AppDatabase db, $SavedItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$SavedItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$SavedItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$SavedItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<double> defaultPrice = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
              }) => SavedItemsCompanion(
                id: id,
                name: name,
                defaultPrice: defaultPrice,
                sortOrder: sortOrder,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required double defaultPrice,
                Value<int> sortOrder = const Value.absent(),
              }) => SavedItemsCompanion.insert(
                id: id,
                name: name,
                defaultPrice: defaultPrice,
                sortOrder: sortOrder,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SavedItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SavedItemsTable,
      SavedItem,
      $$SavedItemsTableFilterComposer,
      $$SavedItemsTableOrderingComposer,
      $$SavedItemsTableAnnotationComposer,
      $$SavedItemsTableCreateCompanionBuilder,
      $$SavedItemsTableUpdateCompanionBuilder,
      (SavedItem, BaseReferences<_$AppDatabase, $SavedItemsTable, SavedItem>),
      SavedItem,
      PrefetchHooks Function()
    >;
typedef $$ShowcasePhotosTableCreateCompanionBuilder =
    ShowcasePhotosCompanion Function({
      Value<int> id,
      required String filePath,
      required String category,
      Value<int> createdAt,
    });
typedef $$ShowcasePhotosTableUpdateCompanionBuilder =
    ShowcasePhotosCompanion Function({
      Value<int> id,
      Value<String> filePath,
      Value<String> category,
      Value<int> createdAt,
    });

class $$ShowcasePhotosTableFilterComposer
    extends Composer<_$AppDatabase, $ShowcasePhotosTable> {
  $$ShowcasePhotosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get filePath => $composableBuilder(
    column: $table.filePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ShowcasePhotosTableOrderingComposer
    extends Composer<_$AppDatabase, $ShowcasePhotosTable> {
  $$ShowcasePhotosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get filePath => $composableBuilder(
    column: $table.filePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ShowcasePhotosTableAnnotationComposer
    extends Composer<_$AppDatabase, $ShowcasePhotosTable> {
  $$ShowcasePhotosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get filePath =>
      $composableBuilder(column: $table.filePath, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$ShowcasePhotosTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ShowcasePhotosTable,
          ShowcasePhoto,
          $$ShowcasePhotosTableFilterComposer,
          $$ShowcasePhotosTableOrderingComposer,
          $$ShowcasePhotosTableAnnotationComposer,
          $$ShowcasePhotosTableCreateCompanionBuilder,
          $$ShowcasePhotosTableUpdateCompanionBuilder,
          (
            ShowcasePhoto,
            BaseReferences<_$AppDatabase, $ShowcasePhotosTable, ShowcasePhoto>,
          ),
          ShowcasePhoto,
          PrefetchHooks Function()
        > {
  $$ShowcasePhotosTableTableManager(
    _$AppDatabase db,
    $ShowcasePhotosTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$ShowcasePhotosTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () =>
                  $$ShowcasePhotosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$ShowcasePhotosTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> filePath = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
              }) => ShowcasePhotosCompanion(
                id: id,
                filePath: filePath,
                category: category,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String filePath,
                required String category,
                Value<int> createdAt = const Value.absent(),
              }) => ShowcasePhotosCompanion.insert(
                id: id,
                filePath: filePath,
                category: category,
                createdAt: createdAt,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ShowcasePhotosTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ShowcasePhotosTable,
      ShowcasePhoto,
      $$ShowcasePhotosTableFilterComposer,
      $$ShowcasePhotosTableOrderingComposer,
      $$ShowcasePhotosTableAnnotationComposer,
      $$ShowcasePhotosTableCreateCompanionBuilder,
      $$ShowcasePhotosTableUpdateCompanionBuilder,
      (
        ShowcasePhoto,
        BaseReferences<_$AppDatabase, $ShowcasePhotosTable, ShowcasePhoto>,
      ),
      ShowcasePhoto,
      PrefetchHooks Function()
    >;
typedef $$CoreCuttingRatesTableCreateCompanionBuilder =
    CoreCuttingRatesCompanion Function({
      Value<int> id,
      required String holeSize,
      required double pricePerHole,
      Value<int> sortOrder,
    });
typedef $$CoreCuttingRatesTableUpdateCompanionBuilder =
    CoreCuttingRatesCompanion Function({
      Value<int> id,
      Value<String> holeSize,
      Value<double> pricePerHole,
      Value<int> sortOrder,
    });

class $$CoreCuttingRatesTableFilterComposer
    extends Composer<_$AppDatabase, $CoreCuttingRatesTable> {
  $$CoreCuttingRatesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get holeSize => $composableBuilder(
    column: $table.holeSize,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get pricePerHole => $composableBuilder(
    column: $table.pricePerHole,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CoreCuttingRatesTableOrderingComposer
    extends Composer<_$AppDatabase, $CoreCuttingRatesTable> {
  $$CoreCuttingRatesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get holeSize => $composableBuilder(
    column: $table.holeSize,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get pricePerHole => $composableBuilder(
    column: $table.pricePerHole,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CoreCuttingRatesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CoreCuttingRatesTable> {
  $$CoreCuttingRatesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get holeSize =>
      $composableBuilder(column: $table.holeSize, builder: (column) => column);

  GeneratedColumn<double> get pricePerHole => $composableBuilder(
    column: $table.pricePerHole,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);
}

class $$CoreCuttingRatesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CoreCuttingRatesTable,
          CoreCuttingRate,
          $$CoreCuttingRatesTableFilterComposer,
          $$CoreCuttingRatesTableOrderingComposer,
          $$CoreCuttingRatesTableAnnotationComposer,
          $$CoreCuttingRatesTableCreateCompanionBuilder,
          $$CoreCuttingRatesTableUpdateCompanionBuilder,
          (
            CoreCuttingRate,
            BaseReferences<
              _$AppDatabase,
              $CoreCuttingRatesTable,
              CoreCuttingRate
            >,
          ),
          CoreCuttingRate,
          PrefetchHooks Function()
        > {
  $$CoreCuttingRatesTableTableManager(
    _$AppDatabase db,
    $CoreCuttingRatesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () =>
                  $$CoreCuttingRatesTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$CoreCuttingRatesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$CoreCuttingRatesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> holeSize = const Value.absent(),
                Value<double> pricePerHole = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
              }) => CoreCuttingRatesCompanion(
                id: id,
                holeSize: holeSize,
                pricePerHole: pricePerHole,
                sortOrder: sortOrder,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String holeSize,
                required double pricePerHole,
                Value<int> sortOrder = const Value.absent(),
              }) => CoreCuttingRatesCompanion.insert(
                id: id,
                holeSize: holeSize,
                pricePerHole: pricePerHole,
                sortOrder: sortOrder,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CoreCuttingRatesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CoreCuttingRatesTable,
      CoreCuttingRate,
      $$CoreCuttingRatesTableFilterComposer,
      $$CoreCuttingRatesTableOrderingComposer,
      $$CoreCuttingRatesTableAnnotationComposer,
      $$CoreCuttingRatesTableCreateCompanionBuilder,
      $$CoreCuttingRatesTableUpdateCompanionBuilder,
      (
        CoreCuttingRate,
        BaseReferences<_$AppDatabase, $CoreCuttingRatesTable, CoreCuttingRate>,
      ),
      CoreCuttingRate,
      PrefetchHooks Function()
    >;
typedef $$AppSettingsTableCreateCompanionBuilder =
    AppSettingsCompanion Function({
      Value<int> id,
      required String ownerName,
      required String ownerPhone,
      Value<String> locale,
    });
typedef $$AppSettingsTableUpdateCompanionBuilder =
    AppSettingsCompanion Function({
      Value<int> id,
      Value<String> ownerName,
      Value<String> ownerPhone,
      Value<String> locale,
    });

class $$AppSettingsTableFilterComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ownerName => $composableBuilder(
    column: $table.ownerName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ownerPhone => $composableBuilder(
    column: $table.ownerPhone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get locale => $composableBuilder(
    column: $table.locale,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AppSettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ownerName => $composableBuilder(
    column: $table.ownerName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ownerPhone => $composableBuilder(
    column: $table.ownerPhone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get locale => $composableBuilder(
    column: $table.locale,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AppSettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get ownerName =>
      $composableBuilder(column: $table.ownerName, builder: (column) => column);

  GeneratedColumn<String> get ownerPhone => $composableBuilder(
    column: $table.ownerPhone,
    builder: (column) => column,
  );

  GeneratedColumn<String> get locale =>
      $composableBuilder(column: $table.locale, builder: (column) => column);
}

class $$AppSettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AppSettingsTable,
          AppSetting,
          $$AppSettingsTableFilterComposer,
          $$AppSettingsTableOrderingComposer,
          $$AppSettingsTableAnnotationComposer,
          $$AppSettingsTableCreateCompanionBuilder,
          $$AppSettingsTableUpdateCompanionBuilder,
          (
            AppSetting,
            BaseReferences<_$AppDatabase, $AppSettingsTable, AppSetting>,
          ),
          AppSetting,
          PrefetchHooks Function()
        > {
  $$AppSettingsTableTableManager(_$AppDatabase db, $AppSettingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$AppSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$AppSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () =>
                  $$AppSettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> ownerName = const Value.absent(),
                Value<String> ownerPhone = const Value.absent(),
                Value<String> locale = const Value.absent(),
              }) => AppSettingsCompanion(
                id: id,
                ownerName: ownerName,
                ownerPhone: ownerPhone,
                locale: locale,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String ownerName,
                required String ownerPhone,
                Value<String> locale = const Value.absent(),
              }) => AppSettingsCompanion.insert(
                id: id,
                ownerName: ownerName,
                ownerPhone: ownerPhone,
                locale: locale,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AppSettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AppSettingsTable,
      AppSetting,
      $$AppSettingsTableFilterComposer,
      $$AppSettingsTableOrderingComposer,
      $$AppSettingsTableAnnotationComposer,
      $$AppSettingsTableCreateCompanionBuilder,
      $$AppSettingsTableUpdateCompanionBuilder,
      (
        AppSetting,
        BaseReferences<_$AppDatabase, $AppSettingsTable, AppSetting>,
      ),
      AppSetting,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CustomersTableTableManager get customers =>
      $$CustomersTableTableManager(_db, _db.customers);
  $$BillsTableTableManager get bills =>
      $$BillsTableTableManager(_db, _db.bills);
  $$BillItemsTableTableManager get billItems =>
      $$BillItemsTableTableManager(_db, _db.billItems);
  $$QuotationsTableTableManager get quotations =>
      $$QuotationsTableTableManager(_db, _db.quotations);
  $$QuotationItemsTableTableManager get quotationItems =>
      $$QuotationItemsTableTableManager(_db, _db.quotationItems);
  $$SavedItemsTableTableManager get savedItems =>
      $$SavedItemsTableTableManager(_db, _db.savedItems);
  $$ShowcasePhotosTableTableManager get showcasePhotos =>
      $$ShowcasePhotosTableTableManager(_db, _db.showcasePhotos);
  $$CoreCuttingRatesTableTableManager get coreCuttingRates =>
      $$CoreCuttingRatesTableTableManager(_db, _db.coreCuttingRates);
  $$AppSettingsTableTableManager get appSettings =>
      $$AppSettingsTableTableManager(_db, _db.appSettings);
}
