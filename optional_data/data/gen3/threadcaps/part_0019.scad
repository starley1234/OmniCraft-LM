$fn = 32;

// ----------------------------------------------------------------------
// Threaded cap: 40 mm body, 26 mm tall, 33 mm threaded bore
// ----------------------------------------------------------------------

// --- parameters (mm) ---
outer_d = 40;             // cap outside diameter
body_h = 26;              // cap height
top_t = 5;                // closed top thickness
bore_d = 33;              // bore core diameter
pitch = 2;                // thread pitch
thread_d = 1.2;           // thread depth
thread_z = 3;             // thread start above the rim
thread_h = 15;            // threaded height

difference() {
  union() {
    cylinder(h = 26, d = outer_d);
  }
  /* threaded bore, closed at the top */
  translate([0, 0, -2.5]) cylinder(h = 23.5, d = bore_d);
  translate([0, 0, 3]) rotate_extrude() polygon([[15.5, 0], [15.5, 15], [16, 15], [17.7, 14], [16, 13], [17.7, 12], [16, 11], [17.7, 10], [16, 9], [17.7, 8], [16, 7], [17.7, 6], [16, 5], [17.7, 4], [16, 3], [17.7, 2], [16, 0], [15.5, 0]]);
}
