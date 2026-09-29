$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 40, 20, 16, 14 mm, 90 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 40;                  // step 1 diameter
len1 = 30;                // step 1 length
d2 = 20;                  // step 2 diameter
len2 = 15;                // step 2 length
d3 = 16;                  // step 3 diameter
len3 = 25;                // step 3 length
d4 = 14;                  // step 4 diameter
len4 = 20;                // step 4 length
total = 90;               // overall length
chamfer = 1.5;            // end chamfer

difference() {
  /* turned body: stacked cylinders, every step sunk into the bigger one */
  union() {
    cylinder(h = len1, d = d1);
    translate([0, 0, 29.6]) cylinder(h = 15.4, d = d2);
    translate([0, 0, 44.6]) cylinder(h = 25.4, d = d3);
    translate([0, 0, 69.6]) cylinder(h = 20.4, d = d4);
  }
  /* bottom chamfer ring cut */
  rotate_extrude() translate([18.5, -2.5]) polygon([[0, 0], [4, 0], [4, 6.5], [0, 2.5]]);
  /* top chamfer ring cut */
  rotate_extrude() translate([5.5, 90]) polygon([[0, 0], [4, -4], [4, 2.5], [0, 2.5]]);
}
