$fn = 32;

// ----------------------------------------------------------------------
// Threaded cap: 50 mm body, 30 mm tall, 45 mm threaded bore
// ----------------------------------------------------------------------

// --- parameters (mm) ---
outer_d = 50;             // cap outside diameter
body_h = 30;              // cap height
top_t = 4;                // closed top thickness
bore_d = 45;              // bore core diameter
pitch = 2.5;              // thread pitch
thread_d = 1.5;           // thread depth
thread_z = 3;             // thread start above the rim
thread_h = 20;            // threaded height
flange_d = 60;            // flange diameter
flange_t = 5;             // flange thickness

difference() {
  union() {
    cylinder(h = 5, d = flange_d);
    translate([0, 0, 4.5]) cylinder(h = 30.5, d = outer_d);
  }
  /* threaded bore, closed at the top */
  translate([0, 0, -2.5]) cylinder(h = 33.5, d = bore_d);
  translate([0, 0, 3]) rotate_extrude() polygon([[21.5, 0], [21.5, 20], [22, 20], [24, 18.75], [22, 17.5], [24, 16.25], [22, 15], [24, 13.75], [22, 12.5], [24, 11.25], [22, 10], [24, 8.75], [22, 7.5], [24, 6.25], [22, 5], [24, 3.75], [22, 0], [21.5, 0]]);
}
