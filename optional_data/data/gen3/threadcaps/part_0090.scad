$fn = 32;

// ----------------------------------------------------------------------
// Threaded cap: 30 mm body, 22 mm tall, 22 mm threaded bore
// ----------------------------------------------------------------------

// --- parameters (mm) ---
outer_d = 30;             // cap outside diameter
body_h = 22;              // cap height
top_t = 3;                // closed top thickness
bore_d = 22;              // bore core diameter
pitch = 2;                // thread pitch
thread_d = 1.2;           // thread depth
thread_z = 3;             // thread start above the rim
thread_h = 13;            // threaded height

difference() {
  union() {
    cylinder(h = 22, d = outer_d);
  }
  /* threaded bore, closed at the top */
  translate([0, 0, -2.5]) cylinder(h = 21.5, d = bore_d);
  translate([0, 0, 3]) rotate_extrude() polygon([[10, 0], [10, 13], [10.5, 13], [12.2, 12], [10.5, 11], [12.2, 10], [10.5, 9], [12.2, 8], [10.5, 7], [12.2, 6], [10.5, 5], [12.2, 4], [10.5, 3], [12.2, 2], [10.5, 0], [10, 0]]);
}
