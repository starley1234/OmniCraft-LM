$fn = 32;

// ----------------------------------------------------------------------
// Gear rack: m=3 z=25, 245.62 x 15 x 17 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_len = 245.62;         // rack length, X
bar_w = 15;               // rack width, Y
bar_h = 17;               // overall height, Z
gear_module = 3;          // module
base_t = 14;              // tooth root line height
pitch = 9.43;             // circular pitch
tip_w = 2.53;             // tooth thickness at the tip
root_w = 7.44;            // tooth thickness at the root line
hole_d = 4.5;             // mounting hole
sink = 0.6;               // tooth root overlap into the body

tooth_span = 235.62;

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
    for (i = [0 : 25 - 1])
      tooth((i + 0.5) * pitch + (tooth_span - 25 * pitch) / 2);
  }
  translate([12, 7.5, -1]) cylinder(h = base_t + 2, d = hole_d);
  translate([233.62, 7.5, -1]) cylinder(h = base_t + 2, d = hole_d);
}
