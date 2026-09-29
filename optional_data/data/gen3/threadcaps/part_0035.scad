$fn = 32;

// ----------------------------------------------------------------------
// Threaded cap: 30 mm body, 22 mm tall, 23 mm threaded bore
// ----------------------------------------------------------------------

// --- parameters (mm) ---
outer_d = 30;             // cap outside diameter
body_h = 22;              // cap height
top_t = 5;                // closed top thickness
bore_d = 23;              // bore core diameter
pitch = 1.75;             // thread pitch
thread_d = 1.05;          // thread depth
thread_z = 3;             // thread start above the rim
thread_h = 11;            // threaded height

difference() {
  union() {
    cylinder(h = 22, d = outer_d);
  }
  /* threaded bore, closed at the top */
  translate([0, 0, -2.5]) cylinder(h = 19.5, d = bore_d);
  translate([0, 0, 3]) rotate_extrude() polygon([[10.5, 0], [10.5, 11], [11, 11], [12.55, 10.125], [11, 9.25], [12.55, 8.375], [11, 7.5], [12.55, 6.625], [11, 5.75], [12.55, 4.875], [11, 4], [12.55, 3.125], [11, 0], [10.5, 0]]);
}
