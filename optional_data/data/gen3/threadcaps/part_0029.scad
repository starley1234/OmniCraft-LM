$fn = 32;

// ----------------------------------------------------------------------
// Threaded cap: 40 mm body, 30 mm tall, 35 mm threaded bore
// ----------------------------------------------------------------------

// --- parameters (mm) ---
outer_d = 40;             // cap outside diameter
body_h = 30;              // cap height
top_t = 4;                // closed top thickness
bore_d = 35;              // bore core diameter
pitch = 2;                // thread pitch
thread_d = 1.2;           // thread depth
thread_z = 3;             // thread start above the rim
thread_h = 20;            // threaded height
flange_d = 46;            // flange diameter
flange_t = 5;             // flange thickness

difference() {
  union() {
    cylinder(h = 5, d = flange_d);
    translate([0, 0, 4.5]) cylinder(h = 30.5, d = outer_d);
  }
  /* threaded bore, closed at the top */
  translate([0, 0, -2.5]) cylinder(h = 33.5, d = bore_d);
  translate([0, 0, 3]) rotate_extrude() polygon([[16.5, 0], [16.5, 20], [17, 20], [18.7, 19], [17, 18], [18.7, 17], [17, 16], [18.7, 15], [17, 14], [18.7, 13], [17, 12], [18.7, 11], [17, 10], [18.7, 9], [17, 8], [18.7, 7], [17, 6], [18.7, 5], [17, 4], [18.7, 3], [17, 0], [16.5, 0]]);
}
