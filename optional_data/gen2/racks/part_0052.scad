$fn = 32;

// ----------------------------------------------------------------------
// Gear rack: m=3 z=24, 246.19 x 30 x 17 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 246.19;          // rack length, X
width = 30;               // rack width, Y
height = 17;              // overall height, Z
module_m = 3;             // module
back_t = 14;              // tooth root line height
pitch = 9.43;             // circular pitch
tip_w = 2.53;             // tooth thickness at the tip
root_w = 7.44;            // tooth thickness at the root line
hole_d = 5.5;             // mounting hole
sink = 0.6;               // tooth root overlap into the body

tooth_span = 226.19;

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
    for (i = [0 : 24 - 1])
      tooth((i + 0.5) * pitch + (tooth_span - 24 * pitch) / 2);
  }
  translate([8, 15, -1]) cylinder(h = back_t + 2, d = hole_d);
  translate([238.19, 15, -1]) cylinder(h = back_t + 2, d = hole_d);
}
