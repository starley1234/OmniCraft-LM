$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 40, 20, 16 mm, 65 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 40;                  // step 1 diameter
len1 = 25;                // step 1 length
d2 = 20;                  // step 2 diameter
len2 = 15;                // step 2 length
d3 = 16;                  // step 3 diameter
len3 = 25;                // step 3 length
total = 65;               // overall length
chamfer = 1.5;            // end chamfer
groove_r = 10;            // groove radius
groove_z = 27;            // groove position from the end
groove_w = 3.5;           // groove width
groove_d = 1;             // groove depth

difference() {
  /* turned body: stacked cylinders, every step sunk into the bigger one */
  union() {
    cylinder(h = len1, d = d1);
    translate([0, 0, 24.6]) cylinder(h = 15.4, d = d2);
    translate([0, 0, 39.6]) cylinder(h = 25.4, d = d3);
  }
  /* bottom chamfer ring cut */
  rotate_extrude() translate([18.5, -2.5]) polygon([[0, 0], [4, 0], [4, 6.5], [0, 2.5]]);
  /* top chamfer ring cut */
  rotate_extrude() translate([6.5, 65]) polygon([[0, 0], [4, -4], [4, 2.5], [0, 2.5]]);
  /* circlip groove just behind the shoulder */
  rotate_extrude() translate([groove_r - groove_d, groove_z]) square([groove_d + 2.5, groove_w]);
}
