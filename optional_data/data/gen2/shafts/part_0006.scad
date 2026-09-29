$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 25, 14, 10 mm, 80 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 25;                  // step 1 diameter
len1 = 30;                // step 1 length
d2 = 14;                  // step 2 diameter
len2 = 10;                // step 2 length
d3 = 10;                  // step 3 diameter
len3 = 40;                // step 3 length
total = 80;               // overall length
chamfer = 2;              // end chamfer
groove_r = 7;             // groove radius
groove_z = 32;            // groove position from the end
groove_w = 3.5;           // groove width
groove_d = 1.3;           // groove depth
key_w = 4;                // keyway width
key_d = 2;                // keyway depth
key_len = 22;             // keyway length
key_z = 4;                // keyway start along the shaft

difference() {
  /* turned body: stacked cylinders, every step sunk into the bigger one */
  union() {
    cylinder(h = len1, d = d1);
    translate([0, 0, 29.6]) cylinder(h = 10.4, d = d2);
    translate([0, 0, 39.6]) cylinder(h = 40.4, d = d3);
  }
  /* bottom chamfer ring cut */
  rotate_extrude() translate([10.5, -2.5]) polygon([[0, 0], [4.5, 0], [4.5, 7], [0, 2.5]]);
  /* top chamfer ring cut */
  rotate_extrude() translate([3, 80]) polygon([[0, 0], [4.5, -4.5], [4.5, 2.5], [0, 2.5]]);
  /* circlip groove just behind the shoulder */
  rotate_extrude() translate([groove_r - groove_d, groove_z]) square([groove_d + 2.5, groove_w]);
  /* keyway milled along the first step */
  translate([d1 / 2 - key_d, -key_w / 2, key_z]) cube([key_d + 2.5, key_w, key_len]);
}
