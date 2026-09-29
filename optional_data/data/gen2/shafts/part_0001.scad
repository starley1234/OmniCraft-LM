$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 50, 30, 25, 10 mm, 55 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 50;                  // step 1 diameter
len1 = 15;                // step 1 length
d2 = 30;                  // step 2 diameter
len2 = 10;                // step 2 length
d3 = 25;                  // step 3 diameter
len3 = 15;                // step 3 length
d4 = 10;                  // step 4 diameter
len4 = 15;                // step 4 length
total = 55;               // overall length
chamfer = 2;              // end chamfer
groove_r = 5;             // groove radius
groove_z = 42;            // groove position from the end
groove_w = 2.5;           // groove width
groove_d = 2;             // groove depth

difference() {
  /* turned body: stacked cylinders, every step sunk into the bigger one */
  union() {
    cylinder(h = len1, d = d1);
    translate([0, 0, 14.6]) cylinder(h = 10.4, d = d2);
    translate([0, 0, 24.6]) cylinder(h = 15.4, d = d3);
    translate([0, 0, 39.6]) cylinder(h = 15.4, d = d4);
  }
  /* bottom chamfer ring cut */
  rotate_extrude() translate([23, -2.5]) polygon([[0, 0], [4.5, 0], [4.5, 7], [0, 2.5]]);
  /* top chamfer ring cut */
  rotate_extrude() translate([3, 55]) polygon([[0, 0], [4.5, -4.5], [4.5, 2.5], [0, 2.5]]);
  /* circlip groove just behind the shoulder */
  rotate_extrude() translate([groove_r - groove_d, groove_z]) square([groove_d + 2.5, groove_w]);
}
