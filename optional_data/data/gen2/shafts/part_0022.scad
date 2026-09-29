$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 40, 25, 16, 12 mm, 95 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 40;                  // step 1 diameter
len1 = 25;                // step 1 length
d2 = 25;                  // step 2 diameter
len2 = 10;                // step 2 length
d3 = 16;                  // step 3 diameter
len3 = 40;                // step 3 length
d4 = 12;                  // step 4 diameter
len4 = 20;                // step 4 length
total = 95;               // overall length
chamfer = 2;              // end chamfer
groove_r = 12.5;          // groove radius
groove_z = 27;            // groove position from the end
groove_w = 3.5;           // groove width
groove_d = 1.3;           // groove depth
cross_d = 6;              // cross pin hole
cross_z = 85;             // cross hole position

difference() {
  /* turned body: stacked cylinders, every step sunk into the bigger one */
  union() {
    cylinder(h = len1, d = d1);
    translate([0, 0, 24.6]) cylinder(h = 10.4, d = d2);
    translate([0, 0, 34.6]) cylinder(h = 40.4, d = d3);
    translate([0, 0, 74.6]) cylinder(h = 20.4, d = d4);
  }
  /* bottom chamfer ring cut */
  rotate_extrude() translate([18, -2.5]) polygon([[0, 0], [4.5, 0], [4.5, 7], [0, 2.5]]);
  /* top chamfer ring cut */
  rotate_extrude() translate([4, 95]) polygon([[0, 0], [4.5, -4.5], [4.5, 2.5], [0, 2.5]]);
  /* circlip groove just behind the shoulder */
  rotate_extrude() translate([groove_r - groove_d, groove_z]) square([groove_d + 2.5, groove_w]);
  /* cross pin hole through the small step */
  translate([0, 0, cross_z]) rotate([90, 0, 0]) cylinder(h = d4 + 5, d = cross_d, center = true);
}
