$fn = 32;

// ----------------------------------------------------------------------
// Threaded cap: 50 mm body, 18 mm tall, 42 mm threaded bore
// ----------------------------------------------------------------------

// --- parameters (mm) ---
outer_d = 50;             // cap outside diameter
body_h = 18;              // cap height
top_t = 5;                // closed top thickness
bore_d = 42;              // bore core diameter
pitch = 1.75;             // thread pitch
thread_d = 1.05;          // thread depth
thread_z = 3;             // thread start above the rim
thread_h = 7;             // threaded height

difference() {
  union() {
    cylinder(h = 18, d = outer_d);
  }
  /* threaded bore, closed at the top */
  translate([0, 0, -2.5]) cylinder(h = 15.5, d = bore_d);
  translate([0, 0, 3]) rotate_extrude() polygon([[20, 0], [20, 7], [20.5, 7], [22.05, 6.125], [20.5, 5.25], [22.05, 4.375], [20.5, 3.5], [22.05, 2.625], [20.5, 0], [20, 0]]);
}
