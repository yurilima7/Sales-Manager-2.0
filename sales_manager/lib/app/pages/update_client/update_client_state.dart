import 'package:equatable/equatable.dart';
import 'package:match/match.dart';

part 'update_client_state.g.dart';

@match
enum UpdateClientStatus {
  initial,
  updating,
  updated,
  error,
}

class UpdateClientState extends Equatable {
  final UpdateClientStatus status;
  final String? errorMessage;

  const UpdateClientState({
    required this.status,
    this.errorMessage,
  });

  const UpdateClientState.initial()
      : status = UpdateClientStatus.initial,
        errorMessage = null;

  @override
  List<Object?> get props => [status, errorMessage];

  UpdateClientState copyWith({
    UpdateClientStatus? status,
    String? errorMessage,
  }) {
    return UpdateClientState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
