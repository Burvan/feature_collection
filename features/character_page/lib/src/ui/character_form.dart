import 'package:character_page/src/bloc/character_bloc.dart';
import 'package:character_page/src/ui/widgets/add_character_dialog.dart';
import 'package:character_page/src/ui/widgets/search_text_field.dart';
import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
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
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) {
      return false;
    }
    final double maxScroll = _scrollController.position.maxScrollExtent;
    final double currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll - 100);
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<CharacterBloc>().add(
            const FetchCharactersEvent(),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final CharacterBloc bloc = context.read<CharacterBloc>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          LocaleKeys.character_HPCharacters.watchTr(context),
          style: AppTextTheme.font18Bold,
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<CharacterBloc, CharacterState>(
        builder: (BuildContext context, CharacterState state) {
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: _searchFocusNode.unfocus,
            child: Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    SearchField(
                      controller: _searchController,
                      onClear: () {
                        bloc.add(const ResetSearchEvent());
                        bloc.add(const InitEvent());
                      },
                      onSubmitted: (String query) {
                        query = _searchController.text;

                        if (query.isNotEmpty) {
                          bloc.add(
                            SearchCharactersEvent(query: query),
                          );
                        }
                      },
                      focusNode: _searchFocusNode,
                      onPressed: () {
                        final String query = _searchController.text;

                        if (query.isNotEmpty) {
                          bloc.add(
                            SearchCharactersEvent(query: query),
                          );
                        }
                      },
                    ),
                    Expanded(
                      child: (state.errorMessage != null && state.characters.isEmpty)
                          ? Center(
                              child: Text(
                                state.errorMessage!,
                                style: AppTextTheme.font20Bold,
                                textAlign: TextAlign.center,
                              ),
                            )
                          : ListView.builder(
                              controller: _scrollController,
                              itemCount: state.isEndOfList
                                  ? state.characters.length
                                  : state.characters.length + 1,
                              itemBuilder: (_, int index) {
                                if (index >= state.characters.length) {
                                  return const SizedBox();
                                }
                                return CharacterTile(
                                  character: state.characters[index],
                                );
                              },
                            ),
                    ),
                  ],
                ),
                if (state.isLoading)
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) => AddCharacterDialog(bloc: bloc),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
