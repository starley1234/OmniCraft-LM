$fn = 32;

// ----------------------------------------------------------------------
// Gear rack: m=3 z=24, 242.19 x 16 x 13 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_len = 242.19;         // rack length, X
bar_w = 16;               // rack width, Y
bar_h = 13;               // overall height, Z
gear_module = 3;          // module
base_t = 10;              // tooth root line height
pitch = 9.43;             // circular pitch
tip_w = 2.53;             // tooth thickness at the tip
root_w = 7.44;            // tooth thickness at the root line
hole_d = 4.5;             // mounting hole
sink = 0.6;               // tooth root overlap into the body

tooth_span = 226.19;

module tooth(x0) {
  /* 20 deg flank profile, sunk into the body for a positive overlap */
  translate([x0, 0, base_t - sink])
    linear_extrude(height = bar_h - base_t + sink)
      polygon(points = [[-root_w / 2, 0], [root_w / 2, 0],
                        [tip_w / 2, bar_h - base_t],
                        [-tip_w / 2, bar_h - base_t]]);
}

difference() {
  union() {
    cube([bar_len, bar_w, base_t]);
    for (i = [0 : 24 - 1])
      tooth((i + 0.5) * pitch + (tooth_span - 24 * pitch) / 2);
  }
  translate([10, 8, -1]) cylinder(h = base_t + 2, d = hole_d);
  translate([121.09, 8, -1]) cylinder(h = base_t + 2, d = hole_d);
  translate([232.19, 8, -1]) cylinder(h = base_t + 2, d = hole_d);
}
