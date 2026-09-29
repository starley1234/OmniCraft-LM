$fn = 32;

// ----------------------------------------------------------------------
// L-bracket: 55 x 24 x 70 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
horiz_len = 55;           // horizontal leg, X
vert_len = 70;            // vertical leg, Z
profile_w = 24;           // bracket depth, Y
plate_t = 5;              // plate thickness
hole_d = 6.6;             // clearance for M6
cb_d = 11;                // counterbore seat
cb_h = 3.2;               // counterbore depth
rib_leg = 24.8;           // gusset leg
rib_sink = 0.9;           // gusset overlap into the plates

module hole_z(px, py) {
  translate([px, py, -0.5]) cylinder(h = plate_t + 1, d = hole_d);
}
module hole_x(pz, py) {
  translate([-0.5, py, pz]) rotate([0, 90, 0]) cylinder(h = plate_t + 1, d = hole_d);
}
module cb_z(px, py) {
  translate([px, py, plate_t - cb_h]) cylinder(h = cb_h + 0.4, d = cb_d);
}
module cb_x(pz, py) {
  translate([plate_t - cb_h, py, pz]) rotate([0, -90, 0]) cylinder(h = cb_h + 0.4, d = cb_d);
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
  hole_z(13.2, 12);
  cb_z(13.2, 12);
  hole_z(41.8, 12);
  cb_z(41.8, 12);
  hole_x(13.2, 12);
  cb_x(13.2, 12);
  hole_x(56.8, 12);
  cb_x(56.8, 12);
}
