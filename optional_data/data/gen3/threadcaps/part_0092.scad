$fn = 32;

// ----------------------------------------------------------------------
// Threaded cap: 40 mm body, 18 mm tall, 32 mm threaded bore
// ----------------------------------------------------------------------

// --- parameters (mm) ---
outer_d = 40;             // cap outside diameter
body_h = 18;              // cap height
top_t = 3;                // closed top thickness
bore_d = 32;              // bore core diameter
pitch = 1.5;              // thread pitch
thread_d = 0.9;           // thread depth
thread_z = 3;             // thread start above the rim
thread_h = 9;             // threaded height
flange_d = 50;            // flange diameter
flange_t = 3;             // flange thickness

difference() {
  union() {
    cylinder(h = 3, d = flange_d);
    translate([0, 0, 2.5]) cylinder(h = 18.5, d = outer_d);
  }
  /* threaded bore, closed at the top */
  translate([0, 0, -2.5]) cylinder(h = 20.5, d = bore_d);
  translate([0, 0, 3]) rotate_extrude() polygon([[15, 0], [15, 9], [15.5, 9], [16.9, 8.25], [15.5, 7.5], [16.9, 6.75], [15.5, 6], [16.9, 5.25], [15.5, 4.5], [16.9, 3.75], [15.5, 3], [16.9, 2.25], [15.5, 0], [15, 0]]);
}
