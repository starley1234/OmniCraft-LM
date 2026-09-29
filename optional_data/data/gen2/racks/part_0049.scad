$fn = 32;

// ----------------------------------------------------------------------
// Gear rack: m=1.5 z=12, 68.55 x 15 x 17.5 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_len = 68.55;          // rack length, X
bar_w = 15;               // rack width, Y
bar_h = 17.5;             // overall height, Z
gear_module = 1.5;        // module
base_t = 16;              // tooth root line height
pitch = 4.71;             // circular pitch
tip_w = 1.26;             // tooth thickness at the tip
root_w = 3.72;            // tooth thickness at the root line
sink = 0.6;               // tooth root overlap into the body

tooth_span = 56.55;

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
    for (i = [0 : 12 - 1])
      tooth((i + 0.5) * pitch + (tooth_span - 12 * pitch) / 2);
  }
}
