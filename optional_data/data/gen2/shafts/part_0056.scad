$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 50, 40, 8 mm, 70 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 50;                  // step 1 diameter
len1 = 15;                // step 1 length
d2 = 40;                  // step 2 diameter
len2 = 25;                // step 2 length
d3 = 8;                   // step 3 diameter
len3 = 30;                // step 3 length
total = 70;               // overall length
chamfer = 2;              // end chamfer
groove_r = 20;            // groove radius
groove_z = 17;            // groove position from the end
groove_w = 2.5;           // groove width
groove_d = 1.6;           // groove depth

difference() {
  /* turned body: stacked cylinders, every step sunk into the bigger one */
  union() {
    cylinder(h = len1, d = d1);
    translate([0, 0, 14.6]) cylinder(h = 25.4, d = d2);
    translate([0, 0, 39.6]) cylinder(h = 30.4, d = d3);
  }
  /* bottom chamfer ring cut */
  rotate_extrude() translate([23, -2.5]) polygon([[0, 0], [4.5, 0], [4.5, 7], [0, 2.5]]);
  /* top chamfer ring cut */
  rotate_extrude() translate([2, 70]) polygon([[0, 0], [4.5, -4.5], [4.5, 2.5], [0, 2.5]]);
  /* circlip groove just behind the shoulder */
  rotate_extrude() translate([groove_r - groove_d, groove_z]) square([groove_d + 2.5, groove_w]);
}
