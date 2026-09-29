$fn = 32;

// ----------------------------------------------------------------------
// Gear rack: m=4 z=11, 146.23 x 12 x 20 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 146.23;          // rack length, X
width = 12;               // rack width, Y
height = 20;              // overall height, Z
module_m = 4;             // module
back_t = 16;              // tooth root line height
pitch = 12.57;            // circular pitch
tip_w = 3.37;             // tooth thickness at the tip
root_w = 9.92;            // tooth thickness at the root line
hole_d = 4.5;             // mounting hole
sink = 0.6;               // tooth root overlap into the body

tooth_span = 138.23;

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
  translate([8, 6, -1]) cylinder(h = back_t + 2, d = hole_d);
  translate([51.41, 6, -1]) cylinder(h = back_t + 2, d = hole_d);
  translate([94.82, 6, -1]) cylinder(h = back_t + 2, d = hole_d);
  translate([138.23, 6, -1]) cylinder(h = back_t + 2, d = hole_d);
}
