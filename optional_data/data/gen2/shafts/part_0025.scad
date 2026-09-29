$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 25, 16, 14, 8 mm, 125 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 25;                  // step 1 diameter
len1 = 40;                // step 1 length
d2 = 16;                  // step 2 diameter
len2 = 30;                // step 2 length
d3 = 14;                  // step 3 diameter
len3 = 15;                // step 3 length
d4 = 8;                   // step 4 diameter
len4 = 40;                // step 4 length
total = 125;              // overall length
chamfer = 1;              // end chamfer
cross_d = 4;              // cross pin hole
cross_z = 105;            // cross hole position

difference() {
  /* turned body: stacked cylinders, every step sunk into the bigger one */
  union() {
    cylinder(h = len1, d = d1);
    translate([0, 0, 39.6]) cylinder(h = 30.4, d = d2);
    translate([0, 0, 69.6]) cylinder(h = 15.4, d = d3);
    translate([0, 0, 84.6]) cylinder(h = 40.4, d = d4);
  }
  /* bottom chamfer ring cut */
  rotate_extrude() translate([11.5, -2.5]) polygon([[0, 0], [3.5, 0], [3.5, 6], [0, 2.5]]);
  /* top chamfer ring cut */
  rotate_extrude() translate([3, 125]) polygon([[0, 0], [3.5, -3.5], [3.5, 2.5], [0, 2.5]]);
  /* cross pin hole through the small step */
  translate([0, 0, cross_z]) rotate([90, 0, 0]) cylinder(h = d4 + 5, d = cross_d, center = true);
}
