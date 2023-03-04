// ignore: one_member_abstracts
abstract class UseCase<T, S> {
  T call<N>(S params);
}

class NoParams {}

class NoGeneric {}
