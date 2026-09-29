$fn = 32;

// ----------------------------------------------------------------------
// Threaded cap: 30 mm body, 22 mm tall, 23 mm threaded bore
// ----------------------------------------------------------------------

// --- parameters (mm) ---
outer_d = 30;             // cap outside diameter
body_h = 22;              // cap height
top_t = 5;                // closed top thickness
bore_d = 23;              // bore core diameter
pitch = 2.5;              // thread pitch
thread_d = 1.5;           // thread depth
thread_z = 3;             // thread start above the rim
thread_h = 11;            // threaded height
flutes = 13;              // number of knurl flutes
flute_d = 6;              // flute cutter diameter
flute_depth = 1.2;        // flute depth into the rim

difference() {
  union() {
    cylinder(h = 22, d = outer_d);
  }
  /* threaded bore, closed at the top */
  translate([0, 0, -2.5]) cylinder(h = 19.5, d = bore_d);
  translate([0, 0, 3]) rotate_extrude() polygon([[10.5, 0], [10.5, 11], [11, 11], [13, 9.75], [11, 8.5], [13, 7.25], [11, 6], [13, 4.75], [11, 3.5], [13, 2.25], [11, 0], [10.5, 0]]);
  /* knurl flutes around the rim */
  for (i = [0 : flutes - 1]) {
    a = i * 360 / flutes;
    translate([(outer_d / 2 + flute_d / 2 - flute_depth) * cos(a), (outer_d / 2 + flute_d / 2 - flute_depth) * sin(a), -2.5]) cylinder(h = body_h + 5, d = flute_d);
  }
}
