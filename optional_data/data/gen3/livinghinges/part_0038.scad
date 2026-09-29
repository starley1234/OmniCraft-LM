$fn = 32;

// ----------------------------------------------------------------------
// Living hinge: 40 x 42 mm plates, 1.2 mm flexible web
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_len = 16;           // plate length outside the web
plate_w = 42;             // plate width
thick = 6;                // plate thickness
web_half = 4;             // half width of the flex band
web_t = 1.2;              // flexible web thickness
web_z = 2.4;              // web position inside the thickness
boss_d = 11;              // screw boss diameter
boss_h = 9;               // screw boss height
boss_x = 8.8;             // screw boss distance from the web
screw_d = 4.4;            // screw hole

difference() {
  union() {
    /* one flat strip, later thinned at the middle */
    translate([-20, -21, 0]) cube([40, 42, 6]);
    /* screw bosses, sunk 0.5 mm into the plates */
    for (sx = [-8.8, 8.8]) {
      for (sy = [-13.5, 13.5]) {
        translate([sx, sy, 0]) cylinder(h = boss_h, d = boss_d);
      }
    }
  }
  /* channel from below: leaves the web on top of it */
  translate([-4, -23.5, -2.5]) cube([8, 47, 4.9]);
  /* channel from above: thins the web down to web_t */
  translate([-4, -23.5, 3.6]) cube([8, 47, 4.9]);
  /* screw holes through the bosses */
  for (sx = [-8.8, 8.8]) {
    for (sy = [-13.5, 13.5]) {
      translate([sx, sy, -2.5]) cylinder(h = boss_h + 5, d = screw_d);
    }
  }
}
