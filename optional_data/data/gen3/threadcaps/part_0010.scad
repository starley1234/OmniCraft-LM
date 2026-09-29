$fn = 32;

// ----------------------------------------------------------------------
// Threaded cap: 50 mm body, 22 mm tall, 44 mm threaded bore
// ----------------------------------------------------------------------

// --- parameters (mm) ---
outer_d = 50;             // cap outside diameter
body_h = 22;              // cap height
top_t = 3;                // closed top thickness
bore_d = 44;              // bore core diameter
pitch = 2.5;              // thread pitch
thread_d = 1.5;           // thread depth
thread_z = 3;             // thread start above the rim
thread_h = 13;            // threaded height
flange_d = 56;            // flange diameter
flange_t = 4;             // flange thickness

difference() {
  union() {
    cylinder(h = 4, d = flange_d);
    translate([0, 0, 3.5]) cylinder(h = 22.5, d = outer_d);
  }
  /* threaded bore, closed at the top */
  translate([0, 0, -2.5]) cylinder(h = 25.5, d = bore_d);
  translate([0, 0, 3]) rotate_extrude() polygon([[21, 0], [21, 13], [21.5, 13], [23.5, 11.75], [21.5, 10.5], [23.5, 9.25], [21.5, 8], [23.5, 6.75], [21.5, 5.5], [23.5, 4.25], [21.5, 0], [21, 0]]);
}
