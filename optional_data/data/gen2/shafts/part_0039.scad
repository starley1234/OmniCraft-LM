$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 50, 16, 10 mm, 55 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 50;                  // step 1 diameter
len1 = 10;                // step 1 length
d2 = 16;                  // step 2 diameter
len2 = 20;                // step 2 length
d3 = 10;                  // step 3 diameter
len3 = 25;                // step 3 length
total = 55;               // overall length
chamfer = 1.5;            // end chamfer
groove_r = 8;             // groove radius
groove_z = 12;            // groove position from the end
groove_w = 3;             // groove width
groove_d = 2;             // groove depth
cross_d = 6;              // cross pin hole
cross_z = 42.5;           // cross hole position

difference() {
  /* turned body: stacked cylinders, every step sunk into the bigger one */
  union() {
    cylinder(h = len1, d = d1);
    translate([0, 0, 9.6]) cylinder(h = 20.4, d = d2);
    translate([0, 0, 29.6]) cylinder(h = 25.4, d = d3);
  }
  /* bottom chamfer ring cut */
  rotate_extrude() translate([23.5, -2.5]) polygon([[0, 0], [4, 0], [4, 6.5], [0, 2.5]]);
  /* top chamfer ring cut */
  rotate_extrude() translate([3.5, 55]) polygon([[0, 0], [4, -4], [4, 2.5], [0, 2.5]]);
  /* circlip groove just behind the shoulder */
  rotate_extrude() translate([groove_r - groove_d, groove_z]) square([groove_d + 2.5, groove_w]);
  /* cross pin hole through the small step */
  translate([0, 0, cross_z]) rotate([90, 0, 0]) cylinder(h = d3 + 5, d = cross_d, center = true);
}
