$fn = 32;

// ----------------------------------------------------------------------
// Threaded cap: 30 mm body, 30 mm tall, 22 mm threaded bore
// ----------------------------------------------------------------------

// --- parameters (mm) ---
outer_d = 30;             // cap outside diameter
body_h = 30;              // cap height
top_t = 4;                // closed top thickness
bore_d = 22;              // bore core diameter
pitch = 1.75;             // thread pitch
thread_d = 1.05;          // thread depth
thread_z = 3;             // thread start above the rim
thread_h = 20;            // threaded height
flange_d = 40;            // flange diameter
flange_t = 3;             // flange thickness

difference() {
  union() {
    cylinder(h = 3, d = flange_d);
    translate([0, 0, 2.5]) cylinder(h = 30.5, d = outer_d);
  }
  /* threaded bore, closed at the top */
  translate([0, 0, -2.5]) cylinder(h = 31.5, d = bore_d);
  translate([0, 0, 3]) rotate_extrude() polygon([[10, 0], [10, 20], [10.5, 20], [12.05, 19.125], [10.5, 18.25], [12.05, 17.375], [10.5, 16.5], [12.05, 15.625], [10.5, 14.75], [12.05, 13.875], [10.5, 13], [12.05, 12.125], [10.5, 11.25], [12.05, 10.375], [10.5, 9.5], [12.05, 8.625], [10.5, 7.75], [12.05, 6.875], [10.5, 6], [12.05, 5.125], [10.5, 4.25], [12.05, 3.375], [10.5, 2.5], [12.05, 1.625], [10.5, 0], [10, 0]]);
}
