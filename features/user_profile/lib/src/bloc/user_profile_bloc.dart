import 'package:core/core.dart';
import 'package:domain/domain.dart';

part 'user_profile_event.dart';
part 'user_profile_state.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  final GetCurrentUserUseCase _getCurrentUserUseCase;

  UserProfileBloc({
    required GetCurrentUserUseCase getCurrentUserUseCase,
  })  : _getCurrentUserUseCase = getCurrentUserUseCase,
        super(UserProfileState.initial()) {
    on<InitUserProfile>(_onInitUserProfile);

    add(const InitUserProfile());
  }

  Future<void> _onInitUserProfile(
    InitUserProfile event,
    Emitter<UserProfileState> emit,
  ) async {
    emit(state.copyWith(isPageLoading: true));

    try {
      final User currentUser = await _getCurrentUserUseCase.execute(
        const NoParams(),
      );

      emit(
        state.copyWith(
          user: currentUser,
        ),
      );
    } on AppException catch (e) {
      emit(
        state.copyWith(exception: () => e),
      );
    } finally {
      emit(
        state.copyWith(isPageLoading: false),
      );
    }
  }
}
