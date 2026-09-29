$fn = 32;

// ----------------------------------------------------------------------
// Threaded cap: 50 mm body, 30 mm tall, 44 mm threaded bore
// ----------------------------------------------------------------------

// --- parameters (mm) ---
outer_d = 50;             // cap outside diameter
body_h = 30;              // cap height
top_t = 4;                // closed top thickness
bore_d = 44;              // bore core diameter
pitch = 2.5;              // thread pitch
thread_d = 1.5;           // thread depth
thread_z = 3;             // thread start above the rim
thread_h = 20;            // threaded height
flange_d = 60;            // flange diameter
flange_t = 3;             // flange thickness

difference() {
  union() {
    cylinder(h = 3, d = flange_d);
    translate([0, 0, 2.5]) cylinder(h = 30.5, d = outer_d);
  }
  /* threaded bore, closed at the top */
  translate([0, 0, -2.5]) cylinder(h = 31.5, d = bore_d);
  translate([0, 0, 3]) rotate_extrude() polygon([[21, 0], [21, 20], [21.5, 20], [23.5, 18.75], [21.5, 17.5], [23.5, 16.25], [21.5, 15], [23.5, 13.75], [21.5, 12.5], [23.5, 11.25], [21.5, 10], [23.5, 8.75], [21.5, 7.5], [23.5, 6.25], [21.5, 5], [23.5, 3.75], [21.5, 0], [21, 0]]);
}
