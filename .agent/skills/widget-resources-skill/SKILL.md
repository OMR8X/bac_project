---
name: use-widget-resources-skill
description: Use this skill whenever you update, modify, or create a widget that involves style or layout. Always check and reuse shared resources before adding any new styling or spacing values.
---

# Use Widget Resources Skill

This skill enforces the consistent **reuse of shared resources** in Flutter widget implementations.

## When to use this skill

- Use this skill **whenever you update, modify, or create any widget** that has layout, spacing, color, text style, size, or shadow properties.
- Applies to all widget types: `ListView`, `GridView`, `Card`, buttons, text fields, etc.

## How to use it

- Always check and reuse **shared resources** before hardcoding values.
- Resources include:
  - Padding, Margin, and Spacing (`spaces_resources.dart`, `spacing_resources.dart`)
  - Colors (`colors_resources.dart`)
  - Font Styles (`font_styles_manager.dart`)
  - Sizes (`sizes_resources.dart`)
  - Shadows (`shadows_resources.dart`)
  - Border radii (`border_radius_resources.dart`)
  
- All resources are located in:

```dart
lib/core/resources/styles/
```

- ❌ Do not hardcode layout, color, font, or spacing values.
- ✅ Always search the resources folder first and reuse existing values.

## Notes

- This skill is **general** and can be extended later with widget-specific rules.
- For now, its purpose is **ensuring resources are used consistently** whenever widgets are created or updated.

## Skill Enforcement: Usage Marker (Mandatory)

To verify that this skill was used, the agent **must add a specific comment** at the start of every created/updated widget.

### Required Comment (Exact)

```dart
// build-card-widget-skill: applied
```


