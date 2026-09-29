$fn = 32;

// ----------------------------------------------------------------------
// Threaded cap: 30 mm body, 26 mm tall, 23 mm threaded bore
// ----------------------------------------------------------------------

// --- parameters (mm) ---
outer_d = 30;             // cap outside diameter
body_h = 26;              // cap height
top_t = 3;                // closed top thickness
bore_d = 23;              // bore core diameter
pitch = 1.75;             // thread pitch
thread_d = 1.05;          // thread depth
thread_z = 3;             // thread start above the rim
thread_h = 17;            // threaded height
flutes = 10;              // number of knurl flutes
flute_d = 6;              // flute cutter diameter
flute_depth = 1.4;        // flute depth into the rim

difference() {
  union() {
    cylinder(h = 26, d = outer_d);
  }
  /* threaded bore, closed at the top */
  translate([0, 0, -2.5]) cylinder(h = 25.5, d = bore_d);
  translate([0, 0, 3]) rotate_extrude() polygon([[10.5, 0], [10.5, 17], [11, 17], [12.55, 16.125], [11, 15.25], [12.55, 14.375], [11, 13.5], [12.55, 12.625], [11, 11.75], [12.55, 10.875], [11, 10], [12.55, 9.125], [11, 8.25], [12.55, 7.375], [11, 6.5], [12.55, 5.625], [11, 4.75], [12.55, 3.875], [11, 3], [12.55, 2.125], [11, 0], [10.5, 0]]);
  /* knurl flutes around the rim */
  for (i = [0 : flutes - 1]) {
    a = i * 360 / flutes;
    translate([(outer_d / 2 + flute_d / 2 - flute_depth) * cos(a), (outer_d / 2 + flute_d / 2 - flute_depth) * sin(a), -2.5]) cylinder(h = body_h + 5, d = flute_d);
  }
}
