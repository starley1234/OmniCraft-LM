$fn = 32;

// ----------------------------------------------------------------------
// Threaded cap: 30 mm body, 30 mm tall, 22 mm threaded bore
// ----------------------------------------------------------------------

// --- parameters (mm) ---
outer_d = 30;             // cap outside diameter
body_h = 30;              // cap height
top_t = 4;                // closed top thickness
bore_d = 22;              // bore core diameter
pitch = 1.5;              // thread pitch
thread_d = 0.9;           // thread depth
thread_z = 3;             // thread start above the rim
thread_h = 20;            // threaded height

difference() {
  union() {
    cylinder(h = 30, d = outer_d);
  }
  /* threaded bore, closed at the top */
  translate([0, 0, -2.5]) cylinder(h = 28.5, d = bore_d);
  translate([0, 0, 3]) rotate_extrude() polygon([[10, 0], [10, 20], [10.5, 20], [11.9, 19.25], [10.5, 18.5], [11.9, 17.75], [10.5, 17], [11.9, 16.25], [10.5, 15.5], [11.9, 14.75], [10.5, 14], [11.9, 13.25], [10.5, 12.5], [11.9, 11.75], [10.5, 11], [11.9, 10.25], [10.5, 9.5], [11.9, 8.75], [10.5, 8], [11.9, 7.25], [10.5, 6.5], [11.9, 5.75], [10.5, 5], [11.9, 4.25], [10.5, 3.5], [11.9, 2.75], [10.5, 0], [10, 0]]);
}
