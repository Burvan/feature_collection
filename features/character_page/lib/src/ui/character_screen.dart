import 'package:character_page/src/bloc/character_bloc.dart';
import 'package:character_page/src/ui/character_form.dart';
import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';

@RoutePage()
class CharacterScreen extends StatelessWidget {
  const CharacterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CharacterBloc>(
      create: (_) => CharacterBloc(
        fetchCharactersUseCase: appLocator.get<FetchCharactersUseCase>(),
        addCharacterUseCase: appLocator.get<AddCharacterUseCase>(),
        appRouter: appLocator.get<AppRouter>(),
      ),
      child: const CharacterForm(),
    );
  }
}
