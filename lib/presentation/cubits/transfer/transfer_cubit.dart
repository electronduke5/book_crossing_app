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

  Future<void> loadUserTransfers(User user) async {
    emit(state.copyWith(userTransfersStatus: LoadingStatus()));
    try {
      final userTransfers = await _repository.getUserTransfers(user);
      emit(state.copyWith(userTransfersStatus: LoadedStatus(userTransfers)));
    } catch (exception) {
      emit(state.copyWith(
          userTransfersStatus:
              FailedStatus(state.transfersStatus.message ?? exception.toString())));
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
      emit(state.copyWith(createTransferStatus: LoadedStatus(transfer)));
    } catch (exception) {
      emit(state.copyWith(
          createTransferStatus:
              FailedStatus(state.transfersStatus.message ?? exception.toString())));
    }
  }
}
