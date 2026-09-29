$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 20, 14, 10 mm, 85 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 20;                  // step 1 diameter
len1 = 40;                // step 1 length
d2 = 14;                  // step 2 diameter
len2 = 30;                // step 2 length
d3 = 10;                  // step 3 diameter
len3 = 15;                // step 3 length
total = 85;               // overall length
chamfer = 1;              // end chamfer
key_w = 8;                // keyway width
key_d = 4;                // keyway depth
key_len = 25;             // keyway length
key_z = 3;                // keyway start along the shaft

difference() {
  /* turned body: stacked cylinders, every step sunk into the bigger one */
  union() {
    cylinder(h = len1, d = d1);
    translate([0, 0, 39.6]) cylinder(h = 30.4, d = d2);
    translate([0, 0, 69.6]) cylinder(h = 15.4, d = d3);
  }
  /* bottom chamfer ring cut */
  rotate_extrude() translate([9, -2.5]) polygon([[0, 0], [3.5, 0], [3.5, 6], [0, 2.5]]);
  /* top chamfer ring cut */
  rotate_extrude() translate([4, 85]) polygon([[0, 0], [3.5, -3.5], [3.5, 2.5], [0, 2.5]]);
  /* keyway milled along the first step */
  translate([d1 / 2 - key_d, -key_w / 2, key_z]) cube([key_d + 2.5, key_w, key_len]);
}
