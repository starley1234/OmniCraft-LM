$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 50, 16, 14, 10 mm, 80 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 50;                  // step 1 diameter
len1 = 10;                // step 1 length
d2 = 16;                  // step 2 diameter
len2 = 30;                // step 2 length
d3 = 14;                  // step 3 diameter
len3 = 10;                // step 3 length
d4 = 10;                  // step 4 diameter
len4 = 30;                // step 4 length
total = 80;               // overall length
chamfer = 1;              // end chamfer
groove_r = 7;             // groove radius
groove_z = 42;            // groove position from the end
groove_w = 3.5;           // groove width
groove_d = 1.6;           // groove depth

difference() {
  /* turned body: stacked cylinders, every step sunk into the bigger one */
  union() {
    cylinder(h = len1, d = d1);
    translate([0, 0, 9.6]) cylinder(h = 30.4, d = d2);
    translate([0, 0, 39.6]) cylinder(h = 10.4, d = d3);
    translate([0, 0, 49.6]) cylinder(h = 30.4, d = d4);
  }
  /* bottom chamfer ring cut */
  rotate_extrude() translate([24, -2.5]) polygon([[0, 0], [3.5, 0], [3.5, 6], [0, 2.5]]);
  /* top chamfer ring cut */
  rotate_extrude() translate([4, 80]) polygon([[0, 0], [3.5, -3.5], [3.5, 2.5], [0, 2.5]]);
  /* circlip groove just behind the shoulder */
  rotate_extrude() translate([groove_r - groove_d, groove_z]) square([groove_d + 2.5, groove_w]);
}
