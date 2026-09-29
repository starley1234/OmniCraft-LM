$fn = 32;

// ----------------------------------------------------------------------
// Threaded cap: 40 mm body, 22 mm tall, 34 mm threaded bore
// ----------------------------------------------------------------------

// --- parameters (mm) ---
outer_d = 40;             // cap outside diameter
body_h = 22;              // cap height
top_t = 4;                // closed top thickness
bore_d = 34;              // bore core diameter
pitch = 1.75;             // thread pitch
thread_d = 1.05;          // thread depth
thread_z = 3;             // thread start above the rim
thread_h = 12;            // threaded height
flutes = 8;               // number of knurl flutes
flute_d = 7;              // flute cutter diameter
flute_depth = 1.2;        // flute depth into the rim

difference() {
  union() {
    cylinder(h = 22, d = outer_d);
  }
  /* threaded bore, closed at the top */
  translate([0, 0, -2.5]) cylinder(h = 20.5, d = bore_d);
  translate([0, 0, 3]) rotate_extrude() polygon([[16, 0], [16, 12], [16.5, 12], [18.05, 11.125], [16.5, 10.25], [18.05, 9.375], [16.5, 8.5], [18.05, 7.625], [16.5, 6.75], [18.05, 5.875], [16.5, 5], [18.05, 4.125], [16.5, 3.25], [18.05, 2.375], [16.5, 0], [16, 0]]);
  /* knurl flutes around the rim */
  for (i = [0 : flutes - 1]) {
    a = i * 360 / flutes;
    translate([(outer_d / 2 + flute_d / 2 - flute_depth) * cos(a), (outer_d / 2 + flute_d / 2 - flute_depth) * sin(a), -2.5]) cylinder(h = body_h + 5, d = flute_d);
  }
}
