// Generates a 1024x1024 app icon PNG for the CVSS Calculator.
// Run: dart run tool/generate_icon.dart

import 'dart:io';
import 'dart:typed_data';
import 'dart:math' as math;
import 'package:image/image.dart' as img;

void main() {
  const size = 1024;
  final image = img.Image(width: size, height: size);

  // Background: #0F172A
  final bgColor = img.ColorRgba8(15, 23, 42, 255);
  img.fill(image, color: bgColor);

  // Draw rounded rectangle background
  // (fill is already done, just add a subtle gradient-like effect)

  // Draw a circle in the center with primary blue
  final centerX = size ~/ 2;
  final centerY = size ~/ 2;

  // Outer glow ring
  final glowColor = img.ColorRgba8(59, 130, 246, 40);
  _drawFilledCircle(image, centerX, centerY, 420, glowColor);

  // Blue circle background
  final blueColor = img.ColorRgba8(59, 130, 246, 255);
  _drawFilledCircle(image, centerX, centerY, 360, blueColor);

  // Dark inner circle
  final darkInner = img.ColorRgba8(15, 23, 42, 255);
  _drawFilledCircle(image, centerX, centerY, 280, darkInner);

  // Draw shield shape
  _drawShield(image, centerX, centerY - 20, 200, img.ColorRgba8(96, 165, 250, 255));

  // Draw checkmark inside shield
  _drawCheckmark(image, centerX, centerY + 10, 80, img.ColorRgba8(15, 23, 42, 255));

  // Round the corners
  _roundCorners(image, 220);

  // Save
  final dir = Directory('assets');
  if (!dir.existsSync()) dir.createSync(recursive: true);
  final pngBytes = img.encodePng(image);
  File('assets/app_icon.png').writeAsBytesSync(pngBytes);
  print('Generated assets/app_icon.png (${pngBytes.length} bytes)');
}

void _drawFilledCircle(img.Image image, int cx, int cy, int radius, img.Color color) {
  for (int y = cy - radius; y <= cy + radius; y++) {
    for (int x = cx - radius; x <= cx + radius; x++) {
      if (x >= 0 && x < image.width && y >= 0 && y < image.height) {
        final dx = x - cx;
        final dy = y - cy;
        if (dx * dx + dy * dy <= radius * radius) {
          image.setPixel(x, y, color);
        }
      }
    }
  }
}

void _drawShield(img.Image image, int cx, int cy, int halfHeight, img.Color color) {
  final top = cy - halfHeight;
  final bottom = cy + halfHeight;
  final halfWidth = (halfHeight * 0.75).toInt();

  for (int y = top; y <= bottom; y++) {
    final progress = (y - top) / (bottom - top); // 0.0 to 1.0

    int currentHalfWidth;
    if (progress < 0.55) {
      // Top portion - straight sides
      currentHalfWidth = halfWidth;
    } else {
      // Bottom portion - narrows to a point
      final narrowProgress = (progress - 0.55) / 0.45;
      currentHalfWidth = (halfWidth * (1.0 - narrowProgress * narrowProgress)).toInt();
    }

    for (int x = cx - currentHalfWidth; x <= cx + currentHalfWidth; x++) {
      if (x >= 0 && x < image.width && y >= 0 && y < image.height) {
        image.setPixel(x, y, color);
      }
    }
  }
}

void _drawCheckmark(img.Image image, int cx, int cy, int armLength, img.Color color) {
  // Draw a thick checkmark
  const thickness = 28;

  // Left arm of checkmark (going down-right)
  final startX = cx - armLength ~/ 2 - 10;
  final startY = cy - 10;
  final midX = cx - 10;
  final midY = cy + armLength ~/ 3;

  // Right arm of checkmark (going up-right)
  final endX = cx + armLength ~/ 2 + 20;
  final endY = cy - armLength ~/ 2;

  _drawThickLine(image, startX, startY, midX, midY, thickness, color);
  _drawThickLine(image, midX, midY, endX, endY, thickness, color);
}

void _drawThickLine(img.Image image, int x0, int y0, int x1, int y1, int thickness, img.Color color) {
  final halfT = thickness ~/ 2;
  final dx = x1 - x0;
  final dy = y1 - y0;
  final steps = math.max(dx.abs(), dy.abs());

  for (int s = 0; s <= steps; s++) {
    final x = x0 + (dx * s / steps).round();
    final y = y0 + (dy * s / steps).round();

    for (int ty = -halfT; ty <= halfT; ty++) {
      for (int tx = -halfT; tx <= halfT; tx++) {
        final px = x + tx;
        final py = y + ty;
        if (px >= 0 && px < image.width && py >= 0 && py < image.height) {
          if (tx * tx + ty * ty <= halfT * halfT) {
            image.setPixel(px, py, color);
          }
        }
      }
    }
  }
}

void _roundCorners(img.Image image, int radius) {
  final transparent = img.ColorRgba8(0, 0, 0, 0);
  final w = image.width;
  final h = image.height;

  // Top-left
  _roundCorner(image, 0, 0, radius, transparent, false, false);
  // Top-right
  _roundCorner(image, w - radius, 0, radius, transparent, true, false);
  // Bottom-left
  _roundCorner(image, 0, h - radius, radius, transparent, false, true);
  // Bottom-right
  _roundCorner(image, w - radius, h - radius, radius, transparent, true, true);
}

void _roundCorner(img.Image image, int ox, int oy, int radius, img.Color color, bool flipX, bool flipY) {
  final cx = flipX ? ox : ox + radius;
  final cy = flipY ? oy : oy + radius;

  for (int y = 0; y < radius; y++) {
    for (int x = 0; x < radius; x++) {
      final px = ox + (flipX ? radius - 1 - x : x);
      final py = oy + (flipY ? radius - 1 - y : y);

      final dx = (flipX ? ox + radius - 1 - px : px - ox) - radius;
      final dy = (flipY ? oy + radius - 1 - py : py - oy) - radius;

      if (dx * dx + dy * dy > radius * radius) {
        if (px >= 0 && px < image.width && py >= 0 && py < image.height) {
          image.setPixel(px, py, color);
        }
      }
    }
  }
}
