$fn = 32;

// ----------------------------------------------------------------------
// Gear rack: m=4 z=16, 217.06 x 25 x 22 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 217.06;          // rack length, X
width = 25;               // rack width, Y
height = 22;              // overall height, Z
module_m = 4;             // module
back_t = 18;              // tooth root line height
pitch = 12.57;            // circular pitch
tip_w = 3.37;             // tooth thickness at the tip
root_w = 9.92;            // tooth thickness at the root line
hole_d = 6.6;             // mounting hole
sink = 0.6;               // tooth root overlap into the body

tooth_span = 201.06;

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
    for (i = [0 : 16 - 1])
      tooth((i + 0.5) * pitch + (tooth_span - 16 * pitch) / 2);
  }
  translate([12, 12.5, -1]) cylinder(h = back_t + 2, d = hole_d);
  translate([76.35, 12.5, -1]) cylinder(h = back_t + 2, d = hole_d);
  translate([140.71, 12.5, -1]) cylinder(h = back_t + 2, d = hole_d);
  translate([205.06, 12.5, -1]) cylinder(h = back_t + 2, d = hole_d);
}
