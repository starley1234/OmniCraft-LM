$fn = 32;

// ----------------------------------------------------------------------
// Threaded cap: 30 mm body, 18 mm tall, 25 mm threaded bore
// ----------------------------------------------------------------------

// --- parameters (mm) ---
outer_d = 30;             // cap outside diameter
body_h = 18;              // cap height
top_t = 4;                // closed top thickness
bore_d = 25;              // bore core diameter
pitch = 1.75;             // thread pitch
thread_d = 1.05;          // thread depth
thread_z = 3;             // thread start above the rim
thread_h = 8;             // threaded height

difference() {
  union() {
    cylinder(h = 18, d = outer_d);
  }
  /* threaded bore, closed at the top */
  translate([0, 0, -2.5]) cylinder(h = 16.5, d = bore_d);
  translate([0, 0, 3]) rotate_extrude() polygon([[11.5, 0], [11.5, 8], [12, 8], [13.55, 7.125], [12, 6.25], [13.55, 5.375], [12, 4.5], [13.55, 3.625], [12, 2.75], [13.55, 1.875], [12, 0], [11.5, 0]]);
}
