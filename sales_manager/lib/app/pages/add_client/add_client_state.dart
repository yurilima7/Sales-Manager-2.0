import 'package:equatable/equatable.dart';
import 'package:match/match.dart';

part 'add_client_state.g.dart';

@match
enum AddClientStatus {
  initial,
  registering,
  registered,
  error,
}

class AddClientState extends Equatable {
  final AddClientStatus status;
  final String? errorMessage;

  const AddClientState({
    required this.status,
    this.errorMessage,
  });

  const AddClientState.initial()
      : status = AddClientStatus.initial,
        errorMessage = null;

  @override
  List<Object?> get props => [status, errorMessage];

  AddClientState copyWith({
    AddClientStatus? status,
    String? errorMessage,
  }) {
    return AddClientState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
