$fn = 32;

// ----------------------------------------------------------------------
// Threaded cap: 50 mm body, 30 mm tall, 42 mm threaded bore
// ----------------------------------------------------------------------

// --- parameters (mm) ---
outer_d = 50;             // cap outside diameter
body_h = 30;              // cap height
top_t = 5;                // closed top thickness
bore_d = 42;              // bore core diameter
pitch = 1.5;              // thread pitch
thread_d = 0.9;           // thread depth
thread_z = 3;             // thread start above the rim
thread_h = 19;            // threaded height
flutes = 11;              // number of knurl flutes
flute_d = 5;              // flute cutter diameter
flute_depth = 1.4;        // flute depth into the rim

difference() {
  union() {
    cylinder(h = 30, d = outer_d);
  }
  /* threaded bore, closed at the top */
  translate([0, 0, -2.5]) cylinder(h = 27.5, d = bore_d);
  translate([0, 0, 3]) rotate_extrude() polygon([[20, 0], [20, 19], [20.5, 19], [21.9, 18.25], [20.5, 17.5], [21.9, 16.75], [20.5, 16], [21.9, 15.25], [20.5, 14.5], [21.9, 13.75], [20.5, 13], [21.9, 12.25], [20.5, 11.5], [21.9, 10.75], [20.5, 10], [21.9, 9.25], [20.5, 8.5], [21.9, 7.75], [20.5, 7], [21.9, 6.25], [20.5, 5.5], [21.9, 4.75], [20.5, 4], [21.9, 3.25], [20.5, 2.5], [21.9, 1.75], [20.5, 0], [20, 0]]);
  /* knurl flutes around the rim */
  for (i = [0 : flutes - 1]) {
    a = i * 360 / flutes;
    translate([(outer_d / 2 + flute_d / 2 - flute_depth) * cos(a), (outer_d / 2 + flute_d / 2 - flute_depth) * sin(a), -2.5]) cylinder(h = body_h + 5, d = flute_d);
  }
}
