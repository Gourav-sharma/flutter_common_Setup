
import 'package:equatable/equatable.dart';

class ChangepasswordState extends Equatable {
  final String name;

  const ChangepasswordState({required this.name});

  ChangepasswordState copyWith({
    String? name,
  }) {
    return ChangepasswordState(
      name: name ?? this.name,
    );
  }

  @override
  List<Object> get props => [name];
}
