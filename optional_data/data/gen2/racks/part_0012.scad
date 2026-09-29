$fn = 32;

// ----------------------------------------------------------------------
// Gear rack: m=2.5 z=24, 198.5 x 12 x 16.5 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_len = 198.5;          // rack length, X
bar_w = 12;               // rack width, Y
bar_h = 16.5;             // overall height, Z
gear_module = 2.5;        // module
base_t = 14;              // tooth root line height
pitch = 7.85;             // circular pitch
tip_w = 2.11;             // tooth thickness at the tip
root_w = 6.2;             // tooth thickness at the root line
sink = 0.6;               // tooth root overlap into the body

tooth_span = 188.5;

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
}
