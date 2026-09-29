$fn = 32;

// ----------------------------------------------------------------------
// L-bracket: 70 x 32 x 50 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
horiz_len = 70;           // horizontal leg, X
vert_len = 50;            // vertical leg, Z
profile_w = 32;           // bracket depth, Y
plate_t = 4;              // plate thickness
hole_d = 9;               // clearance for M8
rib_leg = 24;             // gusset leg
rib_sink = 1.6;           // gusset overlap into the plates

module hole_z(px, py) {
  translate([px, py, -2.5]) cylinder(h = plate_t + 5, d = hole_d);
}
module hole_x(pz, py) {
  translate([-2.5, py, pz]) rotate([0, 90, 0]) cylinder(h = plate_t + 5, d = hole_d);
}
module gusset() {
  translate([0, profile_w - rib_sink, 0])
    rotate([90, 0, 0])
      linear_extrude(height = profile_w - 2 * rib_sink)
        polygon(points = [[rib_sink, rib_sink], [rib_leg, rib_sink], [rib_sink, rib_leg]]);
}

difference() {
  union() {
    /* horizontal leg */
    cube([horiz_len, profile_w, plate_t]);
    /* vertical leg, overlapping the corner block */
    cube([plate_t, profile_w, vert_len]);
    gusset();
  }
  hole_z(35, 16);
  hole_x(25, 16);
}
