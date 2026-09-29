$fn = 32;

// ----------------------------------------------------------------------
// Threaded cap: 40 mm body, 18 mm tall, 33 mm threaded bore
// ----------------------------------------------------------------------

// --- parameters (mm) ---
outer_d = 40;             // cap outside diameter
body_h = 18;              // cap height
top_t = 4;                // closed top thickness
bore_d = 33;              // bore core diameter
pitch = 1.75;             // thread pitch
thread_d = 1.05;          // thread depth
thread_z = 3;             // thread start above the rim
thread_h = 8;             // threaded height
flutes = 9;               // number of knurl flutes
flute_d = 5;              // flute cutter diameter
flute_depth = 1.2;        // flute depth into the rim

difference() {
  union() {
    cylinder(h = 18, d = outer_d);
  }
  /* threaded bore, closed at the top */
  translate([0, 0, -2.5]) cylinder(h = 16.5, d = bore_d);
  translate([0, 0, 3]) rotate_extrude() polygon([[15.5, 0], [15.5, 8], [16, 8], [17.55, 7.125], [16, 6.25], [17.55, 5.375], [16, 4.5], [17.55, 3.625], [16, 2.75], [17.55, 1.875], [16, 0], [15.5, 0]]);
  /* knurl flutes around the rim */
  for (i = [0 : flutes - 1]) {
    a = i * 360 / flutes;
    translate([(outer_d / 2 + flute_d / 2 - flute_depth) * cos(a), (outer_d / 2 + flute_d / 2 - flute_depth) * sin(a), -2.5]) cylinder(h = body_h + 5, d = flute_d);
  }
}
