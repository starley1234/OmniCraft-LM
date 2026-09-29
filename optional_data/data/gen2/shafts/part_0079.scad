$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 50, 25, 10 mm, 40 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 50;                  // step 1 diameter
len1 = 10;                // step 1 length
d2 = 25;                  // step 2 diameter
len2 = 20;                // step 2 length
d3 = 10;                  // step 3 diameter
len3 = 10;                // step 3 length
total = 40;               // overall length
chamfer = 2;              // end chamfer
cross_d = 6;              // cross pin hole
cross_z = 35;             // cross hole position

difference() {
  /* turned body: stacked cylinders, every step sunk into the bigger one */
  union() {
    cylinder(h = len1, d = d1);
    translate([0, 0, 9.6]) cylinder(h = 20.4, d = d2);
    translate([0, 0, 29.6]) cylinder(h = 10.4, d = d3);
  }
  /* bottom chamfer ring cut */
  rotate_extrude() translate([23, -2.5]) polygon([[0, 0], [4.5, 0], [4.5, 7], [0, 2.5]]);
  /* top chamfer ring cut */
  rotate_extrude() translate([3, 40]) polygon([[0, 0], [4.5, -4.5], [4.5, 2.5], [0, 2.5]]);
  /* cross pin hole through the small step */
  translate([0, 0, cross_z]) rotate([90, 0, 0]) cylinder(h = d3 + 5, d = cross_d, center = true);
}
