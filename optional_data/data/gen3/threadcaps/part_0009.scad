$fn = 32;

// ----------------------------------------------------------------------
// Threaded cap: 30 mm body, 26 mm tall, 25 mm threaded bore
// ----------------------------------------------------------------------

// --- parameters (mm) ---
outer_d = 30;             // cap outside diameter
body_h = 26;              // cap height
top_t = 5;                // closed top thickness
bore_d = 25;              // bore core diameter
pitch = 2;                // thread pitch
thread_d = 1.2;           // thread depth
thread_z = 3;             // thread start above the rim
thread_h = 15;            // threaded height
flange_d = 38;            // flange diameter
flange_t = 5;             // flange thickness

difference() {
  union() {
    cylinder(h = 5, d = flange_d);
    translate([0, 0, 4.5]) cylinder(h = 26.5, d = outer_d);
  }
  /* threaded bore, closed at the top */
  translate([0, 0, -2.5]) cylinder(h = 28.5, d = bore_d);
  translate([0, 0, 3]) rotate_extrude() polygon([[11.5, 0], [11.5, 15], [12, 15], [13.7, 14], [12, 13], [13.7, 12], [12, 11], [13.7, 10], [12, 9], [13.7, 8], [12, 7], [13.7, 6], [12, 5], [13.7, 4], [12, 3], [13.7, 2], [12, 0], [11.5, 0]]);
}
