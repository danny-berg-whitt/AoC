int distance(int a, int b) {
  return a > b ? a - b : b - a;
}

int calculateDistance(List<int> a, List<int> b) {
  a.sort();
  b.sort();
  var d = 0;
  for (int i = 0; i < a.length; i++) {
    d += distance(a[i], b[i]);
  }
  return d;
}

int calculateSimilarityScore(List<int> a, List<int> b) {
  var s = 0;
  for (int i = 0; i < a.length; i++) {
    s += a[i] * b.where((x) => x == a[i]).length;
  }
  return s;
}
