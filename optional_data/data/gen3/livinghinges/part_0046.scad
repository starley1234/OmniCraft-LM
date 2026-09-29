$fn = 32;

// ----------------------------------------------------------------------
// Living hinge: 38 x 36 mm plates, 1 mm flexible web
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_len = 16;           // plate length outside the web
plate_w = 36;             // plate width
thick = 6;                // plate thickness
web_half = 3;             // half width of the flex band
web_t = 1;                // flexible web thickness
web_z = 2.5;              // web position inside the thickness
boss_d = 11;              // screw boss diameter
boss_h = 7;               // screw boss height
boss_x = 8.8;             // screw boss distance from the web
screw_d = 4.4;            // screw hole

difference() {
  union() {
    /* one flat strip, later thinned at the middle */
    translate([-19, -18, 0]) cube([38, 36, 6]);
    /* screw bosses, sunk 0.5 mm into the plates */
    for (sx = [-8.8, 8.8]) {
      for (sy = [-10.5, 10.5]) {
        translate([sx, sy, 0]) cylinder(h = boss_h, d = boss_d);
      }
    }
  }
  /* channel from below: leaves the web on top of it */
  translate([-3, -20.5, -2.5]) cube([6, 41, 5]);
  /* channel from above: thins the web down to web_t */
  translate([-3, -20.5, 3.5]) cube([6, 41, 5]);
  /* screw holes through the bosses */
  for (sx = [-8.8, 8.8]) {
    for (sy = [-10.5, 10.5]) {
      translate([sx, sy, -2.5]) cylinder(h = boss_h + 5, d = screw_d);
    }
  }
}
