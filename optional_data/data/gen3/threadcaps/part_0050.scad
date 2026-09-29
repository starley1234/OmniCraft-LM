$fn = 32;

// ----------------------------------------------------------------------
// Threaded cap: 50 mm body, 30 mm tall, 44 mm threaded bore
// ----------------------------------------------------------------------

// --- parameters (mm) ---
outer_d = 50;             // cap outside diameter
body_h = 30;              // cap height
top_t = 5;                // closed top thickness
bore_d = 44;              // bore core diameter
pitch = 2;                // thread pitch
thread_d = 1.2;           // thread depth
thread_z = 3;             // thread start above the rim
thread_h = 19;            // threaded height
flutes = 10;              // number of knurl flutes
flute_d = 7;              // flute cutter diameter
flute_depth = 1.4;        // flute depth into the rim

difference() {
  union() {
    cylinder(h = 30, d = outer_d);
  }
  /* threaded bore, closed at the top */
  translate([0, 0, -2.5]) cylinder(h = 27.5, d = bore_d);
  translate([0, 0, 3]) rotate_extrude() polygon([[21, 0], [21, 19], [21.5, 19], [23.2, 18], [21.5, 17], [23.2, 16], [21.5, 15], [23.2, 14], [21.5, 13], [23.2, 12], [21.5, 11], [23.2, 10], [21.5, 9], [23.2, 8], [21.5, 7], [23.2, 6], [21.5, 5], [23.2, 4], [21.5, 3], [23.2, 2], [21.5, 0], [21, 0]]);
  /* knurl flutes around the rim */
  for (i = [0 : flutes - 1]) {
    a = i * 360 / flutes;
    translate([(outer_d / 2 + flute_d / 2 - flute_depth) * cos(a), (outer_d / 2 + flute_d / 2 - flute_depth) * sin(a), -2.5]) cylinder(h = body_h + 5, d = flute_d);
  }
}
