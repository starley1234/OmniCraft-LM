$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 40, 20, 16, 14, 12 mm, 115 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 40;                  // step 1 diameter
len1 = 30;                // step 1 length
d2 = 20;                  // step 2 diameter
len2 = 25;                // step 2 length
d3 = 16;                  // step 3 diameter
len3 = 25;                // step 3 length
d4 = 14;                  // step 4 diameter
len4 = 20;                // step 4 length
d5 = 12;                  // step 5 diameter
len5 = 15;                // step 5 length
total = 115;              // overall length
chamfer = 1.5;            // end chamfer
groove_r = 7;             // groove radius
groove_z = 82;            // groove position from the end
groove_w = 3;             // groove width
groove_d = 1.6;           // groove depth
cross_d = 6;              // cross pin hole
cross_z = 107.5;          // cross hole position

difference() {
  /* turned body: stacked cylinders, every step sunk into the bigger one */
  union() {
    cylinder(h = len1, d = d1);
    translate([0, 0, 29.6]) cylinder(h = 25.4, d = d2);
    translate([0, 0, 54.6]) cylinder(h = 25.4, d = d3);
    translate([0, 0, 79.6]) cylinder(h = 20.4, d = d4);
    translate([0, 0, 99.6]) cylinder(h = 15.4, d = d5);
  }
  /* bottom chamfer ring cut */
  rotate_extrude() translate([18.5, -2.5]) polygon([[0, 0], [4, 0], [4, 6.5], [0, 2.5]]);
  /* top chamfer ring cut */
  rotate_extrude() translate([4.5, 115]) polygon([[0, 0], [4, -4], [4, 2.5], [0, 2.5]]);
  /* circlip groove just behind the shoulder */
  rotate_extrude() translate([groove_r - groove_d, groove_z]) square([groove_d + 2.5, groove_w]);
  /* cross pin hole through the small step */
  translate([0, 0, cross_z]) rotate([90, 0, 0]) cylinder(h = d5 + 5, d = cross_d, center = true);
}
