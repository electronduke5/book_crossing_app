part of 'transfer_cubit.dart';

class TransferState {
  final ApiStatus<List<Transfer>> transfersStatus;
  final ApiStatus<List<Transfer>> userTransfersStatus;
  final ApiStatus<List<Transfer>> bookTransfersStatus;
  final ApiStatus<Transfer> createTransferStatus;

  TransferState({
    this.transfersStatus = const IdleStatus(),
    this.userTransfersStatus = const IdleStatus(),
    this.bookTransfersStatus = const IdleStatus(),
    this.createTransferStatus = const IdleStatus(),
  });

  TransferState copyWith({
    ApiStatus<List<Transfer>>? transfersStatus,
    ApiStatus<List<Transfer>>? userTransfersStatus,
    ApiStatus<List<Transfer>>? bookTransfersStatus,
    ApiStatus<Transfer>? createTransferStatus,
  }) {
    return TransferState(
      bookTransfersStatus: bookTransfersStatus ?? this.bookTransfersStatus,
      createTransferStatus: createTransferStatus ?? this.createTransferStatus,
      userTransfersStatus: userTransfersStatus ?? this.userTransfersStatus,
      transfersStatus: transfersStatus ?? this.transfersStatus,
    );
  }
}
