$fn = 32;

// ----------------------------------------------------------------------
// Hole bar, 4 x Ø6.6
// tworows layout, 12.7 mm edge offset
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_w = 30.6;     // bar width (Y)
bar_t = 5;        // bar thickness (Z)
holes = 4;        // holes per row
hole_d = 6.6;     // hole diameter
edge = 12.7;      // offset from the bar end to the first hole
pitch = 30;       // pitch between neighbouring holes
row_offset = 20;  // distance between the two rows

// --- derived feature positions (mm) ---
span = (holes - 1) * pitch;   // = 90   distance between the end holes
bar_l = span + 2 * edge;      // = 115.4   overall bar length
start_x = -bar_l / 2 + edge;  // = -45   X of the first hole
feature_centers = [
  [start_x + 0 * pitch, -row_offset / 2],
  [start_x + 1 * pitch, -row_offset / 2],
  [start_x + 2 * pitch, -row_offset / 2],
  [start_x + 3 * pitch, -row_offset / 2]
];   // hole centres of the first row
row2_centers = [
  [start_x + 0 * pitch, row_offset / 2],
  [start_x + 1 * pitch, row_offset / 2],
  [start_x + 2 * pitch, row_offset / 2],
  [start_x + 3 * pitch, row_offset / 2]
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
