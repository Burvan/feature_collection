import 'package:chat/src/bloc/user_selection_bloc/user_selection_bloc.dart';
import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';

class AppUsersDialog extends StatelessWidget {
  const AppUsersDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserSelectionBloc>(
      create: (_) => UserSelectionBloc(
        fetchUsersUseCase: appLocator.get<FetchUsersUseCase>(),
        fetchCurrentUserUseCase: appLocator.get<FetchCurrentUserUseCase>(),
        appRouter: appLocator.get<AppRouter>(),
      ),
      child: const _UserSelectionForm(),
    );
  }
}

class _UserSelectionForm extends StatefulWidget {
  const _UserSelectionForm();

  @override
  State<_UserSelectionForm> createState() => _UserSelectionFormState();
}

class _UserSelectionFormState extends State<_UserSelectionForm> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    final UserSelectionBloc bloc = context.read<UserSelectionBloc>();

    _scrollController.addListener(
      () {
        if (!bloc.state.isEndOfList &&
            !bloc.state.isLoading &&
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final UserSelectionBloc bloc = context.read<UserSelectionBloc>();

    return AlertDialog(
      title: Center(
        child: Text(
          LocaleKeys.chat_allUsers.watchTr(context),
          style: AppTextTheme.font17.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      content: BlocBuilder<UserSelectionBloc, UserSelectionState>(
        builder: (_, UserSelectionState state) {
          return state.isLoading
              ? const Center(child: CircularProgressIndicator())
              : SizedBox(
                  height: MediaQuery.sizeOf(context).height / 2,
                  width: MediaQuery.sizeOf(context).width / 2,
                  child: ListView.separated(
                    controller: _scrollController,
                    itemCount: state.users.length,
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemBuilder: (_, int index) {
                      return ListTile(
                        title: Text(
                          '${state.users[index].firstName} ${state.users[index].lastName}',
                        ),
                        onTap: () {
                          bloc.add(
                            NavigateToChat(
                              selectedUserId: state.users[index].id,
                              avatar: state.users[index].avatar,
                              fullName: state.users[index].firstName,
                            ),
                          );
                        },
                      );
                    },
                  ),
                );
        },
      ),
    );
  }
}
