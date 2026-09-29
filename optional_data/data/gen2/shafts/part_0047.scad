$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 50, 20, 10 mm, 60 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 50;                  // step 1 diameter
len1 = 25;                // step 1 length
d2 = 20;                  // step 2 diameter
len2 = 15;                // step 2 length
d3 = 10;                  // step 3 diameter
len3 = 20;                // step 3 length
total = 60;               // overall length
chamfer = 1.5;            // end chamfer
key_w = 6;                // keyway width
key_d = 3;                // keyway depth
key_len = 17.5;           // keyway length
key_z = 3.5;              // keyway start along the shaft

difference() {
  /* turned body: stacked cylinders, every step sunk into the bigger one */
  union() {
    cylinder(h = len1, d = d1);
    translate([0, 0, 24.6]) cylinder(h = 15.4, d = d2);
    translate([0, 0, 39.6]) cylinder(h = 20.4, d = d3);
  }
  /* bottom chamfer ring cut */
  rotate_extrude() translate([23.5, -2.5]) polygon([[0, 0], [4, 0], [4, 6.5], [0, 2.5]]);
  /* top chamfer ring cut */
  rotate_extrude() translate([3.5, 60]) polygon([[0, 0], [4, -4], [4, 2.5], [0, 2.5]]);
  /* keyway milled along the first step */
  translate([d1 / 2 - key_d, -key_w / 2, key_z]) cube([key_d + 2.5, key_w, key_len]);
}
