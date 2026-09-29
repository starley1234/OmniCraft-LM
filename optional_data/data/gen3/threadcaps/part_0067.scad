$fn = 32;

// ----------------------------------------------------------------------
// Threaded cap: 40 mm body, 30 mm tall, 34 mm threaded bore
// ----------------------------------------------------------------------

// --- parameters (mm) ---
outer_d = 40;             // cap outside diameter
body_h = 30;              // cap height
top_t = 3;                // closed top thickness
bore_d = 34;              // bore core diameter
pitch = 2;                // thread pitch
thread_d = 1.2;           // thread depth
thread_z = 3;             // thread start above the rim
thread_h = 21;            // threaded height
flange_d = 50;            // flange diameter
flange_t = 5;             // flange thickness

difference() {
  union() {
    cylinder(h = 5, d = flange_d);
    translate([0, 0, 4.5]) cylinder(h = 30.5, d = outer_d);
  }
  /* threaded bore, closed at the top */
  translate([0, 0, -2.5]) cylinder(h = 34.5, d = bore_d);
  translate([0, 0, 3]) rotate_extrude() polygon([[16, 0], [16, 21], [16.5, 21], [18.2, 20], [16.5, 19], [18.2, 18], [16.5, 17], [18.2, 16], [16.5, 15], [18.2, 14], [16.5, 13], [18.2, 12], [16.5, 11], [18.2, 10], [16.5, 9], [18.2, 8], [16.5, 7], [18.2, 6], [16.5, 5], [18.2, 4], [16.5, 3], [18.2, 2], [16.5, 0], [16, 0]]);
}
