$fn = 32;

// ----------------------------------------------------------------------
// Threaded cap: 40 mm body, 22 mm tall, 34 mm threaded bore
// ----------------------------------------------------------------------

// --- parameters (mm) ---
outer_d = 40;             // cap outside diameter
body_h = 22;              // cap height
top_t = 5;                // closed top thickness
bore_d = 34;              // bore core diameter
pitch = 2.5;              // thread pitch
thread_d = 1.5;           // thread depth
thread_z = 3;             // thread start above the rim
thread_h = 11;            // threaded height

difference() {
  union() {
    cylinder(h = 22, d = outer_d);
  }
  /* threaded bore, closed at the top */
  translate([0, 0, -2.5]) cylinder(h = 19.5, d = bore_d);
  translate([0, 0, 3]) rotate_extrude() polygon([[16, 0], [16, 11], [16.5, 11], [18.5, 9.75], [16.5, 8.5], [18.5, 7.25], [16.5, 6], [18.5, 4.75], [16.5, 3.5], [18.5, 2.25], [16.5, 0], [16, 0]]);
}
