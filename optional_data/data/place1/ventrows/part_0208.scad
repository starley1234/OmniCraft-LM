$fn = 32;

// ----------------------------------------------------------------------
// Hole bar, 6 x Ø8.4
// tworows layout, 20 mm edge offset
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_w = 32.4;     // bar width (Y)
bar_t = 6;        // bar thickness (Z)
holes = 6;        // holes per row
hole_d = 8.4;     // hole diameter
edge = 20;        // offset from the bar end to the first hole
pitch = 35;       // pitch between neighbouring holes
row_offset = 20;  // distance between the two rows

// --- derived feature positions (mm) ---
span = (holes - 1) * pitch;   // = 175   distance between the end holes
bar_l = span + 2 * edge;      // = 215   overall bar length
start_x = -bar_l / 2 + edge;  // = -87.5   X of the first hole
feature_centers = [
  [start_x + 0 * pitch, -row_offset / 2],
  [start_x + 1 * pitch, -row_offset / 2],
  [start_x + 2 * pitch, -row_offset / 2],
  [start_x + 3 * pitch, -row_offset / 2],
  [start_x + 4 * pitch, -row_offset / 2],
  [start_x + 5 * pitch, -row_offset / 2]
];   // hole centres of the first row
row2_centers = [
  [start_x + 0 * pitch, row_offset / 2],
  [start_x + 1 * pitch, row_offset / 2],
  [start_x + 2 * pitch, row_offset / 2],
  [start_x + 3 * pitch, row_offset / 2],
  [start_x + 4 * pitch, row_offset / 2],
  [start_x + 5 * pitch, row_offset / 2]
];   // hole centres of the second row

// bar with two rows of holes, both read from their own centre arrays
difference() {
  translate([-bar_l / 2, -bar_w / 2, -bar_t / 2]) cube([bar_l, bar_w, bar_t]);
  for (centre = feature_centers)
    translate([centre[0], centre[1], 0])
      cylinder(d = hole_d, h = bar_t + 2, center = true);
  for (centre = row2_centers)
    translate([centre[0], centre[1], 0])
      cylinder(d = hole_d, h = bar_t + 2, center = true);
}
