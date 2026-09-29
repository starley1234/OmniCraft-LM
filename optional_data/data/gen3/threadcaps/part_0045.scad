$fn = 32;

// ----------------------------------------------------------------------
// Threaded cap: 45 mm body, 26 mm tall, 40 mm threaded bore
// ----------------------------------------------------------------------

// --- parameters (mm) ---
outer_d = 45;             // cap outside diameter
body_h = 26;              // cap height
top_t = 3;                // closed top thickness
bore_d = 40;              // bore core diameter
pitch = 2;                // thread pitch
thread_d = 1.2;           // thread depth
thread_z = 3;             // thread start above the rim
thread_h = 17;            // threaded height

difference() {
  union() {
    cylinder(h = 26, d = outer_d);
  }
  /* threaded bore, closed at the top */
  translate([0, 0, -2.5]) cylinder(h = 25.5, d = bore_d);
  translate([0, 0, 3]) rotate_extrude() polygon([[19, 0], [19, 17], [19.5, 17], [21.2, 16], [19.5, 15], [21.2, 14], [19.5, 13], [21.2, 12], [19.5, 11], [21.2, 10], [19.5, 9], [21.2, 8], [19.5, 7], [21.2, 6], [19.5, 5], [21.2, 4], [19.5, 3], [21.2, 2], [19.5, 0], [19, 0]]);
}
