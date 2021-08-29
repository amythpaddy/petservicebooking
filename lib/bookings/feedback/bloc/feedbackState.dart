import 'package:equatable/equatable.dart';

class FeedbackState extends Equatable {
  final bool loading;

  FeedbackState({this.loading = true});

  @override
  List<Object?> get props => [loading];
}
