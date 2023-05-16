part of 'transfer_cubit.dart';

class TransferState {
  final ApiStatus<List<Transfer>> transfersStatus;
  final ApiStatus<List<Transfer>> userTransfersStatus;
  final ApiStatus<List<Transfer>> bookTransfersStatus;
  final ApiStatus<Transfer> createTransferStatus;
  final ApiStatus<Transfer> makeRequestStatus;
  final ApiStatus<Transfer> makeTransferStatus;
  final ApiStatus<Transfer> getTransferStatus;

  final PickUpPoint? point;
  final Book? book;

  TransferState({
    this.transfersStatus = const IdleStatus(),
    this.userTransfersStatus = const IdleStatus(),
    this.bookTransfersStatus = const IdleStatus(),
    this.createTransferStatus = const IdleStatus(),
    this.makeRequestStatus = const IdleStatus(),
    this.makeTransferStatus = const IdleStatus(),
    this.getTransferStatus = const IdleStatus(),
    this.point,
    this.book,
  });

  TransferState copyWith({
    ApiStatus<List<Transfer>>? transfersStatus,
    ApiStatus<List<Transfer>>? userTransfersStatus,
    ApiStatus<List<Transfer>>? bookTransfersStatus,
    ApiStatus<Transfer>? createTransferStatus,
    ApiStatus<Transfer>? makeRequestStatus,
    ApiStatus<Transfer>? makeTransferStatus,
    ApiStatus<Transfer>? getTransferStatus,
    PickUpPoint? point,
    Book? book,
  }) {
    return TransferState(
      bookTransfersStatus: bookTransfersStatus ?? this.bookTransfersStatus,
      createTransferStatus: createTransferStatus ?? this.createTransferStatus,
      userTransfersStatus: userTransfersStatus ?? this.userTransfersStatus,
      transfersStatus: transfersStatus ?? this.transfersStatus,
      makeRequestStatus: makeRequestStatus ?? this.makeRequestStatus,
      makeTransferStatus: makeTransferStatus ?? this.makeTransferStatus,
      getTransferStatus : getTransferStatus ?? this.getTransferStatus,
      point: point ?? this.point,
      book: book ?? this.book,
    );
  }
}
