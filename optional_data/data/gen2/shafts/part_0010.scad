$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 20, 14, 10 mm, 50 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 20;                  // step 1 diameter
len1 = 15;                // step 1 length
d2 = 14;                  // step 2 diameter
len2 = 15;                // step 2 length
d3 = 10;                  // step 3 diameter
len3 = 20;                // step 3 length
total = 50;               // overall length
chamfer = 1.6;            // end chamfer
groove_r = 5;             // groove radius
groove_z = 32;            // groove position from the end
groove_w = 3;             // groove width
groove_d = 1;             // groove depth
cross_d = 5;              // cross pin hole
cross_z = 7.5;            // cross hole position

difference() {
  /* turned body: stacked cylinders, every step sunk into the bigger one */
  union() {
    cylinder(h = len1, d = d1);
    translate([0, 0, 14.6]) cylinder(h = 15.4, d = d2);
    translate([0, 0, 29.6]) cylinder(h = 20.4, d = d3);
  }
  /* bottom chamfer ring cut */
  rotate_extrude() translate([8.4, -2.5]) polygon([[0, 0], [4.1, 0], [4.1, 6.6], [0, 2.5]]);
  /* top chamfer ring cut */
  rotate_extrude() translate([3.4, 50]) polygon([[0, 0], [4.1, -4.1], [4.1, 2.5], [0, 2.5]]);
  /* circlip groove just behind the shoulder */
  rotate_extrude() translate([groove_r - groove_d, groove_z]) square([groove_d + 2.5, groove_w]);
  /* cross pin hole through the small step */
  translate([0, 0, cross_z]) rotate([90, 0, 0]) cylinder(h = d1 + 5, d = cross_d, center = true);
}
