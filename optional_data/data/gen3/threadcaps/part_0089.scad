$fn = 32;

// ----------------------------------------------------------------------
// Threaded cap: 30 mm body, 26 mm tall, 25 mm threaded bore
// ----------------------------------------------------------------------

// --- parameters (mm) ---
outer_d = 30;             // cap outside diameter
body_h = 26;              // cap height
top_t = 5;                // closed top thickness
bore_d = 25;              // bore core diameter
pitch = 1.75;             // thread pitch
thread_d = 1.05;          // thread depth
thread_z = 3;             // thread start above the rim
thread_h = 15;            // threaded height
flutes = 14;              // number of knurl flutes
flute_d = 7;              // flute cutter diameter
flute_depth = 1.4;        // flute depth into the rim

difference() {
  union() {
    cylinder(h = 26, d = outer_d);
  }
  /* threaded bore, closed at the top */
  translate([0, 0, -2.5]) cylinder(h = 23.5, d = bore_d);
  translate([0, 0, 3]) rotate_extrude() polygon([[11.5, 0], [11.5, 15], [12, 15], [13.55, 14.125], [12, 13.25], [13.55, 12.375], [12, 11.5], [13.55, 10.625], [12, 9.75], [13.55, 8.875], [12, 8], [13.55, 7.125], [12, 6.25], [13.55, 5.375], [12, 4.5], [13.55, 3.625], [12, 2.75], [13.55, 1.875], [12, 0], [11.5, 0]]);
  /* knurl flutes around the rim */
  for (i = [0 : flutes - 1]) {
    a = i * 360 / flutes;
    translate([(outer_d / 2 + flute_d / 2 - flute_depth) * cos(a), (outer_d / 2 + flute_d / 2 - flute_depth) * sin(a), -2.5]) cylinder(h = body_h + 5, d = flute_d);
  }
}
