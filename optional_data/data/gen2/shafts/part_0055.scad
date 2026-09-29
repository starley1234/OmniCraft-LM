$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 40, 25, 16, 12, 8 mm, 100 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 40;                  // step 1 diameter
len1 = 20;                // step 1 length
d2 = 25;                  // step 2 diameter
len2 = 40;                // step 2 length
d3 = 16;                  // step 3 diameter
len3 = 10;                // step 3 length
d4 = 12;                  // step 4 diameter
len4 = 10;                // step 4 length
d5 = 8;                   // step 5 diameter
len5 = 20;                // step 5 length
total = 100;              // overall length
chamfer = 1.5;            // end chamfer

difference() {
  /* turned body: stacked cylinders, every step sunk into the bigger one */
  union() {
    cylinder(h = len1, d = d1);
    translate([0, 0, 19.6]) cylinder(h = 40.4, d = d2);
    translate([0, 0, 59.6]) cylinder(h = 10.4, d = d3);
    translate([0, 0, 69.6]) cylinder(h = 10.4, d = d4);
    translate([0, 0, 79.6]) cylinder(h = 20.4, d = d5);
  }
  /* bottom chamfer ring cut */
  rotate_extrude() translate([18.5, -2.5]) polygon([[0, 0], [4, 0], [4, 6.5], [0, 2.5]]);
  /* top chamfer ring cut */
  rotate_extrude() translate([2.5, 100]) polygon([[0, 0], [4, -4], [4, 2.5], [0, 2.5]]);
}
