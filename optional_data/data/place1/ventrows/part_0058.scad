$fn = 32;

// ----------------------------------------------------------------------
// Hole bar, 6 x Ø5.5
// row layout, 9.525 mm edge offset
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_w = 20;    // bar width (Y)
bar_t = 5;     // bar thickness (Z)
holes = 6;     // holes per row
hole_d = 5.5;  // hole diameter
edge = 9.525;  // offset from the bar end to the first hole
pitch = 20;    // pitch between neighbouring holes

// --- derived feature positions (mm) ---
span = (holes - 1) * pitch;   // = 100   distance between the end holes
bar_l = span + 2 * edge;      // = 119.05   overall bar length
start_x = -bar_l / 2 + edge;  // = -50   X of the first hole
feature_centers = [
  [start_x + 0 * pitch, 0],
  [start_x + 1 * pitch, 0],
  [start_x + 2 * pitch, 0],
  [start_x + 3 * pitch, 0],
  [start_x + 4 * pitch, 0],
  [start_x + 5 * pitch, 0]
];   // hole centres of the first row

// bar with one row of holes, drilled from feature_centers
difference() {
  translate([-bar_l / 2, -bar_w / 2, -bar_t / 2]) cube([bar_l, bar_w, bar_t]);
  for (centre = feature_centers)
    translate([centre[0], centre[1], 0])
      cylinder(d = hole_d, h = bar_t + 2, center = true);
}
