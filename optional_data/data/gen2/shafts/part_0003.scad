$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 25, 14, 12, 8 mm, 60 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 25;                  // step 1 diameter
len1 = 10;                // step 1 length
d2 = 14;                  // step 2 diameter
len2 = 15;                // step 2 length
d3 = 12;                  // step 3 diameter
len3 = 25;                // step 3 length
d4 = 8;                   // step 4 diameter
len4 = 10;                // step 4 length
total = 60;               // overall length
chamfer = 2;              // end chamfer

difference() {
  /* turned body: stacked cylinders, every step sunk into the bigger one */
  union() {
    cylinder(h = len1, d = d1);
    translate([0, 0, 9.6]) cylinder(h = 15.4, d = d2);
    translate([0, 0, 24.6]) cylinder(h = 25.4, d = d3);
    translate([0, 0, 49.6]) cylinder(h = 10.4, d = d4);
  }
  /* bottom chamfer ring cut */
  rotate_extrude() translate([10.5, -2.5]) polygon([[0, 0], [4.5, 0], [4.5, 7], [0, 2.5]]);
  /* top chamfer ring cut */
  rotate_extrude() translate([2, 60]) polygon([[0, 0], [4.5, -4.5], [4.5, 2.5], [0, 2.5]]);
}
