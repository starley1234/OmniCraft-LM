$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 40, 30, 20 mm, 70 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 40;                  // step 1 diameter
len1 = 40;                // step 1 length
d2 = 30;                  // step 2 diameter
len2 = 20;                // step 2 length
d3 = 20;                  // step 3 diameter
len3 = 10;                // step 3 length
total = 70;               // overall length
chamfer = 1.5;            // end chamfer
cross_d = 4;              // cross pin hole
cross_z = 65;             // cross hole position

difference() {
  /* turned body: stacked cylinders, every step sunk into the bigger one */
  union() {
    cylinder(h = len1, d = d1);
    translate([0, 0, 39.6]) cylinder(h = 20.4, d = d2);
    translate([0, 0, 59.6]) cylinder(h = 10.4, d = d3);
  }
  /* bottom chamfer ring cut */
  rotate_extrude() translate([18.5, -2.5]) polygon([[0, 0], [4, 0], [4, 6.5], [0, 2.5]]);
  /* top chamfer ring cut */
  rotate_extrude() translate([8.5, 70]) polygon([[0, 0], [4, -4], [4, 2.5], [0, 2.5]]);
  /* cross pin hole through the small step */
  translate([0, 0, cross_z]) rotate([90, 0, 0]) cylinder(h = d3 + 5, d = cross_d, center = true);
}
