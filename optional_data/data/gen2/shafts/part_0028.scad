$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 50, 16, 10, 8 mm, 70 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 50;                  // step 1 diameter
len1 = 30;                // step 1 length
d2 = 16;                  // step 2 diameter
len2 = 15;                // step 2 length
d3 = 10;                  // step 3 diameter
len3 = 10;                // step 3 length
d4 = 8;                   // step 4 diameter
len4 = 15;                // step 4 length
total = 70;               // overall length
chamfer = 2.5;            // end chamfer
groove_r = 8;             // groove radius
groove_z = 32;            // groove position from the end
groove_w = 2.5;           // groove width
groove_d = 1.3;           // groove depth
cross_d = 4;              // cross pin hole
cross_z = 62.5;           // cross hole position

difference() {
  /* turned body: stacked cylinders, every step sunk into the bigger one */
  union() {
    cylinder(h = len1, d = d1);
    translate([0, 0, 29.6]) cylinder(h = 15.4, d = d2);
    translate([0, 0, 44.6]) cylinder(h = 10.4, d = d3);
    translate([0, 0, 54.6]) cylinder(h = 15.4, d = d4);
  }
  /* bottom chamfer ring cut */
  rotate_extrude() translate([22.5, -2.5]) polygon([[0, 0], [5, 0], [5, 7.5], [0, 2.5]]);
  /* top chamfer ring cut */
  rotate_extrude() translate([1.5, 70]) polygon([[0, 0], [5, -5], [5, 2.5], [0, 2.5]]);
  /* circlip groove just behind the shoulder */
  rotate_extrude() translate([groove_r - groove_d, groove_z]) square([groove_d + 2.5, groove_w]);
  /* cross pin hole through the small step */
  translate([0, 0, cross_z]) rotate([90, 0, 0]) cylinder(h = d4 + 5, d = cross_d, center = true);
}
