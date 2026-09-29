$fn = 32;

// ----------------------------------------------------------------------
// Living hinge: 42 x 30 mm plates, 1.4 mm flexible web
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_len = 16;           // plate length outside the web
plate_w = 30;             // plate width
thick = 5;                // plate thickness
web_half = 5;             // half width of the flex band
web_t = 1.4;              // flexible web thickness
web_z = 1.8;              // web position inside the thickness
boss_d = 11;              // screw boss diameter
boss_h = 7;               // screw boss height
boss_x = 8.8;             // screw boss distance from the web
screw_d = 5.4;            // screw hole

difference() {
  union() {
    /* one flat strip, later thinned at the middle */
    translate([-21, -15, 0]) cube([42, 30, 5]);
    /* screw bosses, sunk 0.5 mm into the plates */
    for (sx = [-8.8, 8.8]) {
      for (sy = [-7.5, 7.5]) {
        translate([sx, sy, 0]) cylinder(h = boss_h, d = boss_d);
      }
    }
  }
  /* channel from below: leaves the web on top of it */
  translate([-5, -17.5, -2.5]) cube([10, 35, 4.3]);
  /* channel from above: thins the web down to web_t */
  translate([-5, -17.5, 3.2]) cube([10, 35, 4.3]);
  /* screw holes through the bosses */
  for (sx = [-8.8, 8.8]) {
    for (sy = [-7.5, 7.5]) {
      translate([sx, sy, -2.5]) cylinder(h = boss_h + 5, d = screw_d);
    }
  }
}
