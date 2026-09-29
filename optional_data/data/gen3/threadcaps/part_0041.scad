$fn = 32;

// ----------------------------------------------------------------------
// Threaded cap: 50 mm body, 22 mm tall, 45 mm threaded bore
// ----------------------------------------------------------------------

// --- parameters (mm) ---
outer_d = 50;             // cap outside diameter
body_h = 22;              // cap height
top_t = 3;                // closed top thickness
bore_d = 45;              // bore core diameter
pitch = 1.5;              // thread pitch
thread_d = 0.9;           // thread depth
thread_z = 3;             // thread start above the rim
thread_h = 13;            // threaded height
flange_d = 58;            // flange diameter
flange_t = 3;             // flange thickness

difference() {
  union() {
    cylinder(h = 3, d = flange_d);
    translate([0, 0, 2.5]) cylinder(h = 22.5, d = outer_d);
  }
  /* threaded bore, closed at the top */
  translate([0, 0, -2.5]) cylinder(h = 24.5, d = bore_d);
  translate([0, 0, 3]) rotate_extrude() polygon([[21.5, 0], [21.5, 13], [22, 13], [23.4, 12.25], [22, 11.5], [23.4, 10.75], [22, 10], [23.4, 9.25], [22, 8.5], [23.4, 7.75], [22, 7], [23.4, 6.25], [22, 5.5], [23.4, 4.75], [22, 4], [23.4, 3.25], [22, 2.5], [23.4, 1.75], [22, 0], [21.5, 0]]);
}
