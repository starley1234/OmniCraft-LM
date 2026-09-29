$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 40, 10, 8 mm, 80 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 40;                  // step 1 diameter
len1 = 10;                // step 1 length
d2 = 10;                  // step 2 diameter
len2 = 30;                // step 2 length
d3 = 8;                   // step 3 diameter
len3 = 40;                // step 3 length
total = 80;               // overall length
chamfer = 1;              // end chamfer
groove_r = 5;             // groove radius
groove_z = 12;            // groove position from the end
groove_w = 2;             // groove width
groove_d = 2;             // groove depth

difference() {
  /* turned body: stacked cylinders, every step sunk into the bigger one */
  union() {
    cylinder(h = len1, d = d1);
    translate([0, 0, 9.6]) cylinder(h = 30.4, d = d2);
    translate([0, 0, 39.6]) cylinder(h = 40.4, d = d3);
  }
  /* bottom chamfer ring cut */
  rotate_extrude() translate([19, -2.5]) polygon([[0, 0], [3.5, 0], [3.5, 6], [0, 2.5]]);
  /* top chamfer ring cut */
  rotate_extrude() translate([3, 80]) polygon([[0, 0], [3.5, -3.5], [3.5, 2.5], [0, 2.5]]);
  /* circlip groove just behind the shoulder */
  rotate_extrude() translate([groove_r - groove_d, groove_z]) square([groove_d + 2.5, groove_w]);
}
