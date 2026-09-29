$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 50, 30, 25, 16, 8 mm, 130 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 50;                  // step 1 diameter
len1 = 20;                // step 1 length
d2 = 30;                  // step 2 diameter
len2 = 10;                // step 2 length
d3 = 25;                  // step 3 diameter
len3 = 30;                // step 3 length
d4 = 16;                  // step 4 diameter
len4 = 40;                // step 4 length
d5 = 8;                   // step 5 diameter
len5 = 30;                // step 5 length
total = 130;              // overall length
chamfer = 1;              // end chamfer
groove_r = 12.5;          // groove radius
groove_z = 32;            // groove position from the end
groove_w = 2;             // groove width
groove_d = 2;             // groove depth
key_w = 6;                // keyway width
key_d = 3;                // keyway depth
key_len = 13;             // keyway length
key_z = 3;                // keyway start along the shaft
cross_d = 4;              // cross pin hole
cross_z = 115;            // cross hole position

difference() {
  /* turned body: stacked cylinders, every step sunk into the bigger one */
  union() {
    cylinder(h = len1, d = d1);
    translate([0, 0, 19.6]) cylinder(h = 10.4, d = d2);
    translate([0, 0, 29.6]) cylinder(h = 30.4, d = d3);
    translate([0, 0, 59.6]) cylinder(h = 40.4, d = d4);
    translate([0, 0, 99.6]) cylinder(h = 30.4, d = d5);
  }
  /* bottom chamfer ring cut */
  rotate_extrude() translate([24, -2.5]) polygon([[0, 0], [3.5, 0], [3.5, 6], [0, 2.5]]);
  /* top chamfer ring cut */
  rotate_extrude() translate([3, 130]) polygon([[0, 0], [3.5, -3.5], [3.5, 2.5], [0, 2.5]]);
  /* circlip groove just behind the shoulder */
  rotate_extrude() translate([groove_r - groove_d, groove_z]) square([groove_d + 2.5, groove_w]);
  /* keyway milled along the first step */
  translate([d1 / 2 - key_d, -key_w / 2, key_z]) cube([key_d + 2.5, key_w, key_len]);
  /* cross pin hole through the small step */
  translate([0, 0, cross_z]) rotate([90, 0, 0]) cylinder(h = d5 + 5, d = cross_d, center = true);
}
