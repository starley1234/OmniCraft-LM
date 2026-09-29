$fn = 32;

// ----------------------------------------------------------------------
// Threaded cap: 50 mm body, 26 mm tall, 44 mm threaded bore
// ----------------------------------------------------------------------

// --- parameters (mm) ---
outer_d = 50;             // cap outside diameter
body_h = 26;              // cap height
top_t = 3;                // closed top thickness
bore_d = 44;              // bore core diameter
pitch = 2.5;              // thread pitch
thread_d = 1.5;           // thread depth
thread_z = 3;             // thread start above the rim
thread_h = 17;            // threaded height

difference() {
  union() {
    cylinder(h = 26, d = outer_d);
  }
  /* threaded bore, closed at the top */
  translate([0, 0, -2.5]) cylinder(h = 25.5, d = bore_d);
  translate([0, 0, 3]) rotate_extrude() polygon([[21, 0], [21, 17], [21.5, 17], [23.5, 15.75], [21.5, 14.5], [23.5, 13.25], [21.5, 12], [23.5, 10.75], [21.5, 9.5], [23.5, 8.25], [21.5, 7], [23.5, 5.75], [21.5, 4.5], [23.5, 3.25], [21.5, 0], [21, 0]]);
}
