$fn = 32;

// ----------------------------------------------------------------------
// Gear rack: m=1.5 z=16, 85.4 x 25 x 19.5 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
rack_len = 85.4;          // rack length, X
rack_w = 25;              // rack width, Y
rack_h = 19.5;            // overall height, Z
modul = 1.5;              // module
body_t = 18;              // tooth root line height
pitch = 4.71;             // circular pitch
tip_w = 1.26;             // tooth thickness at the tip
root_w = 3.72;            // tooth thickness at the root line
hole_d = 6.6;             // mounting hole
sink = 0.6;               // tooth root overlap into the body

tooth_span = 75.4;

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
    for (i = [0 : 16 - 1])
      tooth((i + 0.5) * pitch + (tooth_span - 16 * pitch) / 2);
  }
  translate([12, 12.5, -1]) cylinder(h = body_t + 2, d = hole_d);
  translate([73.4, 12.5, -1]) cylinder(h = body_t + 2, d = hole_d);
}
