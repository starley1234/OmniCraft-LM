$fn = 32;

// ----------------------------------------------------------------------
// Threaded cap: 40 mm body, 30 mm tall, 34 mm threaded bore
// ----------------------------------------------------------------------

// --- parameters (mm) ---
outer_d = 40;             // cap outside diameter
body_h = 30;              // cap height
top_t = 5;                // closed top thickness
bore_d = 34;              // bore core diameter
pitch = 2.5;              // thread pitch
thread_d = 1.5;           // thread depth
thread_z = 3;             // thread start above the rim
thread_h = 19;            // threaded height

difference() {
  union() {
    cylinder(h = 30, d = outer_d);
  }
  /* threaded bore, closed at the top */
  translate([0, 0, -2.5]) cylinder(h = 27.5, d = bore_d);
  translate([0, 0, 3]) rotate_extrude() polygon([[16, 0], [16, 19], [16.5, 19], [18.5, 17.75], [16.5, 16.5], [18.5, 15.25], [16.5, 14], [18.5, 12.75], [16.5, 11.5], [18.5, 10.25], [16.5, 9], [18.5, 7.75], [16.5, 6.5], [18.5, 5.25], [16.5, 4], [18.5, 2.75], [16.5, 0], [16, 0]]);
}
