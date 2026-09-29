$fn = 32;

// ----------------------------------------------------------------------
// Air duct: 34 mm duct, 4 mm wall, 32 mm across
// ----------------------------------------------------------------------

// --- parameters (mm) ---
duct_r = 17;              // duct core radius
duct_d = 34;              // duct core diameter
wall = 4;                 // duct wall thickness
height = 32;              // duct width (extrusion height)
port_r = 26.9;            // port flange half width
port_d = 53.8;            // port flange width
port_t = 6;               // port flange thickness
bolt_d = 5.4;             // port bolt holes
bolt_offset = 21.7;       // bolt hole offset from the port axis

difference() {
  /* outer hull chain: tube with a flat flange plate at every port */
  linear_extrude(height = 32) {
    hull() {
      polygon([[3.012, -26.731], [-3.012, 26.731], [2.95, 27.403], [8.974, -26.059]]);
      translate([8.943, 1.008]) circle(r = 17);
    }
    hull() {
      translate([8.943, 1.008]) circle(r = 17);
      translate([6.676, 0.752]) circle(r = 17);
    }
    hull() {
      translate([6.676, 0.752]) circle(r = 17);
      translate([13.017, 2.971]) circle(r = 17);
    }
    hull() {
      translate([13.017, 2.971]) circle(r = 17);
      translate([18.705, 6.545]) circle(r = 17);
    }
    hull() {
      translate([18.705, 6.545]) circle(r = 17);
      translate([23.455, 11.295]) circle(r = 17);
    }
    hull() {
      translate([23.455, 11.295]) circle(r = 17);
      translate([27.029, 16.983]) circle(r = 17);
    }
    hull() {
      translate([27.029, 16.983]) circle(r = 17);
      translate([29.248, 23.324]) circle(r = 17);
    }
    hull() {
      translate([29.248, 23.324]) circle(r = 17);
      translate([28.992, 21.057]) circle(r = 17);
    }
    hull() {
      translate([28.992, 21.057]) circle(r = 17);
      polygon([[3.269, 33.012], [56.731, 26.988], [56.059, 21.026], [2.597, 27.05]]);
    }
  }
  /* air passage: the same chain inset by the wall, 5 mm proud of the ports */
  translate([0, 0, 4]) linear_extrude(height = 24) {
    hull() {
      translate([-4.969, -0.56]) circle(r = 13);
      translate([6.676, 0.752]) circle(r = 13);
    }
    hull() {
      translate([6.676, 0.752]) circle(r = 13);
      translate([13.017, 2.971]) circle(r = 13);
    }
    hull() {
      translate([13.017, 2.971]) circle(r = 13);
      translate([18.705, 6.545]) circle(r = 13);
    }
    hull() {
      translate([18.705, 6.545]) circle(r = 13);
      translate([23.455, 11.295]) circle(r = 13);
    }
    hull() {
      translate([23.455, 11.295]) circle(r = 13);
      translate([27.029, 16.983]) circle(r = 13);
    }
    hull() {
      translate([27.029, 16.983]) circle(r = 13);
      translate([29.248, 23.324]) circle(r = 13);
    }
    hull() {
      translate([29.248, 23.324]) circle(r = 13);
      translate([30.56, 34.969]) circle(r = 13);
    }
  }
  translate([0, 0]) rotate([0, 0, -83.57]) translate([-21.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 11, d = 5.4);
  translate([0, 0]) rotate([0, 0, -83.57]) translate([21.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 11, d = 5.4);
  translate([30, 30]) rotate([0, 0, 173.57]) translate([-21.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 11, d = 5.4);
  translate([30, 30]) rotate([0, 0, 173.57]) translate([21.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 11, d = 5.4);
}
