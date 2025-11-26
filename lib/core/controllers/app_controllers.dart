import 'package:flutter/material.dart';

/// Centralized controller management for the BeeChemApp
/// This class provides a centralized way to manage TextEditingControllers
/// and other controllers used throughout the application
class AppControllers {
  // Private constructor to prevent instantiation
  AppControllers._();

  /// Creates a new TextEditingController with optional initial text
  static TextEditingController createTextController([String? initialText]) {
    return TextEditingController(text: initialText);
  }

  /// Creates multiple TextEditingControllers at once
  /// Returns a Map with the provided keys and new controllers as values
  static Map<String, TextEditingController> createMultipleTextControllers(
    List<String> keys, {
    Map<String, String>? initialValues,
  }) {
    final controllers = <String, TextEditingController>{};

    for (final key in keys) {
      final initialValue = initialValues?[key];
      controllers[key] = TextEditingController(text: initialValue);
    }

    return controllers;
  }

  /// Disposes multiple controllers at once
  static void disposeMultipleControllers(
    Map<String, TextEditingController> controllers,
  ) {
    for (final controller in controllers.values) {
      controller.dispose();
    }
  }

  /// Disposes a list of controllers
  static void disposeControllers(List<TextEditingController> controllers) {
    for (final controller in controllers) {
      controller.dispose();
    }
  }

  /// Clears text from multiple controllers
  static void clearMultipleControllers(
    Map<String, TextEditingController> controllers,
  ) {
    for (final controller in controllers.values) {
      controller.clear();
    }
  }

  /// Clears text from a list of controllers
  static void clearControllers(List<TextEditingController> controllers) {
    for (final controller in controllers) {
      controller.clear();
    }
  }

  /// Sets text values for multiple controllers
  static void setMultipleControllerValues(
    Map<String, TextEditingController> controllers,
    Map<String, String> values,
  ) {
    for (final entry in values.entries) {
      final controller = controllers[entry.key];
      if (controller != null) {
        controller.text = entry.value;
      }
    }
  }

  /// Gets text values from multiple controllers
  static Map<String, String> getMultipleControllerValues(
    Map<String, TextEditingController> controllers,
  ) {
    final values = <String, String>{};

    for (final entry in controllers.entries) {
      values[entry.key] = entry.value.text;
    }

    return values;
  }

  /// Validates if any controller in the list is empty
  static bool hasEmptyControllers(List<TextEditingController> controllers) {
    return controllers.any((controller) => controller.text.trim().isEmpty);
  }

  /// Validates if any controller in the map is empty
  static bool hasEmptyControllersInMap(
    Map<String, TextEditingController> controllers,
  ) {
    return controllers.values.any(
      (controller) => controller.text.trim().isEmpty,
    );
  }

  /// Gets the first empty controller key from a map
  static String? getFirstEmptyControllerKey(
    Map<String, TextEditingController> controllers,
  ) {
    for (final entry in controllers.entries) {
      if (entry.value.text.trim().isEmpty) {
        return entry.key;
      }
    }
    return null;
  }
}

/// Extension methods for TextEditingController to add common functionality
extension TextEditingControllerExtension on TextEditingController {
  /// Checks if the controller's text is empty or only whitespace
  bool get isEmpty => text.trim().isEmpty;

  /// Checks if the controller's text is not empty
  bool get isNotEmpty => text.trim().isNotEmpty;

  /// Gets the trimmed text value
  String get trimmedText => text.trim();

  /// Sets text and moves cursor to the end
  void setTextAndCursor(String newText) {
    text = newText;
    selection = TextSelection.fromPosition(TextPosition(offset: text.length));
  }

  /// Clears the text and resets selection
  void clearAndReset() {
    clear();
    selection = const TextSelection.collapsed(offset: 0);
  }
}
