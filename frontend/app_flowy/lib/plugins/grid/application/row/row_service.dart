import 'package:dartz/dartz.dart';
import 'package:flowy_sdk/dispatch/dispatch.dart';
import 'package:flowy_sdk/protobuf/flowy-error/errors.pb.dart';
import 'package:flowy_sdk/protobuf/flowy-grid/block_entities.pb.dart';
import 'package:flowy_sdk/protobuf/flowy-grid/grid_entities.pb.dart';
import 'package:flowy_sdk/protobuf/flowy-grid/row_entities.pb.dart';
import 'package:flowy_sdk/protobuf/flowy-grid/setting_entities.pb.dart';

class RowFFIService {
  final String gridId;
  final String blockId;

  RowFFIService({
    required this.gridId,
    required this.blockId,
  });

  Future<Either<RowPB, FlowyError>> createRow(String rowId) {
    final payload = CreateTableRowPayloadPB.create()
      ..gridId = gridId
      ..startRowId = rowId;

    return GridEventCreateTableRow(payload).send();
  }

  Future<Either<Unit, FlowyError>> moveRow({
    required String rowId,
    required int fromIndex,
    required int toIndex,
    required GridLayout layout,
    String? upperRowId,
  }) {
    var payload = MoveRowPayloadPB.create()
      ..viewId = gridId
      ..rowId = rowId
      ..layout = layout
      ..fromIndex = fromIndex
      ..toIndex = toIndex;

    if (upperRowId != null) {
      payload.upperRowId = upperRowId;
    }

    return GridEventMoveRow(payload).send();
  }

  Future<Either<OptionalRowPB, FlowyError>> getRow(String rowId) {
    final payload = RowIdPB.create()
      ..gridId = gridId
      ..blockId = blockId
      ..rowId = rowId;

    return GridEventGetRow(payload).send();
  }

  Future<Either<Unit, FlowyError>> deleteRow(String rowId) {
    final payload = RowIdPB.create()
      ..gridId = gridId
      ..blockId = blockId
      ..rowId = rowId;

    return GridEventDeleteRow(payload).send();
  }

  Future<Either<Unit, FlowyError>> duplicateRow(String rowId) {
    final payload = RowIdPB.create()
      ..gridId = gridId
      ..blockId = blockId
      ..rowId = rowId;

    return GridEventDuplicateRow(payload).send();
  }
}
