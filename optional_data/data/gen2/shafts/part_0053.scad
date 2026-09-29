$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 40, 30, 14, 10, 8 mm, 130 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 40;                  // step 1 diameter
len1 = 25;                // step 1 length
d2 = 30;                  // step 2 diameter
len2 = 30;                // step 2 length
d3 = 14;                  // step 3 diameter
len3 = 40;                // step 3 length
d4 = 10;                  // step 4 diameter
len4 = 10;                // step 4 length
d5 = 8;                   // step 5 diameter
len5 = 25;                // step 5 length
total = 130;              // overall length
chamfer = 2.5;            // end chamfer
key_w = 5;                // keyway width
key_d = 2.5;              // keyway depth
key_len = 16.5;           // keyway length
key_z = 4.5;              // keyway start along the shaft
cross_d = 4;              // cross pin hole
cross_z = 117.5;          // cross hole position

difference() {
  /* turned body: stacked cylinders, every step sunk into the bigger one */
  union() {
    cylinder(h = len1, d = d1);
    translate([0, 0, 24.6]) cylinder(h = 30.4, d = d2);
    translate([0, 0, 54.6]) cylinder(h = 40.4, d = d3);
    translate([0, 0, 94.6]) cylinder(h = 10.4, d = d4);
    translate([0, 0, 104.6]) cylinder(h = 25.4, d = d5);
  }
  /* bottom chamfer ring cut */
  rotate_extrude() translate([17.5, -2.5]) polygon([[0, 0], [5, 0], [5, 7.5], [0, 2.5]]);
  /* top chamfer ring cut */
  rotate_extrude() translate([1.5, 130]) polygon([[0, 0], [5, -5], [5, 2.5], [0, 2.5]]);
  /* keyway milled along the first step */
  translate([d1 / 2 - key_d, -key_w / 2, key_z]) cube([key_d + 2.5, key_w, key_len]);
  /* cross pin hole through the small step */
  translate([0, 0, cross_z]) rotate([90, 0, 0]) cylinder(h = d5 + 5, d = cross_d, center = true);
}
