abstract interface class Adaptable<S, T> {
  T from(S obj);
  S to(T obj);
}
