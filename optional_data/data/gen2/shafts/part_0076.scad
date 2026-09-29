$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 30, 25, 20, 16, 8 mm, 140 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 30;                  // step 1 diameter
len1 = 15;                // step 1 length
d2 = 25;                  // step 2 diameter
len2 = 20;                // step 2 length
d3 = 20;                  // step 3 diameter
len3 = 40;                // step 3 length
d4 = 16;                  // step 4 diameter
len4 = 25;                // step 4 length
d5 = 8;                   // step 5 diameter
len5 = 40;                // step 5 length
total = 140;              // overall length
chamfer = 1.5;            // end chamfer
cross_d = 4;              // cross pin hole
cross_z = 120;            // cross hole position

difference() {
  /* turned body: stacked cylinders, every step sunk into the bigger one */
  union() {
    cylinder(h = len1, d = d1);
    translate([0, 0, 14.6]) cylinder(h = 20.4, d = d2);
    translate([0, 0, 34.6]) cylinder(h = 40.4, d = d3);
    translate([0, 0, 74.6]) cylinder(h = 25.4, d = d4);
    translate([0, 0, 99.6]) cylinder(h = 40.4, d = d5);
  }
  /* bottom chamfer ring cut */
  rotate_extrude() translate([13.5, -2.5]) polygon([[0, 0], [4, 0], [4, 6.5], [0, 2.5]]);
  /* top chamfer ring cut */
  rotate_extrude() translate([2.5, 140]) polygon([[0, 0], [4, -4], [4, 2.5], [0, 2.5]]);
  /* cross pin hole through the small step */
  translate([0, 0, cross_z]) rotate([90, 0, 0]) cylinder(h = d5 + 5, d = cross_d, center = true);
}
