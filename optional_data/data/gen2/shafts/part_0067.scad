$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 25, 20, 12, 10 mm, 105 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 25;                  // step 1 diameter
len1 = 20;                // step 1 length
d2 = 20;                  // step 2 diameter
len2 = 25;                // step 2 length
d3 = 12;                  // step 3 diameter
len3 = 30;                // step 3 length
d4 = 10;                  // step 4 diameter
len4 = 30;                // step 4 length
total = 105;              // overall length
chamfer = 1.5;            // end chamfer
cross_d = 4;              // cross pin hole
cross_z = 90;             // cross hole position

difference() {
  /* turned body: stacked cylinders, every step sunk into the bigger one */
  union() {
    cylinder(h = len1, d = d1);
    translate([0, 0, 19.6]) cylinder(h = 25.4, d = d2);
    translate([0, 0, 44.6]) cylinder(h = 30.4, d = d3);
    translate([0, 0, 74.6]) cylinder(h = 30.4, d = d4);
  }
  /* bottom chamfer ring cut */
  rotate_extrude() translate([11, -2.5]) polygon([[0, 0], [4, 0], [4, 6.5], [0, 2.5]]);
  /* top chamfer ring cut */
  rotate_extrude() translate([3.5, 105]) polygon([[0, 0], [4, -4], [4, 2.5], [0, 2.5]]);
  /* cross pin hole through the small step */
  translate([0, 0, cross_z]) rotate([90, 0, 0]) cylinder(h = d4 + 5, d = cross_d, center = true);
}
