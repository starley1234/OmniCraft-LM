$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 20, 16, 14, 12 mm, 110 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 20;                  // step 1 diameter
len1 = 25;                // step 1 length
d2 = 16;                  // step 2 diameter
len2 = 40;                // step 2 length
d3 = 14;                  // step 3 diameter
len3 = 25;                // step 3 length
d4 = 12;                  // step 4 diameter
len4 = 20;                // step 4 length
total = 110;              // overall length
chamfer = 1;              // end chamfer
key_w = 4;                // keyway width
key_d = 2;                // keyway depth
key_len = 18;             // keyway length
key_z = 3;                // keyway start along the shaft
cross_d = 6;              // cross pin hole
cross_z = 100;            // cross hole position

difference() {
  /* turned body: stacked cylinders, every step sunk into the bigger one */
  union() {
    cylinder(h = len1, d = d1);
    translate([0, 0, 24.6]) cylinder(h = 40.4, d = d2);
    translate([0, 0, 64.6]) cylinder(h = 25.4, d = d3);
    translate([0, 0, 89.6]) cylinder(h = 20.4, d = d4);
  }
  /* bottom chamfer ring cut */
  rotate_extrude() translate([9, -2.5]) polygon([[0, 0], [3.5, 0], [3.5, 6], [0, 2.5]]);
  /* top chamfer ring cut */
  rotate_extrude() translate([5, 110]) polygon([[0, 0], [3.5, -3.5], [3.5, 2.5], [0, 2.5]]);
  /* keyway milled along the first step */
  translate([d1 / 2 - key_d, -key_w / 2, key_z]) cube([key_d + 2.5, key_w, key_len]);
  /* cross pin hole through the small step */
  translate([0, 0, cross_z]) rotate([90, 0, 0]) cylinder(h = d4 + 5, d = cross_d, center = true);
}
