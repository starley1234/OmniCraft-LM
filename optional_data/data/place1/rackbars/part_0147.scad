$fn = 32;

// ----------------------------------------------------------------------
// Toothed rack, 10 teeth
// 15 mm pitch, 6 mm teeth
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_w = 16;      // bar width (Y)
bar_h = 12;      // bar height (Z)
teeth = 10;      // number of teeth
pitch = 15;      // tooth pitch
tooth_h = 6;     // tooth height above the bar
root_w = 12;     // tooth width at the root
crest_w = 5.25;  // tooth width at the crest

// --- derived feature positions (mm) ---
span = (teeth - 1) * pitch;  // = 135   distance between the outer teeth
bar_l = span + root_w + 8;   // = 155   bar length: teeth plus 4 mm at each end
tooth_x = -span / 2;         // = -67.5   X of the first tooth
height = bar_h + tooth_h;    // = 18   overall height
feature_centers = [
  [tooth_x + 0 * pitch, -bar_w / 2],
  [tooth_x + 1 * pitch, -bar_w / 2],
  [tooth_x + 2 * pitch, -bar_w / 2],
  [tooth_x + 3 * pitch, -bar_w / 2],
  [tooth_x + 4 * pitch, -bar_w / 2],
  [tooth_x + 5 * pitch, -bar_w / 2],
  [tooth_x + 6 * pitch, -bar_w / 2],
  [tooth_x + 7 * pitch, -bar_w / 2],
  [tooth_x + 8 * pitch, -bar_w / 2],
  [tooth_x + 9 * pitch, -bar_w / 2]
];   // tooth centre line, drives the tooth loop

// bar with a rack of teeth, one extruded trapezoium per centre
module rack_tooth() {
  linear_extrude(height = bar_w)
    polygon(points = [
      [0, 0],
      [root_w, 0],
      [root_w / 2 + crest_w / 2, tooth_h + 1],
      [root_w / 2 - crest_w / 2, tooth_h + 1]
    ]);
}

union() {
  translate([-bar_l / 2, -bar_w, 0]) cube([bar_l, bar_w, bar_h]);
  for (centre = feature_centers)
    translate([centre[0] - root_w / 2, 0, bar_h - 1]) rotate([90, 0, 0]) rack_tooth();
}
