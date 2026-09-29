$fn = 32;

// ----------------------------------------------------------------------
// Gear rack: m=2.5 z=25, 208.35 x 16 x 14.5 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 208.35;          // rack length, X
width = 16;               // rack width, Y
height = 14.5;            // overall height, Z
module_m = 2.5;           // module
back_t = 12;              // tooth root line height
pitch = 7.85;             // circular pitch
tip_w = 2.11;             // tooth thickness at the tip
root_w = 6.2;             // tooth thickness at the root line
hole_d = 4.5;             // mounting hole
sink = 0.6;               // tooth root overlap into the body

tooth_span = 196.35;

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
    for (i = [0 : 25 - 1])
      tooth((i + 0.5) * pitch + (tooth_span - 25 * pitch) / 2);
  }
  translate([8, 8, -1]) cylinder(h = back_t + 2, d = hole_d);
  translate([200.35, 8, -1]) cylinder(h = back_t + 2, d = hole_d);
}
