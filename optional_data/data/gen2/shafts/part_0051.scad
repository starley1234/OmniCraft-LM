$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 40, 30, 25, 16, 12 mm, 110 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 40;                  // step 1 diameter
len1 = 10;                // step 1 length
d2 = 30;                  // step 2 diameter
len2 = 10;                // step 2 length
d3 = 25;                  // step 3 diameter
len3 = 30;                // step 3 length
d4 = 16;                  // step 4 diameter
len4 = 20;                // step 4 length
d5 = 12;                  // step 5 diameter
len5 = 40;                // step 5 length
total = 110;              // overall length
chamfer = 2;              // end chamfer
groove_r = 6;             // groove radius
groove_z = 72;            // groove position from the end
groove_w = 3;             // groove width
groove_d = 1.3;           // groove depth

difference() {
  /* turned body: stacked cylinders, every step sunk into the bigger one */
  union() {
    cylinder(h = len1, d = d1);
    translate([0, 0, 9.6]) cylinder(h = 10.4, d = d2);
    translate([0, 0, 19.6]) cylinder(h = 30.4, d = d3);
    translate([0, 0, 49.6]) cylinder(h = 20.4, d = d4);
    translate([0, 0, 69.6]) cylinder(h = 40.4, d = d5);
  }
  /* bottom chamfer ring cut */
  rotate_extrude() translate([18, -2.5]) polygon([[0, 0], [4.5, 0], [4.5, 7], [0, 2.5]]);
  /* top chamfer ring cut */
  rotate_extrude() translate([4, 110]) polygon([[0, 0], [4.5, -4.5], [4.5, 2.5], [0, 2.5]]);
  /* circlip groove just behind the shoulder */
  rotate_extrude() translate([groove_r - groove_d, groove_z]) square([groove_d + 2.5, groove_w]);
}
