$fn = 32;

// ----------------------------------------------------------------------
// Threaded cap: 45 mm body, 18 mm tall, 37 mm threaded bore
// ----------------------------------------------------------------------

// --- parameters (mm) ---
outer_d = 45;             // cap outside diameter
body_h = 18;              // cap height
top_t = 4;                // closed top thickness
bore_d = 37;              // bore core diameter
pitch = 1.5;              // thread pitch
thread_d = 0.9;           // thread depth
thread_z = 3;             // thread start above the rim
thread_h = 8;             // threaded height

difference() {
  union() {
    cylinder(h = 18, d = outer_d);
  }
  /* threaded bore, closed at the top */
  translate([0, 0, -2.5]) cylinder(h = 16.5, d = bore_d);
  translate([0, 0, 3]) rotate_extrude() polygon([[17.5, 0], [17.5, 8], [18, 8], [19.4, 7.25], [18, 6.5], [19.4, 5.75], [18, 5], [19.4, 4.25], [18, 3.5], [19.4, 2.75], [18, 0], [17.5, 0]]);
}
