$fn = 32;

// ----------------------------------------------------------------------
// Threaded cap: 30 mm body, 22 mm tall, 22 mm threaded bore
// ----------------------------------------------------------------------

// --- parameters (mm) ---
outer_d = 30;             // cap outside diameter
body_h = 22;              // cap height
top_t = 5;                // closed top thickness
bore_d = 22;              // bore core diameter
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
  translate([0, 0, 3]) rotate_extrude() polygon([[10, 0], [10, 11], [10.5, 11], [12.5, 9.75], [10.5, 8.5], [12.5, 7.25], [10.5, 6], [12.5, 4.75], [10.5, 3.5], [12.5, 2.25], [10.5, 0], [10, 0]]);
}
