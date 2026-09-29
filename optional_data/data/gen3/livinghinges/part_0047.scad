$fn = 32;

// ----------------------------------------------------------------------
// Living hinge: 42 x 42 mm plates, 0.9 mm flexible web
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_len = 16;           // plate length outside the web
plate_w = 42;             // plate width
thick = 7;                // plate thickness
web_half = 5;             // half width of the flex band
web_t = 0.9;              // flexible web thickness
web_z = 3.05;             // web position inside the thickness
boss_d = 9;               // screw boss diameter
boss_h = 8;               // screw boss height
boss_x = 8.8;             // screw boss distance from the web
screw_d = 5.4;            // screw hole

difference() {
  union() {
    /* one flat strip, later thinned at the middle */
    translate([-21, -21, 0]) cube([42, 42, 7]);
    /* screw bosses, sunk 0.5 mm into the plates */
    for (sx = [-8.8, 8.8]) {
      for (sy = [-14.5, 14.5]) {
        translate([sx, sy, 0]) cylinder(h = boss_h, d = boss_d);
      }
    }
  }
  /* channel from below: leaves the web on top of it */
  translate([-5, -23.5, -2.5]) cube([10, 47, 5.55]);
  /* channel from above: thins the web down to web_t */
  translate([-5, -23.5, 3.95]) cube([10, 47, 5.55]);
  /* screw holes through the bosses */
  for (sx = [-8.8, 8.8]) {
    for (sy = [-14.5, 14.5]) {
      translate([sx, sy, -2.5]) cylinder(h = boss_h + 5, d = screw_d);
    }
  }
}
