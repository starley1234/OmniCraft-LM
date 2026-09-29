$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 40, 30, 20, 10 mm, 90 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 40;                  // step 1 diameter
len1 = 30;                // step 1 length
d2 = 30;                  // step 2 diameter
len2 = 15;                // step 2 length
d3 = 20;                  // step 3 diameter
len3 = 30;                // step 3 length
d4 = 10;                  // step 4 diameter
len4 = 15;                // step 4 length
total = 90;               // overall length
chamfer = 1;              // end chamfer

difference() {
  /* turned body: stacked cylinders, every step sunk into the bigger one */
  union() {
    cylinder(h = len1, d = d1);
    translate([0, 0, 29.6]) cylinder(h = 15.4, d = d2);
    translate([0, 0, 44.6]) cylinder(h = 30.4, d = d3);
    translate([0, 0, 74.6]) cylinder(h = 15.4, d = d4);
  }
  /* bottom chamfer ring cut */
  rotate_extrude() translate([19, -2.5]) polygon([[0, 0], [3.5, 0], [3.5, 6], [0, 2.5]]);
  /* top chamfer ring cut */
  rotate_extrude() translate([4, 90]) polygon([[0, 0], [3.5, -3.5], [3.5, 2.5], [0, 2.5]]);
}
