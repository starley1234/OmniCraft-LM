$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 50, 20, 14, 8 mm, 120 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 50;                  // step 1 diameter
len1 = 40;                // step 1 length
d2 = 20;                  // step 2 diameter
len2 = 40;                // step 2 length
d3 = 14;                  // step 3 diameter
len3 = 10;                // step 3 length
d4 = 8;                   // step 4 diameter
len4 = 30;                // step 4 length
total = 120;              // overall length
chamfer = 2.5;            // end chamfer
groove_r = 4;             // groove radius
groove_z = 92;            // groove position from the end
groove_w = 2.5;           // groove width
groove_d = 1.4;           // groove depth

difference() {
  /* turned body: stacked cylinders, every step sunk into the bigger one */
  union() {
    cylinder(h = len1, d = d1);
    translate([0, 0, 39.6]) cylinder(h = 40.4, d = d2);
    translate([0, 0, 79.6]) cylinder(h = 10.4, d = d3);
    translate([0, 0, 89.6]) cylinder(h = 30.4, d = d4);
  }
  /* bottom chamfer ring cut */
  rotate_extrude() translate([22.5, -2.5]) polygon([[0, 0], [5, 0], [5, 7.5], [0, 2.5]]);
  /* top chamfer ring cut */
  rotate_extrude() translate([1.5, 120]) polygon([[0, 0], [5, -5], [5, 2.5], [0, 2.5]]);
  /* circlip groove just behind the shoulder */
  rotate_extrude() translate([groove_r - groove_d, groove_z]) square([groove_d + 2.5, groove_w]);
}
