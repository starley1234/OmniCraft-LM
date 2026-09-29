$fn = 32;

// ----------------------------------------------------------------------
// Gear rack: m=1.25 z=13, 63.05 x 15 x 11.25 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 63.05;           // rack length, X
width = 15;               // rack width, Y
height = 11.25;           // overall height, Z
module_m = 1.25;          // module
back_t = 10;              // tooth root line height
pitch = 3.93;             // circular pitch
tip_w = 1.05;             // tooth thickness at the tip
root_w = 3.1;             // tooth thickness at the root line
hole_d = 4.5;             // mounting hole
sink = 0.6;               // tooth root overlap into the body

tooth_span = 51.05;

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
    for (i = [0 : 13 - 1])
      tooth((i + 0.5) * pitch + (tooth_span - 13 * pitch) / 2);
  }
  translate([10, 7.5, -1]) cylinder(h = back_t + 2, d = hole_d);
  translate([53.05, 7.5, -1]) cylinder(h = back_t + 2, d = hole_d);
}
