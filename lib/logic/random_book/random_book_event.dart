import 'package:equatable/equatable.dart';

abstract class RandomBookEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchRandomBook extends RandomBookEvent{}