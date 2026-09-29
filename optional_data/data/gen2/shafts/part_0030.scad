$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 50, 40, 12, 10, 8 mm, 80 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 50;                  // step 1 diameter
len1 = 10;                // step 1 length
d2 = 40;                  // step 2 diameter
len2 = 10;                // step 2 length
d3 = 12;                  // step 3 diameter
len3 = 15;                // step 3 length
d4 = 10;                  // step 4 diameter
len4 = 15;                // step 4 length
d5 = 8;                   // step 5 diameter
len5 = 30;                // step 5 length
total = 80;               // overall length
chamfer = 2.5;            // end chamfer
groove_r = 5;             // groove radius
groove_z = 37;            // groove position from the end
groove_w = 2;             // groove width
groove_d = 2;             // groove depth

difference() {
  /* turned body: stacked cylinders, every step sunk into the bigger one */
  union() {
    cylinder(h = len1, d = d1);
    translate([0, 0, 9.6]) cylinder(h = 10.4, d = d2);
    translate([0, 0, 19.6]) cylinder(h = 15.4, d = d3);
    translate([0, 0, 34.6]) cylinder(h = 15.4, d = d4);
    translate([0, 0, 49.6]) cylinder(h = 30.4, d = d5);
  }
  /* bottom chamfer ring cut */
  rotate_extrude() translate([22.5, -2.5]) polygon([[0, 0], [5, 0], [5, 7.5], [0, 2.5]]);
  /* top chamfer ring cut */
  rotate_extrude() translate([1.5, 80]) polygon([[0, 0], [5, -5], [5, 2.5], [0, 2.5]]);
  /* circlip groove just behind the shoulder */
  rotate_extrude() translate([groove_r - groove_d, groove_z]) square([groove_d + 2.5, groove_w]);
}
