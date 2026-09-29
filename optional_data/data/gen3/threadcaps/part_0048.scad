$fn = 32;

// ----------------------------------------------------------------------
// Threaded cap: 30 mm body, 30 mm tall, 25 mm threaded bore
// ----------------------------------------------------------------------

// --- parameters (mm) ---
outer_d = 30;             // cap outside diameter
body_h = 30;              // cap height
top_t = 5;                // closed top thickness
bore_d = 25;              // bore core diameter
pitch = 1.75;             // thread pitch
thread_d = 1.05;          // thread depth
thread_z = 3;             // thread start above the rim
thread_h = 19;            // threaded height
flutes = 12;              // number of knurl flutes
flute_d = 5;              // flute cutter diameter
flute_depth = 1;          // flute depth into the rim

difference() {
  union() {
    cylinder(h = 30, d = outer_d);
  }
  /* threaded bore, closed at the top */
  translate([0, 0, -2.5]) cylinder(h = 27.5, d = bore_d);
  translate([0, 0, 3]) rotate_extrude() polygon([[11.5, 0], [11.5, 19], [12, 19], [13.55, 18.125], [12, 17.25], [13.55, 16.375], [12, 15.5], [13.55, 14.625], [12, 13.75], [13.55, 12.875], [12, 12], [13.55, 11.125], [12, 10.25], [13.55, 9.375], [12, 8.5], [13.55, 7.625], [12, 6.75], [13.55, 5.875], [12, 5], [13.55, 4.125], [12, 3.25], [13.55, 2.375], [12, 0], [11.5, 0]]);
  /* knurl flutes around the rim */
  for (i = [0 : flutes - 1]) {
    a = i * 360 / flutes;
    translate([(outer_d / 2 + flute_d / 2 - flute_depth) * cos(a), (outer_d / 2 + flute_d / 2 - flute_depth) * sin(a), -2.5]) cylinder(h = body_h + 5, d = flute_d);
  }
}
