$fn = 32;
// ----------------------------------------------------------------------
// Stepped shaft: diameters 40, 10, 8 mm, 55 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 40;                  // step 1 diameter
len1 = 20;                // step 1 length
d2 = 10;                  // step 2 diameter
len2 = 25;                // step 2 length
d3 = 8;                   // step 3 diameter
len3 = 10;                // step 3 length
total = 55;               // overall length
chamfer = 2;              // end chamfer
groove_r = 4;             // groove radius
groove_z = 47;            // groove position from the end
groove_w = 3;             // groove width
groove_d = 1;             // groove depth
cross_d = 6;              // cross pin hole
cross_z = 10;             // cross hole position

difference() {
  /* turned body: stacked cylinders, every step sunk into the bigger one */
  union() {
    cylinder(h = len1, d = d1);
    translate([0, 0, 19.6]) cylinder(h = 25.4, d = d2);
    translate([0, 0, 44.6]) cylinder(h = 10.4, d = d3);
  }
  /* bottom chamfer ring cut */
  rotate_extrude() translate([18, -2.5]) polygon([[0, 0], [4.5, 0], [4.5, 7], [0, 2.5]]);
  /* top chamfer ring cut */
  rotate_extrude() translate([2, 55]) polygon([[0, 0], [4.5, -4.5], [4.5, 2.5], [0, 2.5]]);
  /* circlip groove just behind the shoulder */
  rotate_extrude() translate([groove_r - groove_d, groove_z]) square([groove_d + 2.5, groove_w]);
  /* cross pin hole through the small step */
  translate([0, 0, cross_z]) rotate([90, 0, 0]) cylinder(h = d1 + 5, d = cross_d, center = true);
}
