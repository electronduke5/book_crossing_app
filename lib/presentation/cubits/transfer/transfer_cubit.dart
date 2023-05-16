import 'package:bloc/bloc.dart';
import 'package:book_crossing_app/presentation/cubits/models_status.dart';
import 'package:book_crossing_app/presentation/di/app_module.dart';

import '../../../data/models/book.dart';
import '../../../data/models/pick_up_point.dart';
import '../../../data/models/transfer.dart';
import '../../../data/models/user.dart';

part 'transfer_state.dart';

class TransferCubit extends Cubit<TransferState> {
  TransferCubit() : super(TransferState());

  final _repository = AppModule.getTransferRepository();

  Future<void> pointChanged(PickUpPoint? point) async {
    emit(state.copyWith(point: point));
  }

  Future<void> bookChanged(Book? book) async {
    emit(state.copyWith(book: book));
  }

  Future<void> loadAllTransfers() async {
    emit(state.copyWith(transfersStatus: LoadingStatus()));
    try {
      final transfers = await _repository.getAllTransfers();
      emit(state.copyWith(transfersStatus: LoadedStatus(transfers)));
    } catch (exception) {
      emit(state.copyWith(
          transfersStatus:
              FailedStatus(state.transfersStatus.message ?? exception.toString())));
    }
  }

  Future<void> loadTransfer(Transfer transfer) async {
    emit(state.copyWith(getTransferStatus: LoadingStatus()));
    try {
      final updatedTransfer = await _repository.getTransfers(transfer);
      emit(state.copyWith(getTransferStatus: LoadedStatus(updatedTransfer)));
    } catch (exception) {
      emit(state.copyWith(
          getTransferStatus:
              FailedStatus(state.getTransferStatus.message ?? exception.toString())));
    }
  }

  Future<List<Transfer>?> loadUserTransfers(User user, {bool isActive = true}) async {
    emit(state.copyWith(userTransfersStatus: LoadingStatus()));
    try {
      final userTransfers = await _repository.getUserTransfers(user, isActive: isActive);
      emit(state.copyWith(userTransfersStatus: LoadedStatus(userTransfers)));
      return userTransfers;
    } catch (exception) {
      emit(state.copyWith(
          userTransfersStatus:
              FailedStatus(state.transfersStatus.message ?? exception.toString())));
      return null;
    }
  }

  Future<void> loadBookTransfers(Book book) async {
    emit(state.copyWith(bookTransfersStatus: LoadingStatus()));
    try {
      final bookTransfers = await _repository.getBookTransfers(book);
      emit(state.copyWith(bookTransfersStatus: LoadedStatus(bookTransfers)));
    } catch (exception) {
      emit(state.copyWith(
          bookTransfersStatus:
              FailedStatus(state.transfersStatus.message ?? exception.toString())));
    }
  }

  Future<void> createTransfer(
      {required User user, required Book book, required PickUpPoint point}) async {
    emit(state.copyWith(createTransferStatus: LoadingStatus()));
    try {
      final transfer = await _repository.createTransfer(
        user: user,
        book: book,
        pickUpPoint: point,
      );
      emit(state.copyWith(createTransferStatus: LoadedStatus<Transfer>(transfer)));
    } catch (exception) {
      emit(state.copyWith(
          createTransferStatus:
              FailedStatus(state.transfersStatus.message ?? exception.toString())));
    }
  }

  Future<void> makeRequest({required User user, required Transfer transfer}) async {
    emit(state.copyWith(makeRequestStatus: LoadingStatus()));
    try {
      final request = await _repository.makeRequest(
        user: user,
        transfer: transfer,
      );
      emit(state.copyWith(makeRequestStatus: LoadedStatus<Transfer>(request)));
    } catch (exception) {
      emit(state.copyWith(
          makeRequestStatus:
              FailedStatus(state.makeRequestStatus.message ?? exception.toString())));
    }
  }

  Future<void> makeTransfer({required User user, required Transfer transfer}) async {
    emit(state.copyWith(makeTransferStatus: LoadingStatus()));
    try {
      final request = await _repository.makeTransfer(
        user: user,
        transfer: transfer,
      );
      emit(state.copyWith(makeTransferStatus: LoadedStatus<Transfer>(request)));
    } catch (exception) {
      emit(state.copyWith(
          makeTransferStatus:
              FailedStatus(state.makeTransferStatus.message ?? exception.toString())));
    }
  }
}
