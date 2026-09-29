$fn = 32;

// ----------------------------------------------------------------------
// Threaded cap: 45 mm body, 18 mm tall, 39 mm threaded bore
// ----------------------------------------------------------------------

// --- parameters (mm) ---
outer_d = 45;             // cap outside diameter
body_h = 18;              // cap height
top_t = 5;                // closed top thickness
bore_d = 39;              // bore core diameter
pitch = 2.5;              // thread pitch
thread_d = 1.5;           // thread depth
thread_z = 3;             // thread start above the rim
thread_h = 7;             // threaded height
flange_d = 51;            // flange diameter
flange_t = 3;             // flange thickness

difference() {
  union() {
    cylinder(h = 3, d = flange_d);
    translate([0, 0, 2.5]) cylinder(h = 18.5, d = outer_d);
  }
  /* threaded bore, closed at the top */
  translate([0, 0, -2.5]) cylinder(h = 18.5, d = bore_d);
  translate([0, 0, 3]) rotate_extrude() polygon([[18.5, 0], [18.5, 7], [19, 7], [21, 5.75], [19, 4.5], [21, 3.25], [19, 2], [21, 0.75], [19, 0], [18.5, 0]]);
}
