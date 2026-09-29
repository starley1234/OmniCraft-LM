$fn = 32;

// ----------------------------------------------------------------------
// Gear rack: m=3 z=20, 204.5 x 20 x 19 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
rack_len = 204.5;         // rack length, X
rack_w = 20;              // rack width, Y
rack_h = 19;              // overall height, Z
modul = 3;                // module
body_t = 16;              // tooth root line height
pitch = 9.43;             // circular pitch
tip_w = 2.53;             // tooth thickness at the tip
root_w = 7.44;            // tooth thickness at the root line
sink = 0.6;               // tooth root overlap into the body

tooth_span = 188.5;

module tooth(x0) {
  /* 20 deg flank profile, sunk into the body for a positive overlap */
  translate([x0, 0, body_t - sink])
    linear_extrude(height = rack_h - body_t + sink)
      polygon(points = [[-root_w / 2, 0], [root_w / 2, 0],
                        [tip_w / 2, rack_h - body_t],
                        [-tip_w / 2, rack_h - body_t]]);
}

difference() {
  union() {
    cube([rack_len, rack_w, body_t]);
    for (i = [0 : 20 - 1])
      tooth((i + 0.5) * pitch + (tooth_span - 20 * pitch) / 2);
  }
}
