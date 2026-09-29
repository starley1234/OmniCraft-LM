$fn = 32;

// ----------------------------------------------------------------------
// Threaded cap: 30 mm body, 30 mm tall, 25 mm threaded bore
// ----------------------------------------------------------------------

// --- parameters (mm) ---
outer_d = 30;             // cap outside diameter
body_h = 30;              // cap height
top_t = 4;                // closed top thickness
bore_d = 25;              // bore core diameter
pitch = 2.5;              // thread pitch
thread_d = 1.5;           // thread depth
thread_z = 3;             // thread start above the rim
thread_h = 20;            // threaded height
flange_d = 38;            // flange diameter
flange_t = 4;             // flange thickness

difference() {
  union() {
    cylinder(h = 4, d = flange_d);
    translate([0, 0, 3.5]) cylinder(h = 30.5, d = outer_d);
  }
  /* threaded bore, closed at the top */
  translate([0, 0, -2.5]) cylinder(h = 32.5, d = bore_d);
  translate([0, 0, 3]) rotate_extrude() polygon([[11.5, 0], [11.5, 20], [12, 20], [14, 18.75], [12, 17.5], [14, 16.25], [12, 15], [14, 13.75], [12, 12.5], [14, 11.25], [12, 10], [14, 8.75], [12, 7.5], [14, 6.25], [12, 5], [14, 3.75], [12, 0], [11.5, 0]]);
}
