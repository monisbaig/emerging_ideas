import 'package:emerging_ideas/model/ideas_model.dart';
import 'package:emerging_ideas/repository/ideas_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'ideas_state.dart';

class IdeasCubit extends Cubit<IdeasState> {
  final IdeasRepository _ideasRepository;

  IdeasCubit(this._ideasRepository) : super(IdeasInitial());

  Future<void> fetchIdeas() async {
    emit(IdeasLoading());
    try {
      final List<IdeasModel> ideas = await _ideasRepository.fetchData();
      emit(IdeasLoaded(ideas));
    } catch (e) {
      emit(IdeasError("Failed to fetch ideas: $e"));
    }
  }

  Future<void> _modifyIdea(
    Future<void> Function() action,
    String errorMessage,
  ) async {
    emit(IdeasLoading());
    try {
      await action();
      fetchIdeas();
    } catch (e) {
      emit(IdeasError(errorMessage));
    }
  }

  Future<void> postIdea(IdeasModel idea) async {
    await _modifyIdea(
      () => _ideasRepository.postData(idea),
      "Failed to post idea",
    );
  }

  Future<void> editIdea({
    required int id,
    required String title,
    required String description,
    required String email,
    required String image,
  }) async {
    await _modifyIdea(
      () => _ideasRepository.editData(
        id: id,
        title: title,
        description: description,
        email: email,
        image: image,
      ),
      "Failed to edit idea",
    );
  }

  Future<void> deleteIdea({required int id, required String email}) async {
    await _modifyIdea(
      () => _ideasRepository.deleteData(id: id, email: email),
      "Failed to delete idea",
    );
  }
}
