$fn = 32;

// ----------------------------------------------------------------------
// Living hinge: 56 x 30 mm plates, 1.4 mm flexible web
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_len = 24;           // plate length outside the web
plate_w = 30;             // plate width
thick = 7;                // plate thickness
web_half = 4;             // half width of the flex band
web_t = 1.4;              // flexible web thickness
web_z = 2.8;              // web position inside the thickness
boss_d = 11;              // screw boss diameter
boss_h = 7;               // screw boss height
boss_x = 13.2;            // screw boss distance from the web
screw_d = 5.4;            // screw hole

difference() {
  union() {
    /* one flat strip, later thinned at the middle */
    translate([-28, -15, 0]) cube([56, 30, 7]);
    /* screw bosses, sunk 0.5 mm into the plates */
    for (sx = [-13.2, 13.2]) {
      for (sy = [-7.5, 7.5]) {
        translate([sx, sy, 0]) cylinder(h = boss_h, d = boss_d);
      }
    }
  }
  /* channel from below: leaves the web on top of it */
  translate([-4, -17.5, -2.5]) cube([8, 35, 5.3]);
  /* channel from above: thins the web down to web_t */
  translate([-4, -17.5, 4.2]) cube([8, 35, 5.3]);
  /* screw holes through the bosses */
  for (sx = [-13.2, 13.2]) {
    for (sy = [-7.5, 7.5]) {
      translate([sx, sy, -2.5]) cylinder(h = boss_h + 5, d = screw_d);
    }
  }
}
