$fn = 32;

// ----------------------------------------------------------------------
// Gear rack: m=4 z=19, 246.76 x 16 x 14 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
rack_len = 246.76;        // rack length, X
rack_w = 16;              // rack width, Y
rack_h = 14;              // overall height, Z
modul = 4;                // module
body_t = 10;              // tooth root line height
pitch = 12.57;            // circular pitch
tip_w = 3.37;             // tooth thickness at the tip
root_w = 9.92;            // tooth thickness at the root line
hole_d = 5.5;             // mounting hole
sink = 0.6;               // tooth root overlap into the body

tooth_span = 238.76;

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
    for (i = [0 : 19 - 1])
      tooth((i + 0.5) * pitch + (tooth_span - 19 * pitch) / 2);
  }
  translate([12, 8, -1]) cylinder(h = body_t + 2, d = hole_d);
  translate([234.76, 8, -1]) cylinder(h = body_t + 2, d = hole_d);
}
