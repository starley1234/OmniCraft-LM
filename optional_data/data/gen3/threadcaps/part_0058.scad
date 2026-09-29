$fn = 32;

// ----------------------------------------------------------------------
// Threaded cap: 45 mm body, 22 mm tall, 38 mm threaded bore
// ----------------------------------------------------------------------

// --- parameters (mm) ---
outer_d = 45;             // cap outside diameter
body_h = 22;              // cap height
top_t = 4;                // closed top thickness
bore_d = 38;              // bore core diameter
pitch = 2;                // thread pitch
thread_d = 1.2;           // thread depth
thread_z = 3;             // thread start above the rim
thread_h = 12;            // threaded height
flutes = 12;              // number of knurl flutes
flute_d = 5;              // flute cutter diameter
flute_depth = 1.2;        // flute depth into the rim

difference() {
  union() {
    cylinder(h = 22, d = outer_d);
  }
  /* threaded bore, closed at the top */
  translate([0, 0, -2.5]) cylinder(h = 20.5, d = bore_d);
  translate([0, 0, 3]) rotate_extrude() polygon([[18, 0], [18, 12], [18.5, 12], [20.2, 11], [18.5, 10], [20.2, 9], [18.5, 8], [20.2, 7], [18.5, 6], [20.2, 5], [18.5, 4], [20.2, 3], [18.5, 0], [18, 0]]);
  /* knurl flutes around the rim */
  for (i = [0 : flutes - 1]) {
    a = i * 360 / flutes;
    translate([(outer_d / 2 + flute_d / 2 - flute_depth) * cos(a), (outer_d / 2 + flute_d / 2 - flute_depth) * sin(a), -2.5]) cylinder(h = body_h + 5, d = flute_d);
  }
}
