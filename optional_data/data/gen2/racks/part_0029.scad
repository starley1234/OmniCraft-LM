$fn = 32;

// ----------------------------------------------------------------------
// Gear rack: m=1.5 z=27, 139.23 x 12 x 13.5 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 139.23;          // rack length, X
width = 12;               // rack width, Y
height = 13.5;            // overall height, Z
module_m = 1.5;           // module
back_t = 12;              // tooth root line height
pitch = 4.71;             // circular pitch
tip_w = 1.26;             // tooth thickness at the tip
root_w = 3.72;            // tooth thickness at the root line
hole_d = 5.5;             // mounting hole
sink = 0.6;               // tooth root overlap into the body

tooth_span = 127.23;

module tooth(x0) {
  /* 20 deg flank profile, sunk into the body for a positive overlap */
  translate([x0, 0, back_t - sink])
    linear_extrude(height = height - back_t + sink)
      polygon(points = [[-root_w / 2, 0], [root_w / 2, 0],
                        [tip_w / 2, height - back_t],
                        [-tip_w / 2, height - back_t]]);
}

difference() {
  union() {
    cube([length, width, back_t]);
    for (i = [0 : 27 - 1])
      tooth((i + 0.5) * pitch + (tooth_span - 27 * pitch) / 2);
  }
  translate([8, 6, -1]) cylinder(h = back_t + 2, d = hole_d);
  translate([49.08, 6, -1]) cylinder(h = back_t + 2, d = hole_d);
  translate([90.15, 6, -1]) cylinder(h = back_t + 2, d = hole_d);
  translate([131.23, 6, -1]) cylinder(h = back_t + 2, d = hole_d);
}
