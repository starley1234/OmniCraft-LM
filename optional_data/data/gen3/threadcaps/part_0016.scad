$fn = 32;

// ----------------------------------------------------------------------
// Threaded cap: 36 mm body, 26 mm tall, 29 mm threaded bore
// ----------------------------------------------------------------------

// --- parameters (mm) ---
outer_d = 36;             // cap outside diameter
body_h = 26;              // cap height
top_t = 4;                // closed top thickness
bore_d = 29;              // bore core diameter
pitch = 2.5;              // thread pitch
thread_d = 1.5;           // thread depth
thread_z = 3;             // thread start above the rim
thread_h = 16;            // threaded height

difference() {
  union() {
    cylinder(h = 26, d = outer_d);
  }
  /* threaded bore, closed at the top */
  translate([0, 0, -2.5]) cylinder(h = 24.5, d = bore_d);
  translate([0, 0, 3]) rotate_extrude() polygon([[13.5, 0], [13.5, 16], [14, 16], [16, 14.75], [14, 13.5], [16, 12.25], [14, 11], [16, 9.75], [14, 8.5], [16, 7.25], [14, 6], [16, 4.75], [14, 3.5], [16, 2.25], [14, 0], [13.5, 0]]);
}
