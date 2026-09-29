$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 50, 20, 14, 10 mm, 125 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 50;                  // step 1 diameter
len1 = 30;                // step 1 length
d2 = 20;                  // step 2 diameter
len2 = 30;                // step 2 length
d3 = 14;                  // step 3 diameter
len3 = 40;                // step 3 length
d4 = 10;                  // step 4 diameter
len4 = 25;                // step 4 length
total = 125;              // overall length
chamfer = 1.5;            // end chamfer
groove_r = 10;            // groove radius
groove_z = 32;            // groove position from the end
groove_w = 2.5;           // groove width
groove_d = 2;             // groove depth
key_w = 5;                // keyway width
key_d = 2.5;              // keyway depth
key_len = 22.5;           // keyway length
key_z = 3.5;              // keyway start along the shaft

difference() {
  /* turned body: stacked cylinders, every step sunk into the bigger one */
  union() {
    cylinder(h = len1, d = d1);
    translate([0, 0, 29.6]) cylinder(h = 30.4, d = d2);
    translate([0, 0, 59.6]) cylinder(h = 40.4, d = d3);
    translate([0, 0, 99.6]) cylinder(h = 25.4, d = d4);
  }
  /* bottom chamfer ring cut */
  rotate_extrude() translate([23.5, -2.5]) polygon([[0, 0], [4, 0], [4, 6.5], [0, 2.5]]);
  /* top chamfer ring cut */
  rotate_extrude() translate([3.5, 125]) polygon([[0, 0], [4, -4], [4, 2.5], [0, 2.5]]);
  /* circlip groove just behind the shoulder */
  rotate_extrude() translate([groove_r - groove_d, groove_z]) square([groove_d + 2.5, groove_w]);
  /* keyway milled along the first step */
  translate([d1 / 2 - key_d, -key_w / 2, key_z]) cube([key_d + 2.5, key_w, key_len]);
}
