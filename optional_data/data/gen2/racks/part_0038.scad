$fn = 32;

// ----------------------------------------------------------------------
// Gear rack: m=4 z=18, 242.19 x 25 x 24 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
rack_len = 242.19;        // rack length, X
rack_w = 25;              // rack width, Y
rack_h = 24;              // overall height, Z
modul = 4;                // module
body_t = 20;              // tooth root line height
pitch = 12.57;            // circular pitch
tip_w = 3.37;             // tooth thickness at the tip
root_w = 9.92;            // tooth thickness at the root line
hole_d = 5.5;             // mounting hole
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
    for (i = [0 : 18 - 1])
      tooth((i + 0.5) * pitch + (tooth_span - 18 * pitch) / 2);
  }
  translate([12, 12.5, -1]) cylinder(h = body_t + 2, d = hole_d);
  translate([121.09, 12.5, -1]) cylinder(h = body_t + 2, d = hole_d);
  translate([230.19, 12.5, -1]) cylinder(h = body_t + 2, d = hole_d);
}
