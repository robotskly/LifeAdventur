extension SafeListAccess<T> on List<T> {
  T? getOrNull(int index) {
    try {
      return (index >= 0 && index < length) ? this[index] : null;
    } catch (_) {
      return null;
    }
  }
}