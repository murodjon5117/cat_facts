import 'package:cat_facts/data/repositories/cat_repository.dart';
import 'package:cat_facts/domain/model/cat_fact.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

abstract class CatFactsEvent {}

class LoadNewFact extends CatFactsEvent {}

abstract class CatFactsState {}

class CatFactsInitial extends CatFactsState {}

class CatFactsLoading extends CatFactsState {}

class CatFactsLoaded extends CatFactsState {
  final CatFact fact;
  final String imageUrl;
  CatFactsLoaded(this.fact, this.imageUrl);
}

class CatFactsError extends CatFactsState {
  final String message;
  CatFactsError(this.message);
}

class CatFactsBloc extends Bloc<CatFactsEvent, CatFactsState> {
  final CatRepository repository;
  final Box<CatFact> factsBox;

  CatFactsBloc({required this.repository, required this.factsBox}) : super(CatFactsInitial()) {
    on<LoadNewFact>(_onLoadNewFact);
  }

  Future<void> _onLoadNewFact(LoadNewFact event, Emitter<CatFactsState> emit) async {
    emit(CatFactsLoading());
    try {
      final facts = await repository.getFacts();
      final randomFact = facts[DateTime.now().microsecond % facts.length];
      await factsBox.add(randomFact);
      final imageUrl = 'https://cataas.com/cat?t=${DateTime.now().millisecondsSinceEpoch}';
      emit(CatFactsLoaded(randomFact, imageUrl));
    } catch (e) {
      emit(CatFactsError(e.toString()));
    }
  }
}
