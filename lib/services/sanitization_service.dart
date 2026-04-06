/// Chapter 6: Input sanitization to prevent injection attacks.
class SanitizationService {
  /// Strip HTML tags to prevent XSS.
  static String stripHtml(String input) {
    return input.replaceAll(RegExp(r'<[^>]*>'), '');
  }

  /// Escape special characters for safe display.
  static String escapeHtml(String input) {
    return input
        .replaceAll('&', '&amp;')
        .replaceAll('<', '&lt;')
        .replaceAll('>', '&gt;')
        .replaceAll('"', '&quot;')
        .replaceAll("'", '&#x27;');
  }

  /// Validate that input matches an allowlist pattern.
  static bool matchesPattern(String input, RegExp pattern) {
    return pattern.hasMatch(input);
  }

  /// Sanitize a transfer note — strip HTML, limit length.
  static String sanitizeNote(String input) {
    final stripped = stripHtml(input);
    return stripped.length > 200 ? stripped.substring(0, 200) : stripped;
  }

  /// Validate account ID format (alphanumeric + hyphens only).
  static bool isValidAccountId(String id) {
    return RegExp(r'^[a-zA-Z0-9-]+$').hasMatch(id);
  }
}
