$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 40, 30, 14, 8 mm, 80 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 40;                  // step 1 diameter
len1 = 10;                // step 1 length
d2 = 30;                  // step 2 diameter
len2 = 10;                // step 2 length
d3 = 14;                  // step 3 diameter
len3 = 30;                // step 3 length
d4 = 8;                   // step 4 diameter
len4 = 30;                // step 4 length
total = 80;               // overall length
chamfer = 1;              // end chamfer
cross_d = 4;              // cross pin hole
cross_z = 65;             // cross hole position

difference() {
  /* turned body: stacked cylinders, every step sunk into the bigger one */
  union() {
    cylinder(h = len1, d = d1);
    translate([0, 0, 9.6]) cylinder(h = 10.4, d = d2);
    translate([0, 0, 19.6]) cylinder(h = 30.4, d = d3);
    translate([0, 0, 49.6]) cylinder(h = 30.4, d = d4);
  }
  /* bottom chamfer ring cut */
  rotate_extrude() translate([19, -2.5]) polygon([[0, 0], [3.5, 0], [3.5, 6], [0, 2.5]]);
  /* top chamfer ring cut */
  rotate_extrude() translate([3, 80]) polygon([[0, 0], [3.5, -3.5], [3.5, 2.5], [0, 2.5]]);
  /* cross pin hole through the small step */
  translate([0, 0, cross_z]) rotate([90, 0, 0]) cylinder(h = d4 + 5, d = cross_d, center = true);
}
