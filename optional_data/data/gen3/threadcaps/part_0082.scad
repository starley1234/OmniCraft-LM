$fn = 32;

// ----------------------------------------------------------------------
// Threaded cap: 40 mm body, 30 mm tall, 33 mm threaded bore
// ----------------------------------------------------------------------

// --- parameters (mm) ---
outer_d = 40;             // cap outside diameter
body_h = 30;              // cap height
top_t = 5;                // closed top thickness
bore_d = 33;              // bore core diameter
pitch = 2.5;              // thread pitch
thread_d = 1.5;           // thread depth
thread_z = 3;             // thread start above the rim
thread_h = 19;            // threaded height
flutes = 14;              // number of knurl flutes
flute_d = 5;              // flute cutter diameter
flute_depth = 1;          // flute depth into the rim

difference() {
  union() {
    cylinder(h = 30, d = outer_d);
  }
  /* threaded bore, closed at the top */
  translate([0, 0, -2.5]) cylinder(h = 27.5, d = bore_d);
  translate([0, 0, 3]) rotate_extrude() polygon([[15.5, 0], [15.5, 19], [16, 19], [18, 17.75], [16, 16.5], [18, 15.25], [16, 14], [18, 12.75], [16, 11.5], [18, 10.25], [16, 9], [18, 7.75], [16, 6.5], [18, 5.25], [16, 4], [18, 2.75], [16, 0], [15.5, 0]]);
  /* knurl flutes around the rim */
  for (i = [0 : flutes - 1]) {
    a = i * 360 / flutes;
    translate([(outer_d / 2 + flute_d / 2 - flute_depth) * cos(a), (outer_d / 2 + flute_d / 2 - flute_depth) * sin(a), -2.5]) cylinder(h = body_h + 5, d = flute_d);
  }
}
