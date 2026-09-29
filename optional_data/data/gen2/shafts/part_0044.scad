$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 50, 25, 20 mm, 50 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 50;                  // step 1 diameter
len1 = 25;                // step 1 length
d2 = 25;                  // step 2 diameter
len2 = 10;                // step 2 length
d3 = 20;                  // step 3 diameter
len3 = 15;                // step 3 length
total = 50;               // overall length
chamfer = 1;              // end chamfer
groove_r = 12.5;          // groove radius
groove_z = 27;            // groove position from the end
groove_w = 3;             // groove width
groove_d = 2;             // groove depth
cross_d = 8;              // cross pin hole
cross_z = 42.5;           // cross hole position

difference() {
  /* turned body: stacked cylinders, every step sunk into the bigger one */
  union() {
    cylinder(h = len1, d = d1);
    translate([0, 0, 24.6]) cylinder(h = 10.4, d = d2);
    translate([0, 0, 34.6]) cylinder(h = 15.4, d = d3);
  }
  /* bottom chamfer ring cut */
  rotate_extrude() translate([24, -2.5]) polygon([[0, 0], [3.5, 0], [3.5, 6], [0, 2.5]]);
  /* top chamfer ring cut */
  rotate_extrude() translate([9, 50]) polygon([[0, 0], [3.5, -3.5], [3.5, 2.5], [0, 2.5]]);
  /* circlip groove just behind the shoulder */
  rotate_extrude() translate([groove_r - groove_d, groove_z]) square([groove_d + 2.5, groove_w]);
  /* cross pin hole through the small step */
  translate([0, 0, cross_z]) rotate([90, 0, 0]) cylinder(h = d3 + 5, d = cross_d, center = true);
}
