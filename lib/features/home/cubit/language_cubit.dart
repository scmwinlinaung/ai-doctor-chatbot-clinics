import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'language_state.dart';
part 'language_cubit.freezed.dart';

@injectable
class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit() : super(const LanguageState(currentLanguage: 'en'));

  void setLanguage(String language) {
    emit(LanguageState(currentLanguage: language));
  }
}
