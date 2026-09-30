$fn = 32;

// ----------------------------------------------------------------------
// Perforated panel 90 x 50 x 10
// 4 x 5 Ø4.5 holes, checker layout
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panel = [90, 50, 10];  // overall size (x, y, z)
hole_d = 4.5;          // hole diameter
pitch_x = 18;          // hole pitch along X
pitch_y = 13.833;      // hole pitch along Y

// --- derived feature positions (mm) ---
margin = hole_d / 2 + 2;            // = 4.25   clearance from the panel edge
row_offset = pitch_x / 2;           // = 9   shift of every other row
cols = floor((panel[0] - 2 * margin - row_offset) / pitch_x) + 1;  // = 5   how many columns fit in X
rows = floor((panel[1] - 2 * margin) / pitch_y) + 1;  // = 4   how many rows fit in Y
span_x = (cols - 1) * pitch_x + row_offset;  // = 81   width of the field
span_y = (rows - 1) * pitch_y;      // = 41.5   height of the field
origin_x = -span_x / 2;             // = -40.5   X of the first hole
origin_y = -span_y / 2;             // = -20.75   Y of the first row
holes = rows * cols;                // = 20   holes in total
feature_centers = [
  [origin_x + 0 * pitch_x, origin_y + 0 * pitch_y],
  [origin_x + 1 * pitch_x, origin_y + 0 * pitch_y],
  [origin_x + 2 * pitch_x, origin_y + 0 * pitch_y],
  [origin_x + 3 * pitch_x, origin_y + 0 * pitch_y],
  [origin_x + 4 * pitch_x, origin_y + 0 * pitch_y],
  [origin_x + row_offset + 0 * pitch_x, origin_y + 1 * pitch_y],
  [origin_x + row_offset + 1 * pitch_x, origin_y + 1 * pitch_y],
  [origin_x + row_offset + 2 * pitch_x, origin_y + 1 * pitch_y],
  [origin_x + row_offset + 3 * pitch_x, origin_y + 1 * pitch_y],
  [origin_x + row_offset + 4 * pitch_x, origin_y + 1 * pitch_y],
  [origin_x + 0 * pitch_x, origin_y + 2 * pitch_y],
  [origin_x + 1 * pitch_x, origin_y + 2 * pitch_y],
  [origin_x + 2 * pitch_x, origin_y + 2 * pitch_y],
  [origin_x + 3 * pitch_x, origin_y + 2 * pitch_y],
  [origin_x + 4 * pitch_x, origin_y + 2 * pitch_y],
  [origin_x + row_offset + 0 * pitch_x, origin_y + 3 * pitch_y],
  [origin_x + row_offset + 1 * pitch_x, origin_y + 3 * pitch_y],
  [origin_x + row_offset + 2 * pitch_x, origin_y + 3 * pitch_y],
  [origin_x + row_offset + 3 * pitch_x, origin_y + 3 * pitch_y],
  [origin_x + row_offset + 4 * pitch_x, origin_y + 3 * pitch_y]
];   // hole centres, used verbatim by the cutter loop

// panel outline, every hole through
difference() {
  cube(panel, center = true);
  for (centre = feature_centers)
    translate([centre[0], centre[1], 0])
      cylinder(d = hole_d, h = panel[2] + 2, center = true);
}
