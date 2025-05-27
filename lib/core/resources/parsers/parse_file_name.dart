String? parseFileName(String? path) {
  if (path == null) return null;
  path = path.split("/").last;
  path = path.split(".").first;
  path = path.replaceAll("_", ' ');
  path = path.replaceAll("-", ' ');
  return path;
}
