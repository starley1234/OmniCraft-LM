$fn = 32;

// ----------------------------------------------------------------------
// Perforated panel 90 x 50 x 10
// 4 x 4 Ø6.6 holes, grid layout
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panel = [90, 50, 10];  // overall size (x, y, z)
hole_d = 6.6;          // hole diameter
pitch_x = 20;          // hole pitch along X
pitch_y = 13.133;      // hole pitch along Y

// --- derived feature positions (mm) ---
margin = hole_d / 2 + 2;            // = 5.3   clearance from the panel edge
cols = floor((panel[0] - 2 * margin) / pitch_x) + 1;  // = 4   how many columns fit in X
rows = floor((panel[1] - 2 * margin) / pitch_y) + 1;  // = 4   how many rows fit in Y
span_x = (cols - 1) * pitch_x + 0;  // = 60   width of the field
span_y = (rows - 1) * pitch_y;      // = 39.4   height of the field
origin_x = -span_x / 2;             // = -30   X of the first hole
origin_y = -span_y / 2;             // = -19.7   Y of the first row
holes = rows * cols;                // = 16   holes in total
feature_centers = [
  [origin_x + 0 * pitch_x, origin_y + 0 * pitch_y],
  [origin_x + 1 * pitch_x, origin_y + 0 * pitch_y],
  [origin_x + 2 * pitch_x, origin_y + 0 * pitch_y],
  [origin_x + 3 * pitch_x, origin_y + 0 * pitch_y],
  [origin_x + 0 * pitch_x, origin_y + 1 * pitch_y],
  [origin_x + 1 * pitch_x, origin_y + 1 * pitch_y],
  [origin_x + 2 * pitch_x, origin_y + 1 * pitch_y],
  [origin_x + 3 * pitch_x, origin_y + 1 * pitch_y],
  [origin_x + 0 * pitch_x, origin_y + 2 * pitch_y],
  [origin_x + 1 * pitch_x, origin_y + 2 * pitch_y],
  [origin_x + 2 * pitch_x, origin_y + 2 * pitch_y],
  [origin_x + 3 * pitch_x, origin_y + 2 * pitch_y],
  [origin_x + 0 * pitch_x, origin_y + 3 * pitch_y],
  [origin_x + 1 * pitch_x, origin_y + 3 * pitch_y],
  [origin_x + 2 * pitch_x, origin_y + 3 * pitch_y],
  [origin_x + 3 * pitch_x, origin_y + 3 * pitch_y]
];   // hole centres, used verbatim by the cutter loop

// panel outline, every hole through
difference() {
  cube(panel, center = true);
  for (centre = feature_centers)
    translate([centre[0], centre[1], 0])
      cylinder(d = hole_d, h = panel[2] + 2, center = true);
}
