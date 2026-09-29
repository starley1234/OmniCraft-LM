$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 14, 10, 8 mm, 85 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 14;                  // step 1 diameter
len1 = 30;                // step 1 length
d2 = 10;                  // step 2 diameter
len2 = 25;                // step 2 length
d3 = 8;                   // step 3 diameter
len3 = 30;                // step 3 length
total = 85;               // overall length
chamfer = 1;              // end chamfer
groove_r = 4;             // groove radius
groove_z = 57;            // groove position from the end
groove_w = 2;             // groove width
groove_d = 1.3;           // groove depth

difference() {
  /* turned body: stacked cylinders, every step sunk into the bigger one */
  union() {
    cylinder(h = len1, d = d1);
    translate([0, 0, 29.6]) cylinder(h = 25.4, d = d2);
    translate([0, 0, 54.6]) cylinder(h = 30.4, d = d3);
  }
  /* bottom chamfer ring cut */
  rotate_extrude() translate([6, -2.5]) polygon([[0, 0], [3.5, 0], [3.5, 6], [0, 2.5]]);
  /* top chamfer ring cut */
  rotate_extrude() translate([3, 85]) polygon([[0, 0], [3.5, -3.5], [3.5, 2.5], [0, 2.5]]);
  /* circlip groove just behind the shoulder */
  rotate_extrude() translate([groove_r - groove_d, groove_z]) square([groove_d + 2.5, groove_w]);
}
