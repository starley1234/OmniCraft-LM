$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 30, 25, 20, 16, 12 mm, 140 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 30;                  // step 1 diameter
len1 = 20;                // step 1 length
d2 = 25;                  // step 2 diameter
len2 = 30;                // step 2 length
d3 = 20;                  // step 3 diameter
len3 = 30;                // step 3 length
d4 = 16;                  // step 4 diameter
len4 = 20;                // step 4 length
d5 = 12;                  // step 5 diameter
len5 = 40;                // step 5 length
total = 140;              // overall length
chamfer = 2.4;            // end chamfer
groove_r = 10;            // groove radius
groove_z = 52;            // groove position from the end
groove_w = 2;             // groove width
groove_d = 1;             // groove depth
cross_d = 6;              // cross pin hole
cross_z = 120;            // cross hole position

difference() {
  /* turned body: stacked cylinders, every step sunk into the bigger one */
  union() {
    cylinder(h = len1, d = d1);
    translate([0, 0, 19.6]) cylinder(h = 30.4, d = d2);
    translate([0, 0, 49.6]) cylinder(h = 30.4, d = d3);
    translate([0, 0, 79.6]) cylinder(h = 20.4, d = d4);
    translate([0, 0, 99.6]) cylinder(h = 40.4, d = d5);
  }
  /* bottom chamfer ring cut */
  rotate_extrude() translate([12.6, -2.5]) polygon([[0, 0], [4.9, 0], [4.9, 7.4], [0, 2.5]]);
  /* top chamfer ring cut */
  rotate_extrude() translate([3.6, 140]) polygon([[0, 0], [4.9, -4.9], [4.9, 2.5], [0, 2.5]]);
  /* circlip groove just behind the shoulder */
  rotate_extrude() translate([groove_r - groove_d, groove_z]) square([groove_d + 2.5, groove_w]);
  /* cross pin hole through the small step */
  translate([0, 0, cross_z]) rotate([90, 0, 0]) cylinder(h = d5 + 5, d = cross_d, center = true);
}
