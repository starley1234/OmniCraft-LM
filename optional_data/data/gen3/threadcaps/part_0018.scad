$fn = 32;

// ----------------------------------------------------------------------
// Threaded cap: 40 mm body, 30 mm tall, 33 mm threaded bore
// ----------------------------------------------------------------------

// --- parameters (mm) ---
outer_d = 40;             // cap outside diameter
body_h = 30;              // cap height
top_t = 4;                // closed top thickness
bore_d = 33;              // bore core diameter
pitch = 1.5;              // thread pitch
thread_d = 0.9;           // thread depth
thread_z = 3;             // thread start above the rim
thread_h = 20;            // threaded height
flutes = 14;              // number of knurl flutes
flute_d = 6;              // flute cutter diameter
flute_depth = 1;          // flute depth into the rim

difference() {
  union() {
    cylinder(h = 30, d = outer_d);
  }
  /* threaded bore, closed at the top */
  translate([0, 0, -2.5]) cylinder(h = 28.5, d = bore_d);
  translate([0, 0, 3]) rotate_extrude() polygon([[15.5, 0], [15.5, 20], [16, 20], [17.4, 19.25], [16, 18.5], [17.4, 17.75], [16, 17], [17.4, 16.25], [16, 15.5], [17.4, 14.75], [16, 14], [17.4, 13.25], [16, 12.5], [17.4, 11.75], [16, 11], [17.4, 10.25], [16, 9.5], [17.4, 8.75], [16, 8], [17.4, 7.25], [16, 6.5], [17.4, 5.75], [16, 5], [17.4, 4.25], [16, 3.5], [17.4, 2.75], [16, 0], [15.5, 0]]);
  /* knurl flutes around the rim */
  for (i = [0 : flutes - 1]) {
    a = i * 360 / flutes;
    translate([(outer_d / 2 + flute_d / 2 - flute_depth) * cos(a), (outer_d / 2 + flute_d / 2 - flute_depth) * sin(a), -2.5]) cylinder(h = body_h + 5, d = flute_d);
  }
}
