$fn = 32;

// ----------------------------------------------------------------------
// Z-bracket: 45 x 35 x 25 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
foot_len = 45;            // lower foot length, X
top_len = 25;             // upper foot length, X
depth = 35;               // bracket width, Y
step_h = 25;              // overall rise, Z
plate_t = 6;              // plate thickness
hole_d = 3.4;             // clearance for M3
rib_len = 8.8;            // gusset leg
rib_sink = 0.9;           // gusset overlap into the plates

module hole_z(px, py, z0) {
  translate([px, py, z0 - 0.5]) cylinder(h = plate_t + 1, d = hole_d);
}
module hole_x(py, pz) {
  translate([-0.5, py, pz]) rotate([0, 90, 0]) cylinder(h = plate_t + 1, d = hole_d);
}
module gusset(x0) {
  translate([x0, depth - rib_sink, 0])
    rotate([90, 0, 0])
      linear_extrude(height = depth - 2 * rib_sink)
        polygon(points = [[rib_sink, plate_t - rib_sink],
                          [rib_sink, plate_t - rib_sink + rib_len],
                          [-rib_len, plate_t - rib_sink]]);
}

difference() {
  union() {
    cube([foot_len, depth, plate_t]);
    /* web, overlapping the lower foot */
    translate([foot_len - plate_t, 0, 0]) cube([plate_t, depth, step_h]);
    /* upper foot, sunk into the web */
    translate([foot_len - plate_t - top_len, 0, step_h - plate_t]) cube([top_len + plate_t, depth, plate_t]);
    gusset(foot_len - plate_t);
  }
  hole_z(6.8, 17.5, 0);
  translate([foot_len - plate_t - 15, 0, 0]) hole_z(0, 17.5, step_h - plate_t);
  translate([foot_len - plate_t, 0, 0]) hole_x(17.5, 6.8);
}
