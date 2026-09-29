$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 40, 20, 12 mm, 80 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 40;                  // step 1 diameter
len1 = 30;                // step 1 length
d2 = 20;                  // step 2 diameter
len2 = 25;                // step 2 length
d3 = 12;                  // step 3 diameter
len3 = 25;                // step 3 length
total = 80;               // overall length
chamfer = 2.5;            // end chamfer

difference() {
  /* turned body: stacked cylinders, every step sunk into the bigger one */
  union() {
    cylinder(h = len1, d = d1);
    translate([0, 0, 29.6]) cylinder(h = 25.4, d = d2);
    translate([0, 0, 54.6]) cylinder(h = 25.4, d = d3);
  }
  /* bottom chamfer ring cut */
  rotate_extrude() translate([17.5, -2.5]) polygon([[0, 0], [5, 0], [5, 7.5], [0, 2.5]]);
  /* top chamfer ring cut */
  rotate_extrude() translate([3.5, 80]) polygon([[0, 0], [5, -5], [5, 2.5], [0, 2.5]]);
}
