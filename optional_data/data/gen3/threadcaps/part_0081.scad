$fn = 32;

// ----------------------------------------------------------------------
// Threaded cap: 45 mm body, 22 mm tall, 38 mm threaded bore
// ----------------------------------------------------------------------

// --- parameters (mm) ---
outer_d = 45;             // cap outside diameter
body_h = 22;              // cap height
top_t = 3;                // closed top thickness
bore_d = 38;              // bore core diameter
pitch = 1.5;              // thread pitch
thread_d = 0.9;           // thread depth
thread_z = 3;             // thread start above the rim
thread_h = 13;            // threaded height

difference() {
  union() {
    cylinder(h = 22, d = outer_d);
  }
  /* threaded bore, closed at the top */
  translate([0, 0, -2.5]) cylinder(h = 21.5, d = bore_d);
  translate([0, 0, 3]) rotate_extrude() polygon([[18, 0], [18, 13], [18.5, 13], [19.9, 12.25], [18.5, 11.5], [19.9, 10.75], [18.5, 10], [19.9, 9.25], [18.5, 8.5], [19.9, 7.75], [18.5, 7], [19.9, 6.25], [18.5, 5.5], [19.9, 4.75], [18.5, 4], [19.9, 3.25], [18.5, 2.5], [19.9, 1.75], [18.5, 0], [18, 0]]);
}
