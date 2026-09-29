$fn = 32;

// ----------------------------------------------------------------------
// Threaded cap: 50 mm body, 18 mm tall, 42 mm threaded bore
// ----------------------------------------------------------------------

// --- parameters (mm) ---
outer_d = 50;             // cap outside diameter
body_h = 18;              // cap height
top_t = 5;                // closed top thickness
bore_d = 42;              // bore core diameter
pitch = 2.5;              // thread pitch
thread_d = 1.5;           // thread depth
thread_z = 3;             // thread start above the rim
thread_h = 7;             // threaded height
flange_d = 60;            // flange diameter
flange_t = 5;             // flange thickness

difference() {
  union() {
    cylinder(h = 5, d = flange_d);
    translate([0, 0, 4.5]) cylinder(h = 18.5, d = outer_d);
  }
  /* threaded bore, closed at the top */
  translate([0, 0, -2.5]) cylinder(h = 20.5, d = bore_d);
  translate([0, 0, 3]) rotate_extrude() polygon([[20, 0], [20, 7], [20.5, 7], [22.5, 5.75], [20.5, 4.5], [22.5, 3.25], [20.5, 2], [22.5, 0.75], [20.5, 0], [20, 0]]);
}
