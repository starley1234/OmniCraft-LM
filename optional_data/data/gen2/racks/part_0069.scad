$fn = 32;

// ----------------------------------------------------------------------
// Gear rack: m=2 z=34, 233.63 x 30 x 20 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
rack_len = 233.63;        // rack length, X
rack_w = 30;              // rack width, Y
rack_h = 20;              // overall height, Z
modul = 2;                // module
body_t = 18;              // tooth root line height
pitch = 6.28;             // circular pitch
tip_w = 1.69;             // tooth thickness at the tip
root_w = 4.96;            // tooth thickness at the root line
hole_d = 5.5;             // mounting hole
sink = 0.6;               // tooth root overlap into the body

tooth_span = 213.63;

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
  translate([12, 15, -1]) cylinder(h = body_t + 2, d = hole_d);
  translate([116.81, 15, -1]) cylinder(h = body_t + 2, d = hole_d);
  translate([221.63, 15, -1]) cylinder(h = body_t + 2, d = hole_d);
}
