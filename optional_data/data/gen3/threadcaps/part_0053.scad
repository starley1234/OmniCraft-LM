$fn = 32;

// ----------------------------------------------------------------------
// Threaded cap: 30 mm body, 30 mm tall, 24 mm threaded bore
// ----------------------------------------------------------------------

// --- parameters (mm) ---
outer_d = 30;             // cap outside diameter
body_h = 30;              // cap height
top_t = 3;                // closed top thickness
bore_d = 24;              // bore core diameter
pitch = 1.75;             // thread pitch
thread_d = 1.05;          // thread depth
thread_z = 3;             // thread start above the rim
thread_h = 21;            // threaded height
flange_d = 40;            // flange diameter
flange_t = 4;             // flange thickness

difference() {
  union() {
    cylinder(h = 4, d = flange_d);
    translate([0, 0, 3.5]) cylinder(h = 30.5, d = outer_d);
  }
  /* threaded bore, closed at the top */
  translate([0, 0, -2.5]) cylinder(h = 33.5, d = bore_d);
  translate([0, 0, 3]) rotate_extrude() polygon([[11, 0], [11, 21], [11.5, 21], [13.05, 20.125], [11.5, 19.25], [13.05, 18.375], [11.5, 17.5], [13.05, 16.625], [11.5, 15.75], [13.05, 14.875], [11.5, 14], [13.05, 13.125], [11.5, 12.25], [13.05, 11.375], [11.5, 10.5], [13.05, 9.625], [11.5, 8.75], [13.05, 7.875], [11.5, 7], [13.05, 6.125], [11.5, 5.25], [13.05, 4.375], [11.5, 3.5], [13.05, 2.625], [11.5, 0], [11, 0]]);
}
