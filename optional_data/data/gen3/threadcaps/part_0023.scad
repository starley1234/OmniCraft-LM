$fn = 32;

// ----------------------------------------------------------------------
// Threaded cap: 50 mm body, 22 mm tall, 44 mm threaded bore
// ----------------------------------------------------------------------

// --- parameters (mm) ---
outer_d = 50;             // cap outside diameter
body_h = 22;              // cap height
top_t = 5;                // closed top thickness
bore_d = 44;              // bore core diameter
pitch = 1.5;              // thread pitch
thread_d = 0.9;           // thread depth
thread_z = 3;             // thread start above the rim
thread_h = 11;            // threaded height
flange_d = 58;            // flange diameter
flange_t = 5;             // flange thickness

difference() {
  union() {
    cylinder(h = 5, d = flange_d);
    translate([0, 0, 4.5]) cylinder(h = 22.5, d = outer_d);
  }
  /* threaded bore, closed at the top */
  translate([0, 0, -2.5]) cylinder(h = 24.5, d = bore_d);
  translate([0, 0, 3]) rotate_extrude() polygon([[21, 0], [21, 11], [21.5, 11], [22.9, 10.25], [21.5, 9.5], [22.9, 8.75], [21.5, 8], [22.9, 7.25], [21.5, 6.5], [22.9, 5.75], [21.5, 5], [22.9, 4.25], [21.5, 3.5], [22.9, 2.75], [21.5, 0], [21, 0]]);
}
