import 'package:emerging_ideas/model/ideas_model.dart';
import 'package:equatable/equatable.dart';

abstract class IdeasState extends Equatable {
  const IdeasState();

  @override
  List<Object?> get props => [];
}

class IdeasInitial extends IdeasState {}

class IdeasLoading extends IdeasState {}

class IdeasLoaded extends IdeasState {
  final List<IdeasModel> ideas;

  const IdeasLoaded(this.ideas);

  @override
  List<Object?> get props => [ideas];
}

class IdeasError extends IdeasState {
  final String message;

  const IdeasError(this.message);

  @override
  List<Object?> get props => [message];
}

class IdeaPosting extends IdeasState {}

class IdeaPosted extends IdeasState {}

class IdeaPostError extends IdeasState {
  final String message;

  const IdeaPostError(this.message);

  @override
  List<Object?> get props => [message];
}
