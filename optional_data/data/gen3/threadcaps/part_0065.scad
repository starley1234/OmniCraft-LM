$fn = 32;

// ----------------------------------------------------------------------
// Threaded cap: 50 mm body, 30 mm tall, 42 mm threaded bore
// ----------------------------------------------------------------------

// --- parameters (mm) ---
outer_d = 50;             // cap outside diameter
body_h = 30;              // cap height
top_t = 3;                // closed top thickness
bore_d = 42;              // bore core diameter
pitch = 2.5;              // thread pitch
thread_d = 1.5;           // thread depth
thread_z = 3;             // thread start above the rim
thread_h = 21;            // threaded height

difference() {
  union() {
    cylinder(h = 30, d = outer_d);
  }
  /* threaded bore, closed at the top */
  translate([0, 0, -2.5]) cylinder(h = 29.5, d = bore_d);
  translate([0, 0, 3]) rotate_extrude() polygon([[20, 0], [20, 21], [20.5, 21], [22.5, 19.75], [20.5, 18.5], [22.5, 17.25], [20.5, 16], [22.5, 14.75], [20.5, 13.5], [22.5, 12.25], [20.5, 11], [22.5, 9.75], [20.5, 8.5], [22.5, 7.25], [20.5, 6], [22.5, 4.75], [20.5, 3.5], [22.5, 2.25], [20.5, 0], [20, 0]]);
}
