$fn = 32;

// ----------------------------------------------------------------------
// Gear rack: m=1 z=29, 103.11 x 20 x 21 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 103.11;          // rack length, X
width = 20;               // rack width, Y
height = 21;              // overall height, Z
module_m = 1;             // module
back_t = 20;              // tooth root line height
pitch = 3.14;             // circular pitch
tip_w = 0.84;             // tooth thickness at the tip
root_w = 2.48;            // tooth thickness at the root line
hole_d = 5.5;             // mounting hole
sink = 0.6;               // tooth root overlap into the body

tooth_span = 91.11;

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
    for (i = [0 : 29 - 1])
      tooth((i + 0.5) * pitch + (tooth_span - 29 * pitch) / 2);
  }
  translate([12, 10, -1]) cylinder(h = back_t + 2, d = hole_d);
  translate([91.11, 10, -1]) cylinder(h = back_t + 2, d = hole_d);
}
