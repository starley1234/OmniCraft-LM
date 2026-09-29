$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 50, 30, 25, 16 mm, 115 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 50;                  // step 1 diameter
len1 = 30;                // step 1 length
d2 = 30;                  // step 2 diameter
len2 = 40;                // step 2 length
d3 = 25;                  // step 3 diameter
len3 = 25;                // step 3 length
d4 = 16;                  // step 4 diameter
len4 = 20;                // step 4 length
total = 115;              // overall length
chamfer = 1.5;            // end chamfer
groove_r = 8;             // groove radius
groove_z = 97;            // groove position from the end
groove_w = 2;             // groove width
groove_d = 1.3;           // groove depth

difference() {
  /* turned body: stacked cylinders, every step sunk into the bigger one */
  union() {
    cylinder(h = len1, d = d1);
    translate([0, 0, 29.6]) cylinder(h = 40.4, d = d2);
    translate([0, 0, 69.6]) cylinder(h = 25.4, d = d3);
    translate([0, 0, 94.6]) cylinder(h = 20.4, d = d4);
  }
  /* bottom chamfer ring cut */
  rotate_extrude() translate([23.5, -2.5]) polygon([[0, 0], [4, 0], [4, 6.5], [0, 2.5]]);
  /* top chamfer ring cut */
  rotate_extrude() translate([6.5, 115]) polygon([[0, 0], [4, -4], [4, 2.5], [0, 2.5]]);
  /* circlip groove just behind the shoulder */
  rotate_extrude() translate([groove_r - groove_d, groove_z]) square([groove_d + 2.5, groove_w]);
}
