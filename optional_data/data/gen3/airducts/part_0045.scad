$fn = 32;

// ----------------------------------------------------------------------
// Air duct: 20 mm duct, 4 mm wall, 44 mm across
// ----------------------------------------------------------------------

// --- parameters (mm) ---
duct_r = 10;              // duct core radius
duct_d = 20;              // duct core diameter
wall = 4;                 // duct wall thickness
height = 44;              // duct width (extrusion height)
port_r = 19.9;            // port flange half width
port_d = 39.8;            // port flange width
port_t = 6;               // port flange thickness
bolt_d = 5.4;             // port bolt holes
bolt_offset = 14.7;       // bolt hole offset from the port axis

difference() {
  /* outer hull chain: tube with a flat flange plate at every port */
  linear_extrude(height = 44) {
    hull() {
      polygon([[2.228, -19.775], [-2.228, 19.775], [3.734, 20.447], [8.19, -19.103]]);
      translate([8.943, 1.008]) circle(r = 10);
    }
    hull() {
      translate([8.943, 1.008]) circle(r = 10);
      translate([6.676, 0.752]) circle(r = 10);
    }
    hull() {
      translate([6.676, 0.752]) circle(r = 10);
      translate([13.017, 2.971]) circle(r = 10);
    }
    hull() {
      translate([13.017, 2.971]) circle(r = 10);
      translate([18.705, 6.545]) circle(r = 10);
    }
    hull() {
      translate([18.705, 6.545]) circle(r = 10);
      translate([23.455, 11.295]) circle(r = 10);
    }
    hull() {
      translate([23.455, 11.295]) circle(r = 10);
      translate([27.029, 16.983]) circle(r = 10);
    }
    hull() {
      translate([27.029, 16.983]) circle(r = 10);
      translate([29.248, 23.324]) circle(r = 10);
    }
    hull() {
      translate([29.248, 23.324]) circle(r = 10);
      translate([28.992, 21.057]) circle(r = 10);
    }
    hull() {
      translate([28.992, 21.057]) circle(r = 10);
      polygon([[10.225, 32.228], [49.775, 27.772], [49.103, 21.81], [9.553, 26.266]]);
    }
  }
  /* air passage: the same chain inset by the wall, 5 mm proud of the ports */
  translate([0, 0, 4]) linear_extrude(height = 36) {
    hull() {
      translate([-4.969, -0.56]) circle(r = 6);
      translate([6.676, 0.752]) circle(r = 6);
    }
    hull() {
      translate([6.676, 0.752]) circle(r = 6);
      translate([13.017, 2.971]) circle(r = 6);
    }
    hull() {
      translate([13.017, 2.971]) circle(r = 6);
      translate([18.705, 6.545]) circle(r = 6);
    }
    hull() {
      translate([18.705, 6.545]) circle(r = 6);
      translate([23.455, 11.295]) circle(r = 6);
    }
    hull() {
      translate([23.455, 11.295]) circle(r = 6);
      translate([27.029, 16.983]) circle(r = 6);
    }
    hull() {
      translate([27.029, 16.983]) circle(r = 6);
      translate([29.248, 23.324]) circle(r = 6);
    }
    hull() {
      translate([29.248, 23.324]) circle(r = 6);
      translate([30.56, 34.969]) circle(r = 6);
    }
  }
  translate([0, 0]) rotate([0, 0, -83.57]) translate([-14.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 11, d = 5.4);
  translate([0, 0]) rotate([0, 0, -83.57]) translate([14.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 11, d = 5.4);
  translate([30, 30]) rotate([0, 0, 173.57]) translate([-14.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 11, d = 5.4);
  translate([30, 30]) rotate([0, 0, 173.57]) translate([14.7, -2.5]) rotate([-90, 0, 0]) cylinder(h = 11, d = 5.4);
}
