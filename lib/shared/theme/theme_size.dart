enum ThemeSize {
  xs,
  sm,
  md,
  lg,
  xl,
}

ThemeSize get xs => ThemeSize.xs;
ThemeSize get sm => ThemeSize.sm;
ThemeSize get md => ThemeSize.md;
ThemeSize get lg => ThemeSize.lg;
ThemeSize get xl => ThemeSize.xl;

extension ThemeSizeExtension on ThemeSize {
  num get scaleFactor {
    List<double> sizes = [0.6, 0.8, 1.0, 1.2, 1.4];
    List<ThemeSize> sizeIndexes = [xs, sm, md, lg, xl];
    int sizeIndex = sizeIndexes.indexOf(this);
    return sizes[sizeIndex];
  }
}
