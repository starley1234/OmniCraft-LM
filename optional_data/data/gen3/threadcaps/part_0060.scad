$fn = 32;

// ----------------------------------------------------------------------
// Threaded cap: 40 mm body, 18 mm tall, 34 mm threaded bore
// ----------------------------------------------------------------------

// --- parameters (mm) ---
outer_d = 40;             // cap outside diameter
body_h = 18;              // cap height
top_t = 4;                // closed top thickness
bore_d = 34;              // bore core diameter
pitch = 2.5;              // thread pitch
thread_d = 1.5;           // thread depth
thread_z = 3;             // thread start above the rim
thread_h = 8;             // threaded height
flange_d = 50;            // flange diameter
flange_t = 4;             // flange thickness

difference() {
  union() {
    cylinder(h = 4, d = flange_d);
    translate([0, 0, 3.5]) cylinder(h = 18.5, d = outer_d);
  }
  /* threaded bore, closed at the top */
  translate([0, 0, -2.5]) cylinder(h = 20.5, d = bore_d);
  translate([0, 0, 3]) rotate_extrude() polygon([[16, 0], [16, 8], [16.5, 8], [18.5, 6.75], [16.5, 5.5], [18.5, 4.25], [16.5, 3], [18.5, 1.75], [16.5, 0], [16, 0]]);
}
