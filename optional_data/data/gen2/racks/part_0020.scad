$fn = 32;

// ----------------------------------------------------------------------
// Gear rack: m=2 z=11, 89.12 x 25 x 14 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 89.12;           // rack length, X
width = 25;               // rack width, Y
height = 14;              // overall height, Z
module_m = 2;             // module
back_t = 12;              // tooth root line height
pitch = 6.28;             // circular pitch
tip_w = 1.69;             // tooth thickness at the tip
root_w = 4.96;            // tooth thickness at the root line
hole_d = 6.6;             // mounting hole
sink = 0.6;               // tooth root overlap into the body

tooth_span = 69.11;

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
    for (i = [0 : 11 - 1])
      tooth((i + 0.5) * pitch + (tooth_span - 11 * pitch) / 2);
  }
  translate([12, 12.5, -1]) cylinder(h = back_t + 2, d = hole_d);
  translate([44.56, 12.5, -1]) cylinder(h = back_t + 2, d = hole_d);
  translate([77.12, 12.5, -1]) cylinder(h = back_t + 2, d = hole_d);
}
