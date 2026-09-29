$fn = 32;

// ----------------------------------------------------------------------
// Threaded cap: 40 mm body, 30 mm tall, 33 mm threaded bore
// ----------------------------------------------------------------------

// --- parameters (mm) ---
outer_d = 40;             // cap outside diameter
body_h = 30;              // cap height
top_t = 4;                // closed top thickness
bore_d = 33;              // bore core diameter
pitch = 2.5;              // thread pitch
thread_d = 1.5;           // thread depth
thread_z = 3;             // thread start above the rim
thread_h = 20;            // threaded height

difference() {
  union() {
    cylinder(h = 30, d = outer_d);
  }
  /* threaded bore, closed at the top */
  translate([0, 0, -2.5]) cylinder(h = 28.5, d = bore_d);
  translate([0, 0, 3]) rotate_extrude() polygon([[15.5, 0], [15.5, 20], [16, 20], [18, 18.75], [16, 17.5], [18, 16.25], [16, 15], [18, 13.75], [16, 12.5], [18, 11.25], [16, 10], [18, 8.75], [16, 7.5], [18, 6.25], [16, 5], [18, 3.75], [16, 0], [15.5, 0]]);
}
