$fn = 32;

// ----------------------------------------------------------------------
// Gear rack: m=2 z=10, 82.83 x 15 x 16 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_len = 82.83;          // rack length, X
bar_w = 15;               // rack width, Y
bar_h = 16;               // overall height, Z
gear_module = 2;          // module
base_t = 14;              // tooth root line height
pitch = 6.28;             // circular pitch
tip_w = 1.69;             // tooth thickness at the tip
root_w = 4.96;            // tooth thickness at the root line
sink = 0.6;               // tooth root overlap into the body

tooth_span = 62.83;

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
    for (i = [0 : 10 - 1])
      tooth((i + 0.5) * pitch + (tooth_span - 10 * pitch) / 2);
  }
}
