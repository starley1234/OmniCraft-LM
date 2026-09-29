$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 50, 40, 20 mm, 60 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 50;                  // step 1 diameter
len1 = 10;                // step 1 length
d2 = 40;                  // step 2 diameter
len2 = 40;                // step 2 length
d3 = 20;                  // step 3 diameter
len3 = 10;                // step 3 length
total = 60;               // overall length
chamfer = 1;              // end chamfer
cross_d = 4;              // cross pin hole
cross_z = 55;             // cross hole position

difference() {
  /* turned body: stacked cylinders, every step sunk into the bigger one */
  union() {
    cylinder(h = len1, d = d1);
    translate([0, 0, 9.6]) cylinder(h = 40.4, d = d2);
    translate([0, 0, 49.6]) cylinder(h = 10.4, d = d3);
  }
  /* bottom chamfer ring cut */
  rotate_extrude() translate([24, -2.5]) polygon([[0, 0], [3.5, 0], [3.5, 6], [0, 2.5]]);
  /* top chamfer ring cut */
  rotate_extrude() translate([9, 60]) polygon([[0, 0], [3.5, -3.5], [3.5, 2.5], [0, 2.5]]);
  /* cross pin hole through the small step */
  translate([0, 0, cross_z]) rotate([90, 0, 0]) cylinder(h = d3 + 5, d = cross_d, center = true);
}
