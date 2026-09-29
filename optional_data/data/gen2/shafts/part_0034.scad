$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 25, 20, 12, 8 mm, 105 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 25;                  // step 1 diameter
len1 = 40;                // step 1 length
d2 = 20;                  // step 2 diameter
len2 = 20;                // step 2 length
d3 = 12;                  // step 3 diameter
len3 = 30;                // step 3 length
d4 = 8;                   // step 4 diameter
len4 = 15;                // step 4 length
total = 105;              // overall length
chamfer = 2;              // end chamfer
cross_d = 4;              // cross pin hole
cross_z = 97.5;           // cross hole position

difference() {
  /* turned body: stacked cylinders, every step sunk into the bigger one */
  union() {
    cylinder(h = len1, d = d1);
    translate([0, 0, 39.6]) cylinder(h = 20.4, d = d2);
    translate([0, 0, 59.6]) cylinder(h = 30.4, d = d3);
    translate([0, 0, 89.6]) cylinder(h = 15.4, d = d4);
  }
  /* bottom chamfer ring cut */
  rotate_extrude() translate([10.5, -2.5]) polygon([[0, 0], [4.5, 0], [4.5, 7], [0, 2.5]]);
  /* top chamfer ring cut */
  rotate_extrude() translate([2, 105]) polygon([[0, 0], [4.5, -4.5], [4.5, 2.5], [0, 2.5]]);
  /* cross pin hole through the small step */
  translate([0, 0, cross_z]) rotate([90, 0, 0]) cylinder(h = d4 + 5, d = cross_d, center = true);
}
