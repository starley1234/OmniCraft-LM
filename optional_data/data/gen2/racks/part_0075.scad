$fn = 32;

// ----------------------------------------------------------------------
// Gear rack: m=1.25 z=34, 149.52 x 12 x 15.25 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
rack_len = 149.52;        // rack length, X
rack_w = 12;              // rack width, Y
rack_h = 15.25;           // overall height, Z
modul = 1.25;             // module
body_t = 14;              // tooth root line height
pitch = 3.93;             // circular pitch
tip_w = 1.05;             // tooth thickness at the tip
root_w = 3.1;             // tooth thickness at the root line
hole_d = 5.5;             // mounting hole
sink = 0.6;               // tooth root overlap into the body

tooth_span = 133.52;

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
    for (i = [0 : 34 - 1])
      tooth((i + 0.5) * pitch + (tooth_span - 34 * pitch) / 2);
  }
  translate([10, 6, -1]) cylinder(h = body_t + 2, d = hole_d);
  translate([74.76, 6, -1]) cylinder(h = body_t + 2, d = hole_d);
  translate([139.52, 6, -1]) cylinder(h = body_t + 2, d = hole_d);
}
