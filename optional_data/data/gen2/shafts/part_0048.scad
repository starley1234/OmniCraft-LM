$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 40, 25, 14, 10 mm, 110 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 40;                  // step 1 diameter
len1 = 40;                // step 1 length
d2 = 25;                  // step 2 diameter
len2 = 25;                // step 2 length
d3 = 14;                  // step 3 diameter
len3 = 30;                // step 3 length
d4 = 10;                  // step 4 diameter
len4 = 15;                // step 4 length
total = 110;              // overall length
chamfer = 2.5;            // end chamfer

difference() {
  /* turned body: stacked cylinders, every step sunk into the bigger one */
  union() {
    cylinder(h = len1, d = d1);
    translate([0, 0, 39.6]) cylinder(h = 25.4, d = d2);
    translate([0, 0, 64.6]) cylinder(h = 30.4, d = d3);
    translate([0, 0, 94.6]) cylinder(h = 15.4, d = d4);
  }
  /* bottom chamfer ring cut */
  rotate_extrude() translate([17.5, -2.5]) polygon([[0, 0], [5, 0], [5, 7.5], [0, 2.5]]);
  /* top chamfer ring cut */
  rotate_extrude() translate([2.5, 110]) polygon([[0, 0], [5, -5], [5, 2.5], [0, 2.5]]);
}
