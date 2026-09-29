$fn = 32;

// ----------------------------------------------------------------------
// Threaded cap: 50 mm body, 30 mm tall, 42 mm threaded bore
// ----------------------------------------------------------------------

// --- parameters (mm) ---
outer_d = 50;             // cap outside diameter
body_h = 30;              // cap height
top_t = 4;                // closed top thickness
bore_d = 42;              // bore core diameter
pitch = 1.5;              // thread pitch
thread_d = 0.9;           // thread depth
thread_z = 3;             // thread start above the rim
thread_h = 20;            // threaded height

difference() {
  union() {
    cylinder(h = 30, d = outer_d);
  }
  /* threaded bore, closed at the top */
  translate([0, 0, -2.5]) cylinder(h = 28.5, d = bore_d);
  translate([0, 0, 3]) rotate_extrude() polygon([[20, 0], [20, 20], [20.5, 20], [21.9, 19.25], [20.5, 18.5], [21.9, 17.75], [20.5, 17], [21.9, 16.25], [20.5, 15.5], [21.9, 14.75], [20.5, 14], [21.9, 13.25], [20.5, 12.5], [21.9, 11.75], [20.5, 11], [21.9, 10.25], [20.5, 9.5], [21.9, 8.75], [20.5, 8], [21.9, 7.25], [20.5, 6.5], [21.9, 5.75], [20.5, 5], [21.9, 4.25], [20.5, 3.5], [21.9, 2.75], [20.5, 0], [20, 0]]);
}
