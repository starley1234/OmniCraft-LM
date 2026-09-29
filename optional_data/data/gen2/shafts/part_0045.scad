$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 40, 16, 10 mm, 90 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 40;                  // step 1 diameter
len1 = 30;                // step 1 length
d2 = 16;                  // step 2 diameter
len2 = 30;                // step 2 length
d3 = 10;                  // step 3 diameter
len3 = 30;                // step 3 length
total = 90;               // overall length
chamfer = 2.5;            // end chamfer
key_w = 4;                // keyway width
key_d = 2;                // keyway depth
key_len = 21.5;           // keyway length
key_z = 4.5;              // keyway start along the shaft
cross_d = 6;              // cross pin hole
cross_z = 75;             // cross hole position

difference() {
  /* turned body: stacked cylinders, every step sunk into the bigger one */
  union() {
    cylinder(h = len1, d = d1);
    translate([0, 0, 29.6]) cylinder(h = 30.4, d = d2);
    translate([0, 0, 59.6]) cylinder(h = 30.4, d = d3);
  }
  /* bottom chamfer ring cut */
  rotate_extrude() translate([17.5, -2.5]) polygon([[0, 0], [5, 0], [5, 7.5], [0, 2.5]]);
  /* top chamfer ring cut */
  rotate_extrude() translate([2.5, 90]) polygon([[0, 0], [5, -5], [5, 2.5], [0, 2.5]]);
  /* keyway milled along the first step */
  translate([d1 / 2 - key_d, -key_w / 2, key_z]) cube([key_d + 2.5, key_w, key_len]);
  /* cross pin hole through the small step */
  translate([0, 0, cross_z]) rotate([90, 0, 0]) cylinder(h = d3 + 5, d = cross_d, center = true);
}
