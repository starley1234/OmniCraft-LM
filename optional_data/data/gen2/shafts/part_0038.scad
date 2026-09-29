$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 50, 40, 25, 20, 10 mm, 90 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 50;                  // step 1 diameter
len1 = 25;                // step 1 length
d2 = 40;                  // step 2 diameter
len2 = 20;                // step 2 length
d3 = 25;                  // step 3 diameter
len3 = 25;                // step 3 length
d4 = 20;                  // step 4 diameter
len4 = 10;                // step 4 length
d5 = 10;                  // step 5 diameter
len5 = 10;                // step 5 length
total = 90;               // overall length
chamfer = 1.5;            // end chamfer

difference() {
  /* turned body: stacked cylinders, every step sunk into the bigger one */
  union() {
    cylinder(h = len1, d = d1);
    translate([0, 0, 24.6]) cylinder(h = 20.4, d = d2);
    translate([0, 0, 44.6]) cylinder(h = 25.4, d = d3);
    translate([0, 0, 69.6]) cylinder(h = 10.4, d = d4);
    translate([0, 0, 79.6]) cylinder(h = 10.4, d = d5);
  }
  /* bottom chamfer ring cut */
  rotate_extrude() translate([23.5, -2.5]) polygon([[0, 0], [4, 0], [4, 6.5], [0, 2.5]]);
  /* top chamfer ring cut */
  rotate_extrude() translate([3.5, 90]) polygon([[0, 0], [4, -4], [4, 2.5], [0, 2.5]]);
}
