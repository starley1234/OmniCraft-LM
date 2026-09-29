$fn = 32;

// ----------------------------------------------------------------------
// Gear rack: m=3 z=24, 242.19 x 12 x 19 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
rack_len = 242.19;        // rack length, X
rack_w = 12;              // rack width, Y
rack_h = 19;              // overall height, Z
modul = 3;                // module
body_t = 16;              // tooth root line height
pitch = 9.43;             // circular pitch
tip_w = 2.53;             // tooth thickness at the tip
root_w = 7.44;            // tooth thickness at the root line
hole_d = 4.5;             // mounting hole
sink = 0.6;               // tooth root overlap into the body

tooth_span = 226.19;

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
    for (i = [0 : 24 - 1])
      tooth((i + 0.5) * pitch + (tooth_span - 24 * pitch) / 2);
  }
  translate([12, 6, -1]) cylinder(h = body_t + 2, d = hole_d);
  translate([121.09, 6, -1]) cylinder(h = body_t + 2, d = hole_d);
  translate([230.19, 6, -1]) cylinder(h = body_t + 2, d = hole_d);
}
