$fn = 32;

// ----------------------------------------------------------------------
// Threaded cap: 45 mm body, 30 mm tall, 40 mm threaded bore
// ----------------------------------------------------------------------

// --- parameters (mm) ---
outer_d = 45;             // cap outside diameter
body_h = 30;              // cap height
top_t = 5;                // closed top thickness
bore_d = 40;              // bore core diameter
pitch = 1.75;             // thread pitch
thread_d = 1.05;          // thread depth
thread_z = 3;             // thread start above the rim
thread_h = 19;            // threaded height
flutes = 13;              // number of knurl flutes
flute_d = 5;              // flute cutter diameter
flute_depth = 1.2;        // flute depth into the rim

difference() {
  union() {
    cylinder(h = 30, d = outer_d);
  }
  /* threaded bore, closed at the top */
  translate([0, 0, -2.5]) cylinder(h = 27.5, d = bore_d);
  translate([0, 0, 3]) rotate_extrude() polygon([[19, 0], [19, 19], [19.5, 19], [21.05, 18.125], [19.5, 17.25], [21.05, 16.375], [19.5, 15.5], [21.05, 14.625], [19.5, 13.75], [21.05, 12.875], [19.5, 12], [21.05, 11.125], [19.5, 10.25], [21.05, 9.375], [19.5, 8.5], [21.05, 7.625], [19.5, 6.75], [21.05, 5.875], [19.5, 5], [21.05, 4.125], [19.5, 3.25], [21.05, 2.375], [19.5, 0], [19, 0]]);
  /* knurl flutes around the rim */
  for (i = [0 : flutes - 1]) {
    a = i * 360 / flutes;
    translate([(outer_d / 2 + flute_d / 2 - flute_depth) * cos(a), (outer_d / 2 + flute_d / 2 - flute_depth) * sin(a), -2.5]) cylinder(h = body_h + 5, d = flute_d);
  }
}
