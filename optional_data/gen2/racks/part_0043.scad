$fn = 32;

// ----------------------------------------------------------------------
// Gear rack: m=3 z=13, 142.52 x 30 x 17 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_len = 142.52;         // rack length, X
bar_w = 30;               // rack width, Y
bar_h = 17;               // overall height, Z
gear_module = 3;          // module
base_t = 14;              // tooth root line height
pitch = 9.43;             // circular pitch
tip_w = 2.53;             // tooth thickness at the tip
root_w = 7.44;            // tooth thickness at the root line
hole_d = 5.5;             // mounting hole
sink = 0.6;               // tooth root overlap into the body

tooth_span = 122.52;

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
    for (i = [0 : 13 - 1])
      tooth((i + 0.5) * pitch + (tooth_span - 13 * pitch) / 2);
  }
  translate([10, 15, -1]) cylinder(h = base_t + 2, d = hole_d);
  translate([132.52, 15, -1]) cylinder(h = base_t + 2, d = hole_d);
}
