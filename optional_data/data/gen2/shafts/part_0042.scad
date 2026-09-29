$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 50, 25, 12 mm, 50 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 50;                  // step 1 diameter
len1 = 25;                // step 1 length
d2 = 25;                  // step 2 diameter
len2 = 10;                // step 2 length
d3 = 12;                  // step 3 diameter
len3 = 15;                // step 3 length
total = 50;               // overall length
chamfer = 1.5;            // end chamfer
groove_r = 6;             // groove radius
groove_z = 37;            // groove position from the end
groove_w = 2.5;           // groove width
groove_d = 1.6;           // groove depth

difference() {
  /* turned body: stacked cylinders, every step sunk into the bigger one */
  union() {
    cylinder(h = len1, d = d1);
    translate([0, 0, 24.6]) cylinder(h = 10.4, d = d2);
    translate([0, 0, 34.6]) cylinder(h = 15.4, d = d3);
  }
  /* bottom chamfer ring cut */
  rotate_extrude() translate([23.5, -2.5]) polygon([[0, 0], [4, 0], [4, 6.5], [0, 2.5]]);
  /* top chamfer ring cut */
  rotate_extrude() translate([4.5, 50]) polygon([[0, 0], [4, -4], [4, 2.5], [0, 2.5]]);
  /* circlip groove just behind the shoulder */
  rotate_extrude() translate([groove_r - groove_d, groove_z]) square([groove_d + 2.5, groove_w]);
}
