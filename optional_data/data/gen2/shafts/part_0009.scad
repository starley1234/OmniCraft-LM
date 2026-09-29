$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 40, 30, 14, 12, 8 mm, 115 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 40;                  // step 1 diameter
len1 = 30;                // step 1 length
d2 = 30;                  // step 2 diameter
len2 = 20;                // step 2 length
d3 = 14;                  // step 3 diameter
len3 = 20;                // step 3 length
d4 = 12;                  // step 4 diameter
len4 = 30;                // step 4 length
d5 = 8;                   // step 5 diameter
len5 = 15;                // step 5 length
total = 115;              // overall length
chamfer = 1;              // end chamfer
key_w = 6;                // keyway width
key_d = 3;                // keyway depth
key_len = 23;             // keyway length
key_z = 3;                // keyway start along the shaft
cross_d = 4;              // cross pin hole
cross_z = 107.5;          // cross hole position

difference() {
  /* turned body: stacked cylinders, every step sunk into the bigger one */
  union() {
    cylinder(h = len1, d = d1);
    translate([0, 0, 29.6]) cylinder(h = 20.4, d = d2);
    translate([0, 0, 49.6]) cylinder(h = 20.4, d = d3);
    translate([0, 0, 69.6]) cylinder(h = 30.4, d = d4);
    translate([0, 0, 99.6]) cylinder(h = 15.4, d = d5);
  }
  /* bottom chamfer ring cut */
  rotate_extrude() translate([19, -2.5]) polygon([[0, 0], [3.5, 0], [3.5, 6], [0, 2.5]]);
  /* top chamfer ring cut */
  rotate_extrude() translate([3, 115]) polygon([[0, 0], [3.5, -3.5], [3.5, 2.5], [0, 2.5]]);
  /* keyway milled along the first step */
  translate([d1 / 2 - key_d, -key_w / 2, key_z]) cube([key_d + 2.5, key_w, key_len]);
  /* cross pin hole through the small step */
  translate([0, 0, cross_z]) rotate([90, 0, 0]) cylinder(h = d5 + 5, d = cross_d, center = true);
}
