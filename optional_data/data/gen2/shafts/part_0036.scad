$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 25, 16, 12 mm, 80 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 25;                  // step 1 diameter
len1 = 30;                // step 1 length
d2 = 16;                  // step 2 diameter
len2 = 30;                // step 2 length
d3 = 12;                  // step 3 diameter
len3 = 20;                // step 3 length
total = 80;               // overall length
chamfer = 1;              // end chamfer
groove_r = 6;             // groove radius
groove_z = 62;            // groove position from the end
groove_w = 3;             // groove width
groove_d = 1.6;           // groove depth
key_w = 8;                // keyway width
key_d = 4;                // keyway depth
key_len = 23;             // keyway length
key_z = 3;                // keyway start along the shaft

difference() {
  /* turned body: stacked cylinders, every step sunk into the bigger one */
  union() {
    cylinder(h = len1, d = d1);
    translate([0, 0, 29.6]) cylinder(h = 30.4, d = d2);
    translate([0, 0, 59.6]) cylinder(h = 20.4, d = d3);
  }
  /* bottom chamfer ring cut */
  rotate_extrude() translate([11.5, -2.5]) polygon([[0, 0], [3.5, 0], [3.5, 6], [0, 2.5]]);
  /* top chamfer ring cut */
  rotate_extrude() translate([5, 80]) polygon([[0, 0], [3.5, -3.5], [3.5, 2.5], [0, 2.5]]);
  /* circlip groove just behind the shoulder */
  rotate_extrude() translate([groove_r - groove_d, groove_z]) square([groove_d + 2.5, groove_w]);
  /* keyway milled along the first step */
  translate([d1 / 2 - key_d, -key_w / 2, key_z]) cube([key_d + 2.5, key_w, key_len]);
}
