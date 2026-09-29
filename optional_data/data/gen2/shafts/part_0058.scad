$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 30, 25, 20, 8 mm, 75 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 30;                  // step 1 diameter
len1 = 15;                // step 1 length
d2 = 25;                  // step 2 diameter
len2 = 20;                // step 2 length
d3 = 20;                  // step 3 diameter
len3 = 10;                // step 3 length
d4 = 8;                   // step 4 diameter
len4 = 30;                // step 4 length
total = 75;               // overall length
chamfer = 2;              // end chamfer

difference() {
  /* turned body: stacked cylinders, every step sunk into the bigger one */
  union() {
    cylinder(h = len1, d = d1);
    translate([0, 0, 14.6]) cylinder(h = 20.4, d = d2);
    translate([0, 0, 34.6]) cylinder(h = 10.4, d = d3);
    translate([0, 0, 44.6]) cylinder(h = 30.4, d = d4);
  }
  /* bottom chamfer ring cut */
  rotate_extrude() translate([13, -2.5]) polygon([[0, 0], [4.5, 0], [4.5, 7], [0, 2.5]]);
  /* top chamfer ring cut */
  rotate_extrude() translate([2, 75]) polygon([[0, 0], [4.5, -4.5], [4.5, 2.5], [0, 2.5]]);
}
