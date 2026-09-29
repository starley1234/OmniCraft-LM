$fn = 32;

// ----------------------------------------------------------------------
// Threaded cap: 45 mm body, 18 mm tall, 38 mm threaded bore
// ----------------------------------------------------------------------

// --- parameters (mm) ---
outer_d = 45;             // cap outside diameter
body_h = 18;              // cap height
top_t = 3;                // closed top thickness
bore_d = 38;              // bore core diameter
pitch = 2.5;              // thread pitch
thread_d = 1.5;           // thread depth
thread_z = 3;             // thread start above the rim
thread_h = 9;             // threaded height

difference() {
  union() {
    cylinder(h = 18, d = outer_d);
  }
  /* threaded bore, closed at the top */
  translate([0, 0, -2.5]) cylinder(h = 17.5, d = bore_d);
  translate([0, 0, 3]) rotate_extrude() polygon([[18, 0], [18, 9], [18.5, 9], [20.5, 7.75], [18.5, 6.5], [20.5, 5.25], [18.5, 4], [20.5, 2.75], [18.5, 0], [18, 0]]);
}
