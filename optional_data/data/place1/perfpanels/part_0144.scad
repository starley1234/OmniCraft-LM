$fn = 32;

// ----------------------------------------------------------------------
// Perforated panel 180 x 70 x 8
// 4 x 7 Ø8.4 holes, grid layout
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panel = [180, 70, 8];  // overall size (x, y, z)
hole_d = 8.4;          // hole diameter
pitch_x = 25;          // hole pitch along X
pitch_y = 16;          // hole pitch along Y

// --- derived feature positions (mm) ---
margin = hole_d / 2 + 2;            // = 6.2   clearance from the panel edge
cols = floor((panel[0] - 2 * margin) / pitch_x) + 1;  // = 7   how many columns fit in X
rows = floor((panel[1] - 2 * margin) / pitch_y) + 1;  // = 4   how many rows fit in Y
span_x = (cols - 1) * pitch_x + 0;  // = 150   width of the field
span_y = (rows - 1) * pitch_y;      // = 48   height of the field
origin_x = -span_x / 2;             // = -75   X of the first hole
origin_y = -span_y / 2;             // = -24   Y of the first row
holes = rows * cols;                // = 28   holes in total
feature_centers = [
  [origin_x + 0 * pitch_x, origin_y + 0 * pitch_y],
  [origin_x + 1 * pitch_x, origin_y + 0 * pitch_y],
  [origin_x + 2 * pitch_x, origin_y + 0 * pitch_y],
  [origin_x + 3 * pitch_x, origin_y + 0 * pitch_y],
  [origin_x + 4 * pitch_x, origin_y + 0 * pitch_y],
  [origin_x + 5 * pitch_x, origin_y + 0 * pitch_y],
  [origin_x + 6 * pitch_x, origin_y + 0 * pitch_y],
  [origin_x + 0 * pitch_x, origin_y + 1 * pitch_y],
  [origin_x + 1 * pitch_x, origin_y + 1 * pitch_y],
  [origin_x + 2 * pitch_x, origin_y + 1 * pitch_y],
  [origin_x + 3 * pitch_x, origin_y + 1 * pitch_y],
  [origin_x + 4 * pitch_x, origin_y + 1 * pitch_y],
  [origin_x + 5 * pitch_x, origin_y + 1 * pitch_y],
  [origin_x + 6 * pitch_x, origin_y + 1 * pitch_y],
  [origin_x + 0 * pitch_x, origin_y + 2 * pitch_y],
  [origin_x + 1 * pitch_x, origin_y + 2 * pitch_y],
  [origin_x + 2 * pitch_x, origin_y + 2 * pitch_y],
  [origin_x + 3 * pitch_x, origin_y + 2 * pitch_y],
  [origin_x + 4 * pitch_x, origin_y + 2 * pitch_y],
  [origin_x + 5 * pitch_x, origin_y + 2 * pitch_y],
  [origin_x + 6 * pitch_x, origin_y + 2 * pitch_y],
  [origin_x + 0 * pitch_x, origin_y + 3 * pitch_y],
  [origin_x + 1 * pitch_x, origin_y + 3 * pitch_y],
  [origin_x + 2 * pitch_x, origin_y + 3 * pitch_y],
  [origin_x + 3 * pitch_x, origin_y + 3 * pitch_y],
  [origin_x + 4 * pitch_x, origin_y + 3 * pitch_y],
  [origin_x + 5 * pitch_x, origin_y + 3 * pitch_y],
  [origin_x + 6 * pitch_x, origin_y + 3 * pitch_y]
];   // hole centres, used verbatim by the cutter loop

// panel outline, every hole through
difference() {
  cube(panel, center = true);
  for (centre = feature_centers)
    translate([centre[0], centre[1], 0])
      cylinder(d = hole_d, h = panel[2] + 2, center = true);
}
