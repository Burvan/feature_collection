import 'package:character_page/src/bloc/character_bloc.dart';
import 'package:character_page/src/ui/widgets/add_character_dialog.dart';
import 'package:character_page/src/ui/widgets/search_text_field.dart';
import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/src/models/models.dart';
import 'package:flutter/material.dart';

class CharacterForm extends StatefulWidget {
  const CharacterForm({super.key});

  @override
  State<CharacterForm> createState() => _CharacterFormState();
}

class _CharacterFormState extends State<CharacterForm> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    final CharacterBloc bloc = context.read<CharacterBloc>();

    _scrollController.addListener(
      () {
        if (!bloc.state.isEndOfList &&
            !bloc.state.isCharactersLoading &&
            _scrollController.offset >=
                _scrollController.position.maxScrollExtent *
                    bloc.state.triggerOffset) {
          bloc.add(const LoadMore());
        }
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final CharacterBloc bloc = context.read<CharacterBloc>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          LocaleKeys.character_hpCharacters.watchTr(context),
          style: AppTextTheme.font18Bold,
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<CharacterBloc, CharacterState>(
        builder: (BuildContext context, CharacterState state) {
          return state.isPageLoading
              ? const AppProgressIndicator()
              : Column(
                  children: <Widget>[
                    SearchField(
                      controller: _searchController,
                      onClear: () {
                        bloc.add(const ResetSearch());
                      },
                      focusNode: _searchFocusNode,
                      onChanged: (String query) {
                        bloc.add(SearchCharacters(query: query));
                      },
                    ),
                    Expanded(
                      child: (state.hasException)
                          ? Center(
                              child: Text(
                                state.exception!.toLocalizedText(),
                                style: AppTextTheme.font20Bold,
                                textAlign: TextAlign.center,
                              ),
                            )
                          : ListView.builder(
                              controller: _scrollController,
                              itemCount: state.characters.isEmpty
                                  ? 1
                                  : state.characters.length +
                                      (state.isEndOfList ? 0 : 1),
                              itemBuilder: (_, int index) {
                                if (state.characters.isEmpty) {
                                  return state.isCharactersLoading
                                      ? const AppProgressIndicator()
                                      : Center(
                                          child: Text(
                                            LocaleKeys.character_noCharacters
                                                .watchTr(context),
                                            style: AppTextTheme.font20Bold,
                                          ),
                                        );
                                }

                                if (index >= state.characters.length) {
                                  return state.isCharactersLoading
                                      ? const AppProgressIndicator()
                                      : const SizedBox.shrink();
                                }

                                return CharacterTile(
                                  character: state.characters[index],
                                );
                              },
                            ),
                    ),
                  ],
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return BlocProvider<CharacterBloc>.value(
                value: bloc,
                child: BlocBuilder<CharacterBloc, CharacterState>(
                  builder: (_, CharacterState state) {
                    return AddCharacterDialog(
                      onCancel: () {
                        bloc.add(const NavigateToPreviousScreen());
                      },
                      selectedStatus: bloc.state.status ?? Status.unknown,
                      onStatusChanged: (Status status) {
                        bloc.add(
                          SetCharacterStatus(status: status),
                        );
                      },
                      onAdd: (Character character) {
                        bloc.add(
                          AddCharacter(character: character),
                        );
                      },
                      addButtonChild: bloc.state.isCharactersLoading
                          ? const CircularProgressIndicator()
                          : Text(LocaleKeys.character_add.watchTr(context)),
                    );
                  },
                ),
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
