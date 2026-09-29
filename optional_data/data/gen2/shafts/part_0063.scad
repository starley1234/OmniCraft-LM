$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 30, 20, 12, 10, 8 mm, 115 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 30;                  // step 1 diameter
len1 = 20;                // step 1 length
d2 = 20;                  // step 2 diameter
len2 = 15;                // step 2 length
d3 = 12;                  // step 3 diameter
len3 = 25;                // step 3 length
d4 = 10;                  // step 4 diameter
len4 = 15;                // step 4 length
d5 = 8;                   // step 5 diameter
len5 = 40;                // step 5 length
total = 115;              // overall length
chamfer = 2;              // end chamfer
groove_r = 6;             // groove radius
groove_z = 37;            // groove position from the end
groove_w = 2;             // groove width
groove_d = 1.6;           // groove depth
key_w = 5;                // keyway width
key_d = 2.5;              // keyway depth
key_len = 12;             // keyway length
key_z = 4;                // keyway start along the shaft

difference() {
  /* turned body: stacked cylinders, every step sunk into the bigger one */
  union() {
    cylinder(h = len1, d = d1);
    translate([0, 0, 19.6]) cylinder(h = 15.4, d = d2);
    translate([0, 0, 34.6]) cylinder(h = 25.4, d = d3);
    translate([0, 0, 59.6]) cylinder(h = 15.4, d = d4);
    translate([0, 0, 74.6]) cylinder(h = 40.4, d = d5);
  }
  /* bottom chamfer ring cut */
  rotate_extrude() translate([13, -2.5]) polygon([[0, 0], [4.5, 0], [4.5, 7], [0, 2.5]]);
  /* top chamfer ring cut */
  rotate_extrude() translate([2, 115]) polygon([[0, 0], [4.5, -4.5], [4.5, 2.5], [0, 2.5]]);
  /* circlip groove just behind the shoulder */
  rotate_extrude() translate([groove_r - groove_d, groove_z]) square([groove_d + 2.5, groove_w]);
  /* keyway milled along the first step */
  translate([d1 / 2 - key_d, -key_w / 2, key_z]) cube([key_d + 2.5, key_w, key_len]);
}
