$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 25, 12, 10 mm, 60 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 25;                  // step 1 diameter
len1 = 30;                // step 1 length
d2 = 12;                  // step 2 diameter
len2 = 15;                // step 2 length
d3 = 10;                  // step 3 diameter
len3 = 15;                // step 3 length
total = 60;               // overall length
chamfer = 1;              // end chamfer
cross_d = 6;              // cross pin hole
cross_z = 52.5;           // cross hole position

difference() {
  /* turned body: stacked cylinders, every step sunk into the bigger one */
  union() {
    cylinder(h = len1, d = d1);
    translate([0, 0, 29.6]) cylinder(h = 15.4, d = d2);
    translate([0, 0, 44.6]) cylinder(h = 15.4, d = d3);
  }
  /* bottom chamfer ring cut */
  rotate_extrude() translate([11.5, -2.5]) polygon([[0, 0], [3.5, 0], [3.5, 6], [0, 2.5]]);
  /* top chamfer ring cut */
  rotate_extrude() translate([4, 60]) polygon([[0, 0], [3.5, -3.5], [3.5, 2.5], [0, 2.5]]);
  /* cross pin hole through the small step */
  translate([0, 0, cross_z]) rotate([90, 0, 0]) cylinder(h = d3 + 5, d = cross_d, center = true);
}
