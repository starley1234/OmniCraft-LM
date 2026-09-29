$fn = 32;

// ----------------------------------------------------------------------
// Threaded cap: 30 mm body, 18 mm tall, 24 mm threaded bore
// ----------------------------------------------------------------------

// --- parameters (mm) ---
outer_d = 30;             // cap outside diameter
body_h = 18;              // cap height
top_t = 4;                // closed top thickness
bore_d = 24;              // bore core diameter
pitch = 2;                // thread pitch
thread_d = 1.2;           // thread depth
thread_z = 3;             // thread start above the rim
thread_h = 8;             // threaded height

difference() {
  union() {
    cylinder(h = 18, d = outer_d);
  }
  /* threaded bore, closed at the top */
  translate([0, 0, -2.5]) cylinder(h = 16.5, d = bore_d);
  translate([0, 0, 3]) rotate_extrude() polygon([[11, 0], [11, 8], [11.5, 8], [13.2, 7], [11.5, 6], [13.2, 5], [11.5, 4], [13.2, 3], [11.5, 0], [11, 0]]);
}
