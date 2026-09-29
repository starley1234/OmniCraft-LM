$fn = 32;

// ----------------------------------------------------------------------
// Living hinge: 46 x 30 mm plates, 0.9 mm flexible web
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_len = 20;           // plate length outside the web
plate_w = 30;             // plate width
thick = 5;                // plate thickness
web_half = 3;             // half width of the flex band
web_t = 0.9;              // flexible web thickness
web_z = 2.05;             // web position inside the thickness
boss_d = 9;               // screw boss diameter
boss_h = 9;               // screw boss height
boss_x = 11;              // screw boss distance from the web
screw_d = 3.6;            // screw hole

difference() {
  union() {
    /* one flat strip, later thinned at the middle */
    translate([-23, -15, 0]) cube([46, 30, 5]);
    /* screw bosses, sunk 0.5 mm into the plates */
    for (sx = [-11, 11]) {
      for (sy = [-8.5, 8.5]) {
        translate([sx, sy, 0]) cylinder(h = boss_h, d = boss_d);
      }
    }
  }
  /* channel from below: leaves the web on top of it */
  translate([-3, -17.5, -2.5]) cube([6, 35, 4.55]);
  /* channel from above: thins the web down to web_t */
  translate([-3, -17.5, 2.95]) cube([6, 35, 4.55]);
  /* screw holes through the bosses */
  for (sx = [-11, 11]) {
    for (sy = [-8.5, 8.5]) {
      translate([sx, sy, -2.5]) cylinder(h = boss_h + 5, d = screw_d);
    }
  }
}
