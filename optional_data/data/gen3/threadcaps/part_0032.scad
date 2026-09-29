$fn = 32;

// ----------------------------------------------------------------------
// Threaded cap: 50 mm body, 26 mm tall, 45 mm threaded bore
// ----------------------------------------------------------------------

// --- parameters (mm) ---
outer_d = 50;             // cap outside diameter
body_h = 26;              // cap height
top_t = 4;                // closed top thickness
bore_d = 45;              // bore core diameter
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
  translate([0, 0, 3]) rotate_extrude() polygon([[21.5, 0], [21.5, 16], [22, 16], [23.55, 15.125], [22, 14.25], [23.55, 13.375], [22, 12.5], [23.55, 11.625], [22, 10.75], [23.55, 9.875], [22, 9], [23.55, 8.125], [22, 7.25], [23.55, 6.375], [22, 5.5], [23.55, 4.625], [22, 3.75], [23.55, 2.875], [22, 0], [21.5, 0]]);
}
