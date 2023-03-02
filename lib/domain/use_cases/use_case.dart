// ignore: one_member_abstracts
abstract class UseCase<T, S> {
  T call(S params);
}

class NoParams {}
