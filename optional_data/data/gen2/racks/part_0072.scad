$fn = 32;

// ----------------------------------------------------------------------
// Gear rack: m=4 z=18, 246.19 x 15 x 24 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_len = 246.19;         // rack length, X
bar_w = 15;               // rack width, Y
bar_h = 24;               // overall height, Z
gear_module = 4;          // module
base_t = 20;              // tooth root line height
pitch = 12.57;            // circular pitch
tip_w = 3.37;             // tooth thickness at the tip
root_w = 9.92;            // tooth thickness at the root line
hole_d = 5.5;             // mounting hole
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
    for (i = [0 : 18 - 1])
      tooth((i + 0.5) * pitch + (tooth_span - 18 * pitch) / 2);
  }
  translate([8, 7.5, -1]) cylinder(h = base_t + 2, d = hole_d);
  translate([123.09, 7.5, -1]) cylinder(h = base_t + 2, d = hole_d);
  translate([238.19, 7.5, -1]) cylinder(h = base_t + 2, d = hole_d);
}
