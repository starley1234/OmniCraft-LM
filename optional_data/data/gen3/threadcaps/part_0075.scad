$fn = 32;

// ----------------------------------------------------------------------
// Threaded cap: 50 mm body, 22 mm tall, 45 mm threaded bore
// ----------------------------------------------------------------------

// --- parameters (mm) ---
outer_d = 50;             // cap outside diameter
body_h = 22;              // cap height
top_t = 5;                // closed top thickness
bore_d = 45;              // bore core diameter
pitch = 2;                // thread pitch
thread_d = 1.2;           // thread depth
thread_z = 3;             // thread start above the rim
thread_h = 11;            // threaded height

difference() {
  union() {
    cylinder(h = 22, d = outer_d);
  }
  /* threaded bore, closed at the top */
  translate([0, 0, -2.5]) cylinder(h = 19.5, d = bore_d);
  translate([0, 0, 3]) rotate_extrude() polygon([[21.5, 0], [21.5, 11], [22, 11], [23.7, 10], [22, 9], [23.7, 8], [22, 7], [23.7, 6], [22, 5], [23.7, 4], [22, 3], [23.7, 2], [22, 0], [21.5, 0]]);
}
