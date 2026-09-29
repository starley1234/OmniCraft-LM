$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 20, 16, 12, 10 mm, 85 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 20;                  // step 1 diameter
len1 = 25;                // step 1 length
d2 = 16;                  // step 2 diameter
len2 = 25;                // step 2 length
d3 = 12;                  // step 3 diameter
len3 = 25;                // step 3 length
d4 = 10;                  // step 4 diameter
len4 = 10;                // step 4 length
total = 85;               // overall length
chamfer = 1.6;            // end chamfer
key_w = 6;                // keyway width
key_d = 3;                // keyway depth
key_len = 17.4;           // keyway length
key_z = 3.6;              // keyway start along the shaft

difference() {
  /* turned body: stacked cylinders, every step sunk into the bigger one */
  union() {
    cylinder(h = len1, d = d1);
    translate([0, 0, 24.6]) cylinder(h = 25.4, d = d2);
    translate([0, 0, 49.6]) cylinder(h = 25.4, d = d3);
    translate([0, 0, 74.6]) cylinder(h = 10.4, d = d4);
  }
  /* bottom chamfer ring cut */
  rotate_extrude() translate([8.4, -2.5]) polygon([[0, 0], [4.1, 0], [4.1, 6.6], [0, 2.5]]);
  /* top chamfer ring cut */
  rotate_extrude() translate([3.4, 85]) polygon([[0, 0], [4.1, -4.1], [4.1, 2.5], [0, 2.5]]);
  /* keyway milled along the first step */
  translate([d1 / 2 - key_d, -key_w / 2, key_z]) cube([key_d + 2.5, key_w, key_len]);
}
