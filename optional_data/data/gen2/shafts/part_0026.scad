$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 30, 16, 14, 12, 10 mm, 105 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 30;                  // step 1 diameter
len1 = 25;                // step 1 length
d2 = 16;                  // step 2 diameter
len2 = 30;                // step 2 length
d3 = 14;                  // step 3 diameter
len3 = 10;                // step 3 length
d4 = 12;                  // step 4 diameter
len4 = 30;                // step 4 length
d5 = 10;                  // step 5 diameter
len5 = 10;                // step 5 length
total = 105;              // overall length
chamfer = 1.5;            // end chamfer
groove_r = 7;             // groove radius
groove_z = 57;            // groove position from the end
groove_w = 3;             // groove width
groove_d = 1;             // groove depth

difference() {
  /* turned body: stacked cylinders, every step sunk into the bigger one */
  union() {
    cylinder(h = len1, d = d1);
    translate([0, 0, 24.6]) cylinder(h = 30.4, d = d2);
    translate([0, 0, 54.6]) cylinder(h = 10.4, d = d3);
    translate([0, 0, 64.6]) cylinder(h = 30.4, d = d4);
    translate([0, 0, 94.6]) cylinder(h = 10.4, d = d5);
  }
  /* bottom chamfer ring cut */
  rotate_extrude() translate([13.5, -2.5]) polygon([[0, 0], [4, 0], [4, 6.5], [0, 2.5]]);
  /* top chamfer ring cut */
  rotate_extrude() translate([3.5, 105]) polygon([[0, 0], [4, -4], [4, 2.5], [0, 2.5]]);
  /* circlip groove just behind the shoulder */
  rotate_extrude() translate([groove_r - groove_d, groove_z]) square([groove_d + 2.5, groove_w]);
}
