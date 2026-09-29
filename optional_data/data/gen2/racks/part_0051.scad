$fn = 32;

// ----------------------------------------------------------------------
// Gear rack: m=1.5 z=15, 78.69 x 30 x 11.5 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
rack_len = 78.69;         // rack length, X
rack_w = 30;              // rack width, Y
rack_h = 11.5;            // overall height, Z
modul = 1.5;              // module
body_t = 10;              // tooth root line height
pitch = 4.71;             // circular pitch
tip_w = 1.26;             // tooth thickness at the tip
root_w = 3.72;            // tooth thickness at the root line
hole_d = 4.5;             // mounting hole
sink = 0.6;               // tooth root overlap into the body

tooth_span = 70.69;

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
    for (i = [0 : 15 - 1])
      tooth((i + 0.5) * pitch + (tooth_span - 15 * pitch) / 2);
  }
  translate([12, 15, -1]) cylinder(h = body_t + 2, d = hole_d);
  translate([39.34, 15, -1]) cylinder(h = body_t + 2, d = hole_d);
  translate([66.69, 15, -1]) cylinder(h = body_t + 2, d = hole_d);
}
