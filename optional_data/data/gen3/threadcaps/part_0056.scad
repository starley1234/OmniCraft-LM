$fn = 32;

// ----------------------------------------------------------------------
// Threaded cap: 30 mm body, 18 mm tall, 22 mm threaded bore
// ----------------------------------------------------------------------

// --- parameters (mm) ---
outer_d = 30;             // cap outside diameter
body_h = 18;              // cap height
top_t = 5;                // closed top thickness
bore_d = 22;              // bore core diameter
pitch = 2.5;              // thread pitch
thread_d = 1.5;           // thread depth
thread_z = 3;             // thread start above the rim
thread_h = 7;             // threaded height

difference() {
  union() {
    cylinder(h = 18, d = outer_d);
  }
  /* threaded bore, closed at the top */
  translate([0, 0, -2.5]) cylinder(h = 15.5, d = bore_d);
  translate([0, 0, 3]) rotate_extrude() polygon([[10, 0], [10, 7], [10.5, 7], [12.5, 5.75], [10.5, 4.5], [12.5, 3.25], [10.5, 2], [12.5, 0.75], [10.5, 0], [10, 0]]);
}
