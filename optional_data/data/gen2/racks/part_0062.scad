$fn = 32;

// ----------------------------------------------------------------------
// Gear rack: m=1.25 z=31, 141.74 x 30 x 11.25 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_len = 141.74;         // rack length, X
bar_w = 30;               // rack width, Y
bar_h = 11.25;            // overall height, Z
gear_module = 1.25;       // module
base_t = 10;              // tooth root line height
pitch = 3.93;             // circular pitch
tip_w = 1.05;             // tooth thickness at the tip
root_w = 3.1;             // tooth thickness at the root line
hole_d = 5.5;             // mounting hole
sink = 0.6;               // tooth root overlap into the body

tooth_span = 121.74;

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
    for (i = [0 : 31 - 1])
      tooth((i + 0.5) * pitch + (tooth_span - 31 * pitch) / 2);
  }
  translate([12, 15, -1]) cylinder(h = base_t + 2, d = hole_d);
  translate([70.87, 15, -1]) cylinder(h = base_t + 2, d = hole_d);
  translate([129.74, 15, -1]) cylinder(h = base_t + 2, d = hole_d);
}
