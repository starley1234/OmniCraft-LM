$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 50, 16, 14, 10, 8 mm, 105 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 50;                  // step 1 diameter
len1 = 20;                // step 1 length
d2 = 16;                  // step 2 diameter
len2 = 30;                // step 2 length
d3 = 14;                  // step 3 diameter
len3 = 20;                // step 3 length
d4 = 10;                  // step 4 diameter
len4 = 15;                // step 4 length
d5 = 8;                   // step 5 diameter
len5 = 20;                // step 5 length
total = 105;              // overall length
chamfer = 1;              // end chamfer
groove_r = 4;             // groove radius
groove_z = 87;            // groove position from the end
groove_w = 3.5;           // groove width
groove_d = 1;             // groove depth

difference() {
  /* turned body: stacked cylinders, every step sunk into the bigger one */
  union() {
    cylinder(h = len1, d = d1);
    translate([0, 0, 19.6]) cylinder(h = 30.4, d = d2);
    translate([0, 0, 49.6]) cylinder(h = 20.4, d = d3);
    translate([0, 0, 69.6]) cylinder(h = 15.4, d = d4);
    translate([0, 0, 84.6]) cylinder(h = 20.4, d = d5);
  }
  /* bottom chamfer ring cut */
  rotate_extrude() translate([24, -2.5]) polygon([[0, 0], [3.5, 0], [3.5, 6], [0, 2.5]]);
  /* top chamfer ring cut */
  rotate_extrude() translate([3, 105]) polygon([[0, 0], [3.5, -3.5], [3.5, 2.5], [0, 2.5]]);
  /* circlip groove just behind the shoulder */
  rotate_extrude() translate([groove_r - groove_d, groove_z]) square([groove_d + 2.5, groove_w]);
}
