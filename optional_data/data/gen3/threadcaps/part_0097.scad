$fn = 32;

// ----------------------------------------------------------------------
// Threaded cap: 45 mm body, 26 mm tall, 39 mm threaded bore
// ----------------------------------------------------------------------

// --- parameters (mm) ---
outer_d = 45;             // cap outside diameter
body_h = 26;              // cap height
top_t = 4;                // closed top thickness
bore_d = 39;              // bore core diameter
pitch = 1.75;             // thread pitch
thread_d = 1.05;          // thread depth
thread_z = 3;             // thread start above the rim
thread_h = 16;            // threaded height

difference() {
  union() {
    cylinder(h = 26, d = outer_d);
  }
  /* threaded bore, closed at the top */
  translate([0, 0, -2.5]) cylinder(h = 24.5, d = bore_d);
  translate([0, 0, 3]) rotate_extrude() polygon([[18.5, 0], [18.5, 16], [19, 16], [20.55, 15.125], [19, 14.25], [20.55, 13.375], [19, 12.5], [20.55, 11.625], [19, 10.75], [20.55, 9.875], [19, 9], [20.55, 8.125], [19, 7.25], [20.55, 6.375], [19, 5.5], [20.55, 4.625], [19, 3.75], [20.55, 2.875], [19, 0], [18.5, 0]]);
}
