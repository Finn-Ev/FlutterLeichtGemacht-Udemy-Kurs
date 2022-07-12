abstract class TodoFailure {}

class InsufficientPermissions extends TodoFailure {}

class UnexpectedFailure extends TodoFailure {}

String mapTodosFailureToMessage(TodoFailure failure) {
  switch (failure.runtimeType) {
    case InsufficientPermissions:
      return 'Insufficient Permissions. Please relaunch the app';
    case UnexpectedFailure:
      return 'Something went wrong';
    default:
      return 'Unexpected Error';
  }
}
