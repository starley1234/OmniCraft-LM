$fn = 32;

// ----------------------------------------------------------------------
// Threaded cap: 45 mm body, 26 mm tall, 38 mm threaded bore
// ----------------------------------------------------------------------

// --- parameters (mm) ---
outer_d = 45;             // cap outside diameter
body_h = 26;              // cap height
top_t = 4;                // closed top thickness
bore_d = 38;              // bore core diameter
pitch = 1.75;             // thread pitch
thread_d = 1.05;          // thread depth
thread_z = 3;             // thread start above the rim
thread_h = 16;            // threaded height
flutes = 9;               // number of knurl flutes
flute_d = 7;              // flute cutter diameter
flute_depth = 1;          // flute depth into the rim

difference() {
  union() {
    cylinder(h = 26, d = outer_d);
  }
  /* threaded bore, closed at the top */
  translate([0, 0, -2.5]) cylinder(h = 24.5, d = bore_d);
  translate([0, 0, 3]) rotate_extrude() polygon([[18, 0], [18, 16], [18.5, 16], [20.05, 15.125], [18.5, 14.25], [20.05, 13.375], [18.5, 12.5], [20.05, 11.625], [18.5, 10.75], [20.05, 9.875], [18.5, 9], [20.05, 8.125], [18.5, 7.25], [20.05, 6.375], [18.5, 5.5], [20.05, 4.625], [18.5, 3.75], [20.05, 2.875], [18.5, 0], [18, 0]]);
  /* knurl flutes around the rim */
  for (i = [0 : flutes - 1]) {
    a = i * 360 / flutes;
    translate([(outer_d / 2 + flute_d / 2 - flute_depth) * cos(a), (outer_d / 2 + flute_d / 2 - flute_depth) * sin(a), -2.5]) cylinder(h = body_h + 5, d = flute_d);
  }
}
