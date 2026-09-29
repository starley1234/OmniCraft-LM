$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 50, 40, 30, 14 mm, 95 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 50;                  // step 1 diameter
len1 = 15;                // step 1 length
d2 = 40;                  // step 2 diameter
len2 = 15;                // step 2 length
d3 = 30;                  // step 3 diameter
len3 = 40;                // step 3 length
d4 = 14;                  // step 4 diameter
len4 = 25;                // step 4 length
total = 95;               // overall length
chamfer = 2.5;            // end chamfer
groove_r = 15;            // groove radius
groove_z = 32;            // groove position from the end
groove_w = 3;             // groove width
groove_d = 1.3;           // groove depth

difference() {
  /* turned body: stacked cylinders, every step sunk into the bigger one */
  union() {
    cylinder(h = len1, d = d1);
    translate([0, 0, 14.6]) cylinder(h = 15.4, d = d2);
    translate([0, 0, 29.6]) cylinder(h = 40.4, d = d3);
    translate([0, 0, 69.6]) cylinder(h = 25.4, d = d4);
  }
  /* bottom chamfer ring cut */
  rotate_extrude() translate([22.5, -2.5]) polygon([[0, 0], [5, 0], [5, 7.5], [0, 2.5]]);
  /* top chamfer ring cut */
  rotate_extrude() translate([4.5, 95]) polygon([[0, 0], [5, -5], [5, 2.5], [0, 2.5]]);
  /* circlip groove just behind the shoulder */
  rotate_extrude() translate([groove_r - groove_d, groove_z]) square([groove_d + 2.5, groove_w]);
}
