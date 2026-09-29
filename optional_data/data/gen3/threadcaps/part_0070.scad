$fn = 32;

// ----------------------------------------------------------------------
// Threaded cap: 45 mm body, 30 mm tall, 40 mm threaded bore
// ----------------------------------------------------------------------

// --- parameters (mm) ---
outer_d = 45;             // cap outside diameter
body_h = 30;              // cap height
top_t = 5;                // closed top thickness
bore_d = 40;              // bore core diameter
pitch = 2.5;              // thread pitch
thread_d = 1.5;           // thread depth
thread_z = 3;             // thread start above the rim
thread_h = 19;            // threaded height
flange_d = 55;            // flange diameter
flange_t = 4;             // flange thickness

difference() {
  union() {
    cylinder(h = 4, d = flange_d);
    translate([0, 0, 3.5]) cylinder(h = 30.5, d = outer_d);
  }
  /* threaded bore, closed at the top */
  translate([0, 0, -2.5]) cylinder(h = 31.5, d = bore_d);
  translate([0, 0, 3]) rotate_extrude() polygon([[19, 0], [19, 19], [19.5, 19], [21.5, 17.75], [19.5, 16.5], [21.5, 15.25], [19.5, 14], [21.5, 12.75], [19.5, 11.5], [21.5, 10.25], [19.5, 9], [21.5, 7.75], [19.5, 6.5], [21.5, 5.25], [19.5, 4], [21.5, 2.75], [19.5, 0], [19, 0]]);
}
