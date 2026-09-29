$fn = 32;

// ----------------------------------------------------------------------
// L-bracket: 65 x 25 x 60 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
horiz_len = 65;           // horizontal leg, X
vert_len = 60;            // vertical leg, Z
profile_w = 25;           // bracket depth, Y
plate_t = 4.5;            // plate thickness
hole_d = 6.6;             // clearance for M6
rib_leg = 32.4;           // gusset leg
rib_sink = 0.9;           // gusset overlap into the plates

module hole_z(px, py) {
  translate([px, py, -0.5]) cylinder(h = plate_t + 1, d = hole_d);
}
module hole_x(pz, py) {
  translate([-0.5, py, pz]) rotate([0, 90, 0]) cylinder(h = plate_t + 1, d = hole_d);
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
  hole_z(13.2, 12.5);
  hole_z(51.8, 12.5);
  hole_x(13.2, 12.5);
  hole_x(46.8, 12.5);
}
