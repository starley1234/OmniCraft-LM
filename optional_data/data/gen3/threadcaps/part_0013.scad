$fn = 32;

// ----------------------------------------------------------------------
// Threaded cap: 40 mm body, 18 mm tall, 34 mm threaded bore
// ----------------------------------------------------------------------

// --- parameters (mm) ---
outer_d = 40;             // cap outside diameter
body_h = 18;              // cap height
top_t = 3;                // closed top thickness
bore_d = 34;              // bore core diameter
pitch = 2;                // thread pitch
thread_d = 1.2;           // thread depth
thread_z = 3;             // thread start above the rim
thread_h = 9;             // threaded height
flutes = 13;              // number of knurl flutes
flute_d = 5;              // flute cutter diameter
flute_depth = 1.2;        // flute depth into the rim

difference() {
  union() {
    cylinder(h = 18, d = outer_d);
  }
  /* threaded bore, closed at the top */
  translate([0, 0, -2.5]) cylinder(h = 17.5, d = bore_d);
  translate([0, 0, 3]) rotate_extrude() polygon([[16, 0], [16, 9], [16.5, 9], [18.2, 8], [16.5, 7], [18.2, 6], [16.5, 5], [18.2, 4], [16.5, 3], [18.2, 2], [16.5, 0], [16, 0]]);
  /* knurl flutes around the rim */
  for (i = [0 : flutes - 1]) {
    a = i * 360 / flutes;
    translate([(outer_d / 2 + flute_d / 2 - flute_depth) * cos(a), (outer_d / 2 + flute_d / 2 - flute_depth) * sin(a), -2.5]) cylinder(h = body_h + 5, d = flute_d);
  }
}
