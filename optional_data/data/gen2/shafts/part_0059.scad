$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 30, 25, 16 mm, 55 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 30;                  // step 1 diameter
len1 = 25;                // step 1 length
d2 = 25;                  // step 2 diameter
len2 = 10;                // step 2 length
d3 = 16;                  // step 3 diameter
len3 = 20;                // step 3 length
total = 55;               // overall length
chamfer = 2.4;            // end chamfer
key_w = 6;                // keyway width
key_d = 3;                // keyway depth
key_len = 16.6;           // keyway length
key_z = 4.4;              // keyway start along the shaft
cross_d = 8;              // cross pin hole
cross_z = 45;             // cross hole position

difference() {
  /* turned body: stacked cylinders, every step sunk into the bigger one */
  union() {
    cylinder(h = len1, d = d1);
    translate([0, 0, 24.6]) cylinder(h = 10.4, d = d2);
    translate([0, 0, 34.6]) cylinder(h = 20.4, d = d3);
  }
  /* bottom chamfer ring cut */
  rotate_extrude() translate([12.6, -2.5]) polygon([[0, 0], [4.9, 0], [4.9, 7.4], [0, 2.5]]);
  /* top chamfer ring cut */
  rotate_extrude() translate([5.6, 55]) polygon([[0, 0], [4.9, -4.9], [4.9, 2.5], [0, 2.5]]);
  /* keyway milled along the first step */
  translate([d1 / 2 - key_d, -key_w / 2, key_z]) cube([key_d + 2.5, key_w, key_len]);
  /* cross pin hole through the small step */
  translate([0, 0, cross_z]) rotate([90, 0, 0]) cylinder(h = d3 + 5, d = cross_d, center = true);
}
